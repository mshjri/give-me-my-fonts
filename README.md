Give Me My Fonts!
================

Anyone who has used Adobe's [Creative Cloud](http://www.adobe.com/creativecloud.html) service has probably come to the annoying realization that fonts bought / managed with Creative Cloud and thus TypeKit are hidden safely away in the cryptic Adobe filesystem universe and not available to you to use / send / play with in Font Book or in any other capacity other than inside Adobe's walled garden.

This means that if you want to package or send fonts included in a design file, the person who you are sending it to has to have a TypeKit subscription. 

**Hrmph.**

*From Creative Coud FAQ...*

> Many previous Adobe software products, including the Creative Suite, have included Adobe desktop fonts which are installed in the user’s system folder. Today, these bundled fonts have been replaced by desktop fonts delivered by Adobe Typekit.<br>
> ... <br>
> Because desktop fonts from Typekit are provided by subscription, they cannot be copied and moved by the Package feature (or users). However, any recipient of your document who is also using Creative Cloud can use Typekit to sync the necessary fonts if they don’t already have them installed.<br>
> ... <br>
> The license for software which included bundled fonts allows those fonts to be used while the software is installed. That means if you uninstall the software, you are no longer licensed to use the fonts. And if you upgrade, you have a new software license which might grant different rights.

*So...* 

[Give Me My Fonts](https://github.com/fitzhaile/give-me-my-fonts) is a crude script to extract hidden Adobe Creative Cloud / Typekit fonts to a folder in your home directory.

I say "crude" because:

- It's my first Bash script
- It's probably (definitely) against Adobe's TOS

### But...

Whatever. I'm just trying to edit Photoshop files.

## Usage

1. Clone the repo `git clone git@github.com:fitzhaile/give-me-my-fonts.git` or [download the zip file](https://github.com/fitzhaile/give-me-my-fonts/archive/master.zip).
2. Run the script. Either:

* Run `give-me-my-fonts/give-me-my-fonts.sh`
* Or, double-click the `give-me-my-fonts.command` execuatable in the repo directory

### Requirements:

- OS X
- Adobe Creative Cloud
- Python
- `sudo` rights (sorry)

### What the script does:

Adobe hides your font files by making both the directory hidden and obscure, and the actual names of the fonts.  The script only does the following:

1. Copies the fonts (only the ones **managaged with TypeKit/Creative Cloud**) from the hidden, cryptic Adobe app filesystem into a folder called "Adobe Creative Cloud Fonts" in your HOME directory.
2. Uses [Pillow](https://pypi.python.org/pypi/Pillow) (the ‘friendly’ PIL fork) to read font data since the fonts themselveves are also hidden *and* obscured by being named things like `.232343.otf`
3. If you don't have Pillow/PIL installed, it will attempt to download and install the python package manager `pip` (if you don't already have it) and install Pillow. (Which needs sudo access.)




