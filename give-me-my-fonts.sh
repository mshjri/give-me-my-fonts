#!/usr/bin/env bash
# give-me-my-fonts.sh
# A crude script to extract hidden Adobe Creative Cloud / Typekit fonts to a folder in your home directory.


### Configuration
#####################################################################

# Exit on error. Append ||true if you expect an error.
set -o errexit
set -o nounset

# Bash will remember & return the highest exitcode in a chain of pipes.
set -o pipefail

# Set magic variables for current FILE & DIR
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${0}")" 

# My temp test directory
#CC_FONT_DIR=$HOME/Desktop/hidden\ fonts/.r

# Adobe font directory
CC_FONT_DIR=$HOME/Library/Application\ Support/Adobe/CoreSync/plugins/livetype/.r

# Directory in your $HOME to put the extracted and renamed fonts
HOME_FONT_DIR=Adobe\ Creative\ Cloud\ Fonts


### App
#####################################################################

# Check for synced fonts locally
if [ -d "$CC_FONT_DIR" ] && [ "$(ls -A "$CC_FONT_DIR")" ]; then

  # Copy the hidden fonts to your new $HOME_FONT_DIR
  mkdir -p $HOME/"$HOME_FONT_DIR"
  cp -r "$CC_FONT_DIR/" $HOME/"$HOME_FONT_DIR"
  cd $HOME/"$HOME_FONT_DIR"

  # First check that we're in the new font dir
  if [ "${PWD##*/}" == "$HOME_FONT_DIR" ]; then  
    
    # Check for PIL, otherwise download it, yo
    hash $(python -c 'from PIL import ImageFont') &>/dev/null
    if [ $? -eq 1 ]; then
      printf "\nWe need to install Pillow, the \"friendly PIL fork\" (Python Imaging Library)\n"
      printf "and need sudo rights (your mac password)...\n"
      if hash pip 2>/dev/null; then
        sudo pip install Pillow    
      else
        printf "\nBut first we need to install pip, a python package manager...\n"
        curl -O https://bootstrap.pypa.io/get-pip.py   
        python get-pip.py
        rm get-pip.py
        printf "\nOk, now Pillow (and sudo)...\n"
        sudo pip install Pillow
      fi
    else
      printf "\nSweet. You've got everything on your system we need to make this happen. \n\nHere we go...\n\n"
    fi

    # Let's get to business
    for i in `ls -aF | egrep '^\..*[^/]$'`
      do 
        font_name=$(python $__dir/extract-font-name.py $i 2>&1) 
        font_format=${i##*.}
        font_file="$font_name.$font_format"
        printf "Found $i, copying, renaming -> $font_file\n"
        mv $i "$font_file"
    done 2>/dev/null
    printf "\nAwesome. \n\nYour Creative Cloud fonts are now in the \"$HOME_FONT_DIR\" \nfolder in your home directory ($HOME).\n\n"    
    printf "Enjoy responsibly (i.e. legally)\n\n"
  else
    echo "Something went wrong. Rats."
  fi

# Or not...
else
  printf "\nHrmph. Seems you either don't have Creative Cloud installed or don't have "
  printf "\nany fonts synced on your local machine. \n\nGet some!\n"
fi

exit