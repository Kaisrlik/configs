CURDIR = $(shell pwd)

install: install_systemd
	ln -sf $(CURDIR)/muttrc ~/.muttrc
	ln -sfT $(CURDIR)/configs ~/.mutt/configs
	ln -sf $(CURDIR)/mbsyncrc ~/.mbsyncrc
	ln -sf $(CURDIR)/notmuch-config ~/.notmuch-config
	ln -sf $(CURDIR)/notmuch-hook.sh ~/.mutt/notmuch-hook.sh
	ln -sf $(CURDIR)/mailcap ~/.mutt/mailcap

install_systemd:
	mkdir -p ~/.config/systemd/user
	cp $(CURDIR)/services/mail-sync.service ~/.config/systemd/user/mail-sync.service
	cp $(CURDIR)/services/mail-sync.timer ~/.config/systemd/user/mail-sync.timer
	systemctl --user enable mail-sync.timer

download:

packages:
	sudo apt-get install neomutt isync abook
