#!/usr/bin/env perl

use strict;
use warnings;

my $subgroup = '';

while (<>) {
    chomp;

    if (/^# subgroup: (.+)$/) {
        $subgroup = $1;
        next;
    }

    next if /^#/;

    my ($left, $right) = split /#/, $_, 2;

    next unless defined $right;

    my ($codepoints, $status) =
        $left =~ /^(.+?);\s*(.+?)\s*$/;

    next unless defined $status;

    my ($emoji, undef, $name) =
        $right =~ /^\s*(\S+)\s+(E[\d.]+)\s+(.+)$/;

    next unless defined $emoji;

    $codepoints =~ s/\s+$//;
    $status =~ s/\s+$//;

    printf "%s\t%s\t%s\t%s\t%s\n",
        $emoji,
        $name,
        $subgroup,
        $codepoints,
        $status;
}
