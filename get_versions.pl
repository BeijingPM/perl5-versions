#!/usr/bin/env perl
# this code snippet is stolen from:
# https://github.com/tokuhirom/Perl-Build/blob/master/lib/Perl/Build.pm#L22
use warnings;
use strict;
use LWP::Simple;

my $url = "http://www.cpan.org/src/5.0/";
my $html = get( $url );

unless($html) {
    die "\nERROR: Unable to retrieve the list of perls.\n\n";
}

my @available_versions;

my %uniq;
while ($html =~ m|<a href="perl-([^"]+)\.tar\.gz">(.+?)</a>|g) {
    my $version = $1;
    next if $uniq{$version}++;
    push @available_versions, $version;
}

open my $fh, ">", "versions.txt" or die "open file error: $!";
print $fh "$_\n" for @available_versions;
close $fh;
