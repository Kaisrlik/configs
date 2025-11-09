CURDIR = $(shell pwd)

install:
	mkdir -p ~/.config
	rm -rf ~/.config/i3
	touch ~/.config/i3
	ln -sf $(CURDIR) ~/.config/i3

download:

packages:
	sudo apt-get install sway i3blocks libnotify-bin swaylock
