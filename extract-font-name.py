#!/usr/bin/python
#
# Get font family and style from .ttf and .otf files
# 
# Based on the script by Paul Philippov, paul@ppds.ws, 2008-10-05
# http://paulphilippov.com/articles/truetype-font-name-extractor

import sys
import os.path
from PIL import ImageFont

filename = sys.argv[1]
if not os.path.exists(filename) or not os.path.isfile(filename):
  print "Error: %s is not a file" % filename
  sys.exit()

try:
  f = ImageFont.truetype(filename, 1)
except:
  print "Error: %s is not a Truetype font" % filename
  sys.exit()

print f.font.family + " " + f.font.style