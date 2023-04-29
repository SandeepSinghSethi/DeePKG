#!/bin/bash

BINARY=$1
INDEX=1

#colors 
# 31 RED   32 GREEN   33 YELLOW   34 BLUE   35 MAGENTA   36 CYAN   37 GRAY
# 0 NORMAL  1 BOLD  2 DIM  3 ITALIC  4 UNDERLINED  5 BLINKING   6 INVERTED   7 HIDDEN
# bgcolor  40 BLACK  41 RED  42 GREEN  43 YELLOW  44 BLUE  45 MAGENTA  46 CYAN  47 GRAY  49 Default
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
GRAY='\e[37m'
WHITE='\e[0;37m'

function usage()
{
	echo -e "${RED}Usage: ${YELLOW}$0 <package-name>"
	exit 1
}

function existence()
{
	dpkg -L $BINARY  2>/dev/null | grep -e $1 1>/dev/null

	if [[ "$?" -gt 0 ]];then
		echo -e "${RED}$1 ${WHITE}files are not available in dpkg db for ${RED}$BINARY${WHITE} .."
		return 1
	fi

	return 0
}

function check()
{
	existence $1
	if [[ "$?" -eq 0 ]];then
		echo -e "[$INDEX] $1 : "
		((INDEX++))
		return 0
	fi
	return 1
}

if [[ "$#" -lt 1 ]];then
	usage
fi

dpkg -L $BINARY 1>/dev/null 2>/dev/null

if [[ "$?" -gt 0 ]];then
	echo -e "${RED}Invalid Filename or Not in dpkg db ..${WHITE}"
	echo
	echo -e "Use ${CYAN}dpkg -l${WHITE} to get the binaries supported by dpkg .."
	exit 69
fi

check /usr/
check /lib/
check /cache/
check /share/
check /doc/
check /man/
check /var/
check /etc/
check /bin/
echo "[0] To EXIT :"
echo 

INDEX="->"


while true ; do

echo
read -p "Enter directory (e.g. usr , lib ..)  : " option

case $option in
	usr|/usr/|/usr)
		check /usr/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/usr/' && echo -e ${WHITE}
		fi
		;;
	lib|/lib/|/lib)
		check /lib/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/lib/' && echo -e ${WHITE}
		fi
		;;
	cache|/cache/|/cache)
		check /cache/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/cache/' && echo -e ${WHITE}
		fi
		;;
	share|/share/|/share)
		check /share/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/share/' && echo -e ${WHITE}
		fi
		;;
	doc|/doc/|/doc)
		check /doc/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/doc/' && echo -e ${WHITE}
		fi
		;;
	man|/man/|/man)
		check /man/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/man/' && echo -e ${WHITE}
		fi
		;;
	var|/var/|/var)
		check /var/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/var/' && echo -e ${WHITE}
		fi
		;;
	etc|/etc/|/etc)
		check /etc/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/etc/' && echo -e ${WHITE}
		fi
		;;
	bin|/bin/|/bin)
		check /bin/
		if [[ "$?" -eq 0 ]] ; then
			echo -e ${YELLOW}
			dpkg -L $BINARY | grep -e '/bin/' && echo -e ${WHITE}
		fi
		;;
	[0]|exit|EXIT|Exit)
		echo -e "${GREEN}Thank You!!${WHITE}"
		exit 0
		;;
	*)
		echo -e "${RED}Invalid option detected!!${WHITE}"
		;;
esac
done

