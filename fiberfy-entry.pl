#!/usr/bin/perl
# This script configures fiberfy for first time
#
use warnings;
use strict;


print "Checking configurations...\n";

if (! -e "INSTALLED") {

    my $output = `rm -rf {,.[!.],..?}*`;
    if ($? != 0) {
        # Error
        die "Error erasing all volume.\n";
    }

    $output = `npm install sails -g`;
    if ($? != 0) {
        # Error
        die "Error installing sails.\n";
    }

    $output = `git init && git remote add origin $ENV{FIBERFY_GIT_REPO} \\
                && git fetch && git checkout -t origin/$ENV{FIBERFY_GIT_BRANCH}`;
    if ($? != 0) {
        # Error
        die "Error getting code from git repository.\n";
    }

    $output = `chown -R $ENV{FIBERFY_UNIX_USER}:$ENV{FIBERFY_UNIX_USER} . && chmod -R o+rw .`;
    if ($? != 0) {
        # Error
        die "Error changing permissions.\n";
    }

    $output = `gosu fiberfy npm install`;
    if ($? != 0) {
        # Error
        die "Error installing node deps.\n";
    }

    $output = `gosu fiberfy npm run build`;
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
