#!/usr/bin/perl
# This script configures fiberfy for first time
#
use warnings;
use strict;

sleep 15; # We should wait for mariadb container being ready

print "Checking configurations...\n";

if (! -e "INSTALLED") {

    my $output = `rm -rf ./* .[^.]* ..?*`;
    if ($? != 0) {
        # Error
        die "Error erasing all volume.\n";
    }

    $output = `git init && git remote add origin $ENV{FIBERFY_GIT_REPO} \\
                && git fetch && git checkout -t origin/$ENV{FIBERFY_GIT_BRANCH}`;
    if ($? != 0) {
        # Error
        die "Error getting code from git repository.\n";
    }

    $output = `chown -R $ENV{FIBERFY_UNIX_USER}:$ENV{FIBERFY_UNIX_USER} . && chmod -R o+rw . && chmod -R g+rw .`;
    if ($? != 0) {
        # Error
        die "Error changing permissions.\n";
    }

    $output = `gosu fiberfy ./docker-install.sh`;
    if ($? != 0) {
        # Error
        die "Error running installation script.\n";
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
