#!/bin/bash
# give-me-my-fonts.sh
# A crude script to extract hidden Adobe Creative Cloud / Typekit fonts to a folder in your home directory.


# DIRECTORIES 
# ===========     

# Current script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# My temp test directory
#CC_INSTALLED_DIR=$HOME/Desktop/hidden\ fonts/.r

# Adobe font directory
CC_INSTALLED_DIR=$HOME/Library/Application\ Support/Adobe/CoreSync/plugins/livetype/.r

# Directory in your $HOME to put the extracted and renamed fonts
CC_HOME_DIR=Adobe\ Creative\ Cloud\ Fonts


# Check for synced fonts locally
# ==============================
if [ -d "$CC_INSTALLED_DIR" ] && [ "$(ls -A "$CC_INSTALLED_DIR")" ]; then

  # Copy the hidden fonts to your new $CC_HOME_DIR
  # ==============================================
  mkdir -p $HOME/"$CC_HOME_DIR"
  cp -r "$CC_INSTALLED_DIR/" $HOME/"$CC_HOME_DIR" && cd $HOME/"$CC_HOME_DIR"

  # First check that we're in the new $CC_HOME (don't blow away your dotfiles!)
  # ===========================================================================
  if [ "${PWD##*/}" == "$CC_HOME_DIR" ]; then  
    
    # Check for PIL, otherwise download it, yo (requires sudo, ouch)
    # ==============================================================
    hash $(python -c 'from PIL import ImageFont') &>/dev/null
    if [ $? -eq 1 ]; then
      printf "\nWe need to install Pillow, the \"friendly PIL fork\" (Python Imaging Library)\n"
      printf "and (SORRY) need sudo rights (your mac password)...\n"
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
    # =====================
    for i in `ls -aF | egrep '^\..*[^/]$'`
      do 
        font_name=$(python $DIR/extract-font-name.py $i 2>&1) 
        font_format=${i##*.}
        font_file="$font_name.$font_format"
        printf "Found '$i' ... copying, renaming to '$font_file' ... "
        mv $i "$font_file"
        printf "done!\n"
    done 2>/dev/null
    printf "\nJoy! \n\nYour Creative Cloud fonts are now in the \"$CC_HOME_DIR\" \nfolder in your home directory ($HOME).\n\n"    
    printf "Enjoy responsibly (i.e. legally)\n\n"
  else
    echo "Something went wrong. Rats."
  fi

# Or not...
# =========
else
  printf "\nHrmph. Seems you either don't have Creative Cloud installed or don't have "
  printf "\nany fonts synced on your local machine. \n\nGet some!\n"
fi

exit