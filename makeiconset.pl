#!/usr/bin/perl

use strict ;
use File::Basename ;
use File::Copy::Recursive ;

my $ok ;

if ($#ARGV < 0) {
	print "makeiconset.pl creates a .iconset folder for Mac OS X apps, post-Retina, containing the required ten (10) png files of different sizes.  It simply scales down a given png file, using the 'sips' program built into Mac OS X.  This script is therefore useful for simple, straight-line icons which don't need to be tweaked for each scaling by a human designer, or for projects where the intended users and budget does not warrant it.  Or, you can run this script, examine the results and then hand-tweak the ones which are not good enough.\nusage:\n   makeiconset <source>\nwhere <source> is the path to a 1024x1024 pixel png file.\nThe product is created in the same directory as this source file.  The product is named <basename>.iconset, where <basename> is the base name of the source file, without the .png extension.  If such a folder already exists, it is deleted and the product replaces it.\n(You then add the .iconset folder to the .app target in your project.  Xcode 4.4+ will compile it into a .icns file when building, and include the .icns file into your app product's package.)" ;
	exit(1) ;
}
my $sourceFilePath = $ARGV[0] ;

my $sourceDir = dirname($sourceFilePath) ;
my $sourceName = basename($sourceFilePath) ;

my @nameParts = split(/\./, $sourceName) ;
my $extension = pop(@nameParts) ;
my $basename = join("/", @nameParts) ;

my $iconsetPath = $sourceDir . "/" . $basename . ".iconset" ;

# Remove iconset dir in case it already exists
$ok = File::Copy::Recursive::pathrmdir($iconsetPath) ;
if ($ok == 1) {
	print "Removed existing:\n   $iconsetPath\n" ;
}
else {
	print "Did not remove nonexistent or non-directory: $iconsetPath\n" ;
}


# Create new iconset dir
$ok = mkdir($iconsetPath, 0755) ;
if (!$ok) {
	print "Could not make directory:\n   $iconsetPath\n" ;
	stop ("Aborting due to error $!") ;
}
else {
	print "Created directory:\n   $iconsetPath\n" ;
}

# In the following the @ are backslash-escaped so as not to be interpreted as Perl arrays.
my @names = ("16x16", "32x32", "128x128", "256x256", "512x512", "16x16\@2x", "32x32\@2x", "128x128\@2x", "256x256\@2x", "512x512\@2x") ;

my @sizes = (16, 32, 128, 256, 512, 32, 64, 256, 512, 1024) ;

my $i = 0 ;
foreach my $size (@sizes) {
	my $pathOut = $iconsetPath . "/icon_" . $names[$i] . ".png" ;
	`sips --resampleWidth $size "$sourceFilePath" --out "$pathOut"` ;
	print "Wrote image of size $size to $pathOut\n" ;
	$i++ ;
}
	
