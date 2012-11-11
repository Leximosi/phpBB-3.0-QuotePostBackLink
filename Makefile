#
# @author Erik Frèrejean (Erik Frèrejean) erikfrerejean@phpbb.com
# @copyright (c) 2012 Erik Frèrejean ( N/A )
# @license http://opensource.org/licenses/gpl-license.php GNU Public License
#
 
all: clean build

clean:
	git clean -fd

umil:
	if [ -a ./vendor/umil/.git ]; \
	then \
		rm -rf ./vendor/umil; \
	fi;

	git clone git://github.com/phpbb/umil.git ./vendor/umil
	cd ./vendor/umil
	git checkout v1.0.4
	cd ./../../

modx:
	if [ -a ./vendor/modx/.git ]; \
	then \
		rm -rf ./vendor/modx; \
	fi;

	git clone git://github.com/phpbb/modx.git ./vendor/modx
	cd ./vendor/modx/
	git checkout v1.2.5
	cd ./../../
 
build: umil modx
	# Copy UMIL into place
	mv ./vendor/umil/umil/root/umil ./root/umil

	# Copy modx into place
	cp ./vendor/modx/modx.prosilver.en.xsl ./modx.prosilver.en.xsl

	# Delete the vendor dir
	rm -rf ./vendor/

	# Package
	zip -r ./QuotePostBackLink.zip install.xml license.txt modx.prosilver.en.xsl root
