#	  	
# @author Erik Frèrejean (Erik Frèrejean) erikfrerejean@phpbb.com
# @copyright (c) 2012 Erik Frèrejean ( N/A )
# @license http://opensource.org/licenses/gpl-license.php GNU Public License
#

MODNAME			= Quote Post Back Link
VERSION			= 2.1.0
PACKAGENAME		= QuotePostBackLink.zip
PACKAGEFILES	= install.xml license.txt modx.prosilver.en.xsl root

UMILTAG	= v1.0.5
MODXTAG	= v1.2.5

MPV	= https://www.phpbb.com/mods/mpv/index.php

CURL	= /usr/bin/curl
GIT		= /usr/bin/git

.title:
	@echo "$(MODNAME) - $(VERSION)\n"

default: .title build

build: clean getumil getmodx
	@echo "Building package"
	@zip -r "./$(PACKAGENAME)" $(PACKAGEFILES)

clean:
	@$(GIT) clean -fd

mpv: build
	@echo "\n\nBuild package and send it to mpv to validate it"
	@$(CURL) --form url_request=@"./$(PACKAGENAME)" --form submit=Submit $(MPV) > ./mpv.tmp
	@sed 's/^<title>.*/<base href="https:\/\/www.phpbb.com\/"><title>/' ./mpv.tmp > ./mpv.html
	-rm ./mpv.tmp

getumil:
	@echo "Preparing the umil files"
	-rm -rf ./vendor/umil
	@$(GIT) clone git://github.com/phpbb/umil.git ./vendor/umil
	@cd ./vendor/umil && git fetch origin && $(GIT) checkout $(UMILTAG)
	@cp -r ./vendor/umil/umil/root/umil ./root/umil

getmodx:
	@echo "Preparing the modx files"
	-rm -rf ./vendor/modx
	@$(GIT) clone git://github.com/phpbb/modx.git ./vendor/modx
	@cd ./vendor/modx && git fetch origin && $(GIT) checkout $(MODXTAG)
	cp ./vendor/modx/modx.prosilver.en.xsl ./modx.prosilver.en.xsl
