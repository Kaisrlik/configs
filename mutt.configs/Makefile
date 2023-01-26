CURDIR = $(shell pwd)

install:
	ln -sf $(CURDIR)/muttrc ~/.muttrc
	ln -sf $(CURDIR)/mbsyncrc ~/.mbsyncrc
	ln -sf $(CURDIR)/notmuch-config ~/.notmuch-config
	mkdir -p ~/.config/systemd/user
	cp $(CURDIR)/mail-sync.service ~/.config/systemd/user/mail-sync.service
	cp $(CURDIR)/mail-sync.timer ~/.config/systemd/user/mail-sync.timer
	systemctl --user enable mail-sync.timer

download:

packages:
	sudo apt-get install neomutt isync abook
