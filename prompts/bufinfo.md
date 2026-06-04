---
name: Buffer Info
interaction: chat
description: Show buffer information
opts:
  alias: in
  adapter:
    name: copilot
    model: gpt4.5
---

## user

I'm working in buffer ${context.bufnr} which is a ${context.filetype} file.
