#!/bin/bash
#Only for Debian 10 Buster
#Check root access
#echo "$(whoami)"
if [[ $EUID -ne 0 ]]; then
  echo "Please enter your root password: "
  [ "$UID" -eq 0 ] || exec sudo "$0" "$@"
fi

clear

#Menu

echo "╔═══╗   ╔╗           ╔╗   ╔╗╔╗
║╔═╗║  ╔╝╚╗         ╔╝╚╗  ║║║║
║║ ║╠╗╔╬╗╔╬══╦╦═╗╔══╬╗╔╬══╣║║║╔══╦═╗
║╚═╝║║║║║║║╔╗╠╣╔╗╣══╣║║║╔╗║║║║║║═╣╔╝
║╔═╗║╚╝║║╚╣╚╝║║║║╠══║║╚╣╔╗║╚╣╚╣║═╣║
╚╝ ╚╩══╝╚═╩══╩╩╝╚╩══╝╚═╩╝╚╩═╩═╩══╩╝"

echo 

echo "Select the number of programs to install [1-9]:"

MENU = (
      "Standard set ( ShotWell, Htop, GIMP, PWGen, Nano, ScreenFetch, qBittorrent )"  #1
      "Google Chrome"                                                                 #2
      "Skype"                                                                         #3
      "TeamViever"                                                                    #4
      "Steam"                                                                         #5
      "VeraCrypt"                                                                     #6
      "youtube-dl"                                                                    #7
      "To finish the selection and to proceed to install"                             #8
      "Exit"                                                                          #9
     )

select menu in "${MENU[@]}" ; do
  case $REPLY in
    1)  Standard='1';;
    2)  Chrome='1';;
    3)  Skype='1';;
    4)  TeamViever='1';;
    5)  Steam='1';;
    6)  VeraCrypt='1';;
    7)  youtube='1';;
    8)  clear; break;;
    9)  clear; exit 1 ;;
  esac
done

#The output of the selected packages

echo "The following selected packages will be installed:"

inst=(
  [1]=$Standard
  [2]=$Chrome 
  [3]=$Skype
  [4]=$TeamViever
  [5]=$Steam
  [6]=$VeraCrypt
  [7]=$youtube
 )

prog=('' 'Standard set ( ShotWell, Htop, GIMP, PWGen, Nano, ScreenFetch, qBittorrent ),' 'Google Chrome,' 'Skype,' 'TeamViever,' 'Steam,' 'VeraCrypt,' 'youtube-dl')

for ((i=1;i<=7;i++)); do
#echo "$i ${prog[$i]}";
  if [[ ${inst[$i]} = 1 ]]; then
    echo ${prog[$i]};
 fi
done


#Confirm installation of the selected packages

while true; do
  read -p "Continue the installation [Y/N]:" yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) Standard='0'; Chrome='0'; Skype='0'; eamViever='0'; Steam='0'; VeraCrypt='0'; youtube='0';exit 1;;
    * ) echo "Please answer yes or no.";;
  esac
done

#Installing
clear
	echo 'Repository Update'
	echo
	apt-get update
	echo
	echo 'Updating packages'
	echo
	apt-get upgrade -y
	echo
	echo 'Installing Wget'
	echo
	apt-get install -y wget
 	echo

#Standard set
for ((var=1;var<=7;var++)); do
  if [[ ${inst[$var]} = 1 ]]; then
    if [[$var != 1]; then echo Downloading ${prog[$var]}
    fi
    echo
    case $var in
      1)  echo "Downloading and Installing ${prog[$var]}"
          apt install -y shotwell htop gimp pwgen qbittorrent nano screenfetch
          ;;
#Chrome
      2)  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O .google-chrome-stable_current_amd64.deb
          echo "Installing ${prog[$var]}"
      	  echo
      	  apt-get install -y ./.google-chrome-stable_current_amd64.deb
      	  rm ./.google-chrome-stable_current_amd64.deb
          ;;
#Skype
      3)  wget https://repo.skype.com/latest/skypeforlinux-64.deb -O .skypeforlinux-64.deb
          echo "Installing ${prog[$var]}"
      	  echo
      	  apt-get install -y ./.skypeforlinux-64.deb
      	  rm ./.skypeforlinux-64.deb
          ;;
#TeamViever
      4)  wget https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.15.5_amd64.deb -O .teamviewer_15.15.5_amd64.deb
      	  echo "Installing ${prog[$var]}"
      	  echo
      	  apt-get install -y ./.teamviewer_15.15.5_amd64.deb
      	  rm ./.teamviewer_15.15.5_amd64.deb
          ;;
#Steam
      5)  wget https://repo.steampowered.com/steam/archive/precise/steam_latest.deb -O .steam_latest.deb
      	  echo "Installing ${prog[$var]}"
      	  echo
      	  apt-get install -y ./.steam_latest.deb
      	  rm ./.steam_latest.deb
          ;;
#VeraCrypt
      6)  wget https://launchpad.net/veracrypt/trunk/1.24-update7/+download/veracrypt-1.24-Update7-Ubuntu-20.10-amd64.deb -O .veracrypt-1.24-Update7-Ubuntu-20.10-amd64.deb
      	  echo "Installing ${prog[$var]}"
      	  echo
      	  apt-get install -y ./.veracrypt-1.24-Update7-Ubuntu-20.10-amd64.deb
      	  rm ./.veracrypt-1.24-Update7-Ubuntu-20.10-amd64.deb
          ;;
#youtube-dl
      7)  wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
      	  chmod a+rx /usr/local/bin/youtube-dl
      	  echo
          ;;

      *)  echo Packages not selected for installation or something went wrong
          ;;
    esac
  fi
done

#Cleanup
apt-get clean
apt autoremove
