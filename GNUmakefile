DEFAULT_TARGETS += $(HOME)/.profile \
		   $(HOME)/.vim/bundle/Vundle.vim $(HOME)/.vimrc \
		   $(HOME)/.inputrc \
		   $(HOME)/.config/alacritty/alacritty.toml \
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
	OPEN = open
else ifeq ($(UNAME),FreeBSD)
	DEFAULT_TARGETS += $(HOME)/.bashrc \
			   $(HOME)/.bashrc.freebsd \
			   $(HOME)/.profile.freebsd
	PROFILE = .profile
	INSTALL = ginstall
	OPEN = xdg-open
else ifeq ($(UNAME),Linux)
	DEFAULT_TARGETS += $(HOME)/.bashrc \
			   $(HOME)/.profile.linux
	PROFILE = .profile
	INSTALL = install
	OPEN = xdg-open
else
	DEFAULT_TARGETS += $(HOME)/.bashrc
	PROFILE = .profile
	INSTALL = install
	OPEN = xdg-open
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

$(HOME)/.profile.%: .profile.%
	cp $< $@

$(HOME)/.bashrc: .bashrc
	cp $< $@

$(HOME)/.inputrc: .inputrc
	cp $< $@

$(HOME)/.bashrc.%: .bashrc.%
	cp $< $@

/opt/local/etc/bashrc: .bashrc
	sudo cp $< $@

/opt/local/etc/bashrc.%: .bashrc.%
	sudo cp $< $@

$(HOME)/.vimrc: .vimrc
	cp $< $@

$(HOME)/.vim/bundle:
	mkdir -p $@

$(HOME)/.config/alacritty/alacritty.toml: .config/alacritty/alacritty.toml
	$(INSTALL) -D -m 644 $< $@

$(HOME)/.sway/config: .sway/config
	$(INSTALL) -D -m 644 $< $@

sway: $(HOME)/.sway/config

$(HOME)/.vim/bundle/Vundle.vim: $(HOME)/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git $@ || cd $@; git pull; exit 0

$(HOME)/.Xmodcapslock: x-crap/.Xmodcapslock
	cp $< $@

$(HOME)/.Xdefaults: x-crap/.Xdefaults
	cp $< $@

$(HOME)/.Xresources: x-crap/.Xresources
	cp $< $@

$(HOME)/.xinitrc: x-crap/.xinitrc
	cp $< $@

x-crap: $(HOME)/.Xmodcapslock $(HOME)/.Xdefaults $(HOME)/.Xresources $(HOME)/.xinitrc

.PHONY: aliases profileds README x-crap sway

### README #####################################################################

pub.css:
	wget https://github.com/manuelp/pandoc-stylesheet/raw/acac36b976966f76544176161ba826d519b6f40c/pub.css

# Requires Pandoc to be installed
README.html: README.md pub.css
	pandoc $< -s -c pub.css -o README.html
	$(OPEN) README.html

README: README.html
