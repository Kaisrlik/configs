PACKAGES=vim.configs i3.configs omzsh.configs

.PHONY: install $(PACKAGES)

install: $(PACKAGES)
	echo "aa"

$(PACKAGES):
	$(MAKE) -C $@ install
