CURDIR = $(shell pwd)

install:
	ln -sf $(CURDIR)/ssh-agent.service  ~/.config/systemd/ssh-agent.service
	systemctl --user enable ssh-agent.service
	ln -sf $(CURDIR)/suspend.service ~/.config/systemd/suspend.service
	systemctl --user enable suspend.service

packages:

download:
