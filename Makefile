PACKAGES=vim.configs i3.configs omzsh.configs

.PHONY: install $(PACKAGES)

install: $(PACKAGES)
	echo "apt-get install git-email"

$(PACKAGES):
	$(MAKE) -C $@ install
