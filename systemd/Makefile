CURDIR = $(shell pwd)

install:
	mkdir -p ~/.config/systemd/user
	cp $(CURDIR)/ssh-agent.service  ~/.config/systemd/user/ssh-agent-user.service
	systemctl --user enable ssh-agent-user.service
	cp $(CURDIR)/suspend.service ~/.config/systemd/user/suspend.service
	systemctl --user enable suspend.service

packages:

download:
