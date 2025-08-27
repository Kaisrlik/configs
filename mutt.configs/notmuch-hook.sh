#!/usr/bin/env bash

CURDIR=$(dirname -- "$( readlink -f -- "$0"; )")

echo "Tag messages for deletion"
# Mark messages for delete
notmuch tag +deleted date:..30days tag:git

# delete old messages locally
to_delete=$(notmuch search --output=files tag:deleted)
if [[ -n "$to_delete" ]]; then
	echo $to_delete | xargs rm
fi
# Tagging of emails may work as well
# for x in $(notmuch search --output=files tag:deleted) ; do mv $x ${x}T ; done

echo "Initial tagging messages"
notmuch new

echo "Retagging messages"
# immediately archive all messages from "me"
# notmuch tag -new -- tag:new and from:me@example.com

# delete all messages from a spammer:
# notmuch tag +deleted -- tag:new and from:spam@spam.com

# tag all message from notmuch mailing list
"${CURDIR}/../intel.configs/notmuch-hook-intel.sh"

# finally, retag all "new" messages "inbox" and "unread"
notmuch tag +inbox +unread +notify -new -- tag:new

NOTIFY_COUNT=$(notmuch count tag:notify)

if [ "$NOTIFY_COUNT" -gt 0 ]; then
	echo "Sending notification"
	RESULTS=$(notmuch search --format=json --output=summary --limit=3 \
		--sort="newest-first" tag:notify | \
		jq -r '.[] | "<b>\(.authors):</b>\n  \(.subject)\n"')
	notify-send --urgency=low -t 60000 "$NOTIFY_COUNT New Emails:" "$RESULTS"

	notmuch tag -notify -- tag:notify
	pkill -RTMIN+3 i3blocks
fi
