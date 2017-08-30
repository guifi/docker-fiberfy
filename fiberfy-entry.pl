#!/usr/bin/perl
# This script configures fiberfy for first time
#
use warnings;
use strict;


print "Checking configurations...\n";

if (! -e "INSTALLED") {
    my $output = `git pull origin master`;
    if ($? != 0) {
        # Error
        die "Error pulling code from git repository.\n";
    }

    my $output = `npm install`;
    if ($? != 0) {
        # Error
        die "Error installing node deps.\n";
    }

    my $output = `npm run build`;
    if ($? != 0) {
        # Error
        die "Error building bundle.js .\n";
    }

    # make INSTALLED file
    $output = `touch INSTALLED`;
    if ($? != 0) {
     # Error
     die "Error creating INSTALLED file.\n";
    }

    print "Guifi.net fiberfy successfully installed in Docker image!\n";
}
else {
    print "Already installed.\n";
}