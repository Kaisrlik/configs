#!/bin/bash

echo "Initial tagging messages"
notmuch new

echo "Retagging messages"
# immediately archive all messages from "me"
# notmuch tag -new -- tag:new and from:me@example.com

# delete all messages from a spammer:
# notmuch tag +deleted -- tag:new and from:spam@spam.com

# tag all message from notmuch mailing list
notmuch tag +news +intel -- tag:new and from:taryn.ray@intel.org
notmuch tag +intel -- tag:new and to:jan.kaisrlik@intel.com
notmuch tag +intel -- tag:new and from:jan.kaisrlik@intel.com

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
fi
