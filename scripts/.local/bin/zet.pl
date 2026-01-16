#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use utf8;
use open qw(:std :utf8);

use Time::Piece;

my $datestring = localtime;
my $dtraw = $datestring->strftime('%Y-%m-%d %H:%M');
print "$datestring\n";
print "$dtraw\n";

my $weather_url = qq(wttr.in/Pittsburgh?format="%l:+%C+%t+%w+%p+%u+%s");

my $weather = `curl -s "$weather_url"`;
chomp $weather;

print "Weather: $weather\n";
