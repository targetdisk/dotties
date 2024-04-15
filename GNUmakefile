DEFAULT_TARGETS += $(HOME)/.profile \
		   $(HOME)/.vim/bundle/Vundle.vim $(HOME)/.vimrc \
		   aliases \
		   $(HOME)/.profile.d profileds
ALIASES = $(foreach a,$(wildcard .aliases/*),$(subst .aliases/,$(HOME)/.aliases/,$(a)))
PROFILEDS = $(foreach p,$(wildcard .profile.d/*),$(subst .profile.d/,$(HOME)/.profile.d/,$(p)))

UNAME = $(shell uname -s)
ifeq ($(UNAME),Darwin)
	DEFAULT_TARGETS += /opt/local/etc/bashrc.mac \
			   /opt/local/etc/bashrc
	PROFILE = .profile.mac
	INSTALL = ginstall
else ifeq ($(UNAME),FreeBSD)
	DEFAULT_TARGETS += $(HOME)/.bashrc
	PROFILE = .profile
	INSTALL = ginstall
else
	DEFAULT_TARGETS += $(HOME)/.bashrc
	PROFILE = .profile
	INSTALL = install
endif

install: $(DEFAULT_TARGETS)

$(HOME)/.aliases/%: .aliases/%
	$(INSTALL) -D -m 644 $< $@

aliases: $(ALIASES)

$(HOME)/.profile.d:
	mkdir $@

$(HOME)/.profile.d/%: .profile.d/% $(HOME)/.profile.d
	cp $< $@

profileds: $(PROFILEDS)

$(HOME)/.profile: $(PROFILE)
	cp $< $@

$(HOME)/.bashrc: .bashrc
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
