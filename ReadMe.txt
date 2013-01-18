makeiconset.pl creates a .iconset folder for Mac OS X apps, supporting Retina displays, containing the required ten (10) png files of different sizes.  It simply scales down a given png file, using the 'sips' program built into Mac OS X.

This script is therefore useful for simple icons which don't need to be tweaked for each scaling by a human designer, or for projects where the intended users and budget does not warrant it.  Or, you can run this script, examine the results and then hand-tweak the ones which are not good enough.

usage:

   makeiconset <source>
   
where <source> is the path to a 1024x1024 pixel png file.

The product is created in the same directory as this source file.  The product is named <basename>.iconset, where <basename> is the base name of the source file, without the .png extension.  If such a folder already exists, it is deleted and the product replaces it.

(You then add the .iconset folder to the .app target in your project.  Xcode 4.4+ will compile it into a .icns file when building, and include the .icns file into your app product's package.)