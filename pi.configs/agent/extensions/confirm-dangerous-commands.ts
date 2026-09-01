/**
 * Confirm Dangerous Commands Extension
 *
 * Prompts for confirmation before executing potentially destructive operations:
 * - File deletion: rm, rm -r, rm -rf
 * - Force operations: git push --force, git reset --hard
 * - Privilege escalation: sudo
 * - Dangerous permissions: chmod/chown 777
 * - Mass deletions: git clean, docker system prune
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	// Dangerous bash command patterns
	const dangerousPatterns = [
		{
			pattern: /\brm\s+(-[rf]*r[rf]*|--recursive)/i,
			name: "recursive file deletion (rm -r)",
			severity: "high" as const,
		},
		{
			pattern: /\brm\s+(-[rf]*f|--force)/i,
			name: "forced file deletion (rm -f)",
			severity: "medium" as const,
		},
		{
			pattern: /\bgit\s+push\s+[^|&;]*(-f|--force)/i,
			name: "force push",
			severity: "high" as const,
		},
		{
			pattern: /\bgit\s+reset\s+--hard/i,
			name: "hard reset",
			severity: "high" as const,
		},
		{
			pattern: /\bgit\s+clean\s+(-[dxf]*[df]|--force)/i,
			name: "git clean",
			severity: "medium" as const,
		},
		{
			pattern: /\bsudo\b/i,
			name: "privilege escalation (sudo)",
			severity: "medium" as const,
		},
		{
			pattern: /\b(chmod|chown)\b.*777/i,
			name: "dangerous permissions (777)",
			severity: "medium" as const,
		},
		{
			pattern: /\bdocker\s+system\s+prune/i,
			name: "Docker system prune",
			severity: "medium" as const,
		},
		{
			pattern: /\bnpm\s+publish/i,
			name: "npm publish",
			severity: "high" as const,
		},
		{
			pattern: /\b(mkfs|dd)\b/i,
			name: "disk formatting/writing",
			severity: "critical" as const,
		},
	];

	pi.on("tool_call", async (event, ctx) => {
		// Only intercept bash commands
		if (!isToolCallEventType("bash", event)) {
			return undefined;
		}

		const command = event.input.command;

		// Check for dangerous patterns
		const matches = dangerousPatterns.filter((p) => p.pattern.test(command));

		if (matches.length === 0) {
			return undefined;
		}

		// In non-interactive mode, block high/critical severity commands by default
		if (!ctx.hasUI) {
			const highSeverity = matches.some((m) => m.severity === "high" || m.severity === "critical");
			if (highSeverity) {
				const reasons = matches.map((m) => m.name).join(", ");
				return {
					block: true,
					reason: `Dangerous command blocked (${reasons}) - no UI for confirmation`,
				};
			}
			return undefined;
		}

		// Show confirmation dialog
		const dangerTypes = matches.map((m) => m.name).join(", ");
		const severity = matches.some((m) => m.severity === "critical")
			? "🔴 CRITICAL"
			: matches.some((m) => m.severity === "high")
				? "🟠 HIGH RISK"
				: "⚠️  WARNING";

		// Format command for display (truncate if too long)
		const displayCommand = command.length > 200 ? command.slice(0, 200) + "..." : command;

		const confirmed = await ctx.ui.confirm(
			`${severity}: ${dangerTypes}`,
			`Execute this command?\n\n${displayCommand}`,
		);

		if (!confirmed) {
			ctx.ui.notify("Command blocked by user", "info");
			return {
				block: true,
				reason: "Blocked by user via confirm-dangerous-commands extension",
				terminate: true,
			};
		}

		ctx.ui.notify("Command allowed", "success");
		return undefined;
	});
}
