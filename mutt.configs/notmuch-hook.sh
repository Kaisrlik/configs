#!/bin/sh
notmuch new
# retag all "new" messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new
# tag all messages from "me" as sent and remove tags inbox and unread
notmuch tag -new -inbox +sent -- from:jan.kaisrlik@intel.com or from:ja.kaisrlik@gmail.com
# tag newsletters, but dont show them in inbox
notmuch tag +newsletters +unread -new -- subject:'newsletter*'
