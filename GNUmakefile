INSTALL += $(HOME)/.profile \
		   $(HOME)/.vim/bundle/Vundle.vim $(HOME)/.vimrc \
		   $(HOME)/.aliases aliases
ALIASES = $(foreach a,$(wildcard .aliases/*),$(subst .aliases/,$(HOME)/.aliases/,$(a)))

UNAME = $(shell uname)
ifeq ($(UNAME),Darwin)
	INSTALL += /opt/local/etc/bashrc.mac \
			   /opt/local/etc/bashrc
	PROFILE = .profile.mac
else
	INSTALL += $(HOME)/.bashrc
	PROFILE = .profile
endif

install: $(INSTALL)

$(HOME)/.aliases:
	mkdir $@

$(HOME)/.aliases/%: .aliases/% $(HOME)/.aliases
	cp $< $@

aliases: $(ALIASES)

$(HOME)/.profile: $(PROFILE)
	cp $< $@

/opt/local/etc/bashrc: .bashrc
	sudo cp $< $@

/opt/local/etc/bashrc.mac: .bashrc.mac
	sudo cp $< $@

$(HOME)/.vimrc: .vimrc
	cp $< $@

$(HOME)/.vim/bundle:
	mkdir -p $@

$(HOME)/.vim/bundle/Vundle.vim: $(HOME)/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git $@

.PHONY: aliases
