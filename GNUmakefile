INSTALL += $(HOME)/.profile \
		   $(HOME)/.vim/bundle/Vundle.vim $(HOME)/.vimrc \
		   $(HOME)/.aliases aliases \
		   $(HOME)/.profile.d profile.d
ALIASES = $(foreach a,$(wildcard .aliases/*),$(subst .aliases/,$(HOME)/.aliases/,$(a)))
PROFILEDS = $(foreach p,$(wildcard .profile.d/*),$(subst .profile.d/,$(HOME)/.profile.d/,$(p)))

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
	mkdir -p $@

$(HOME)/.aliases/%: .aliases/% $(HOME)/.aliases
	cp $< $@

aliases: $(ALIASES)

$(HOME)/.profile.d:
	mkdir $@

$(HOME)/.profile.d/%: .profile.d/% $(HOME)/.profile.d
	cp $< $@

profileds: $(PROFILEDS)

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
	git clone https://github.com/VundleVim/Vundle.vim.git $@ || cd $@; git pull; exit 0

.PHONY: aliases profileds
