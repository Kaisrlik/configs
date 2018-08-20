PACKAGES=vim.configs i3.configs omzsh.configs

.PHONY: $(PACKAGES)

all:
	git submodule update --init --recursive
	make download
	sudo make packages
	make install

download: $(addsuffix _download, $(PACKAGES))

install: $(addsuffix _install, $(PACKAGES))
	echo "apt-get install git-email"

packages: $(addsuffix _packages, $(PACKAGES))

## common recipes
%_download:
	$(MAKE) -C $(subst _download,,$@) download

%_packages:
	$(MAKE) -C $(subst _packages,,$@) packages

%_install:
	$(MAKE) -C $(subst _install,,$@) install
