#!/usr/bin/env perl
use strict;
use warnings;
use JSON::PP;
use Getopt::Long;

my $file;

GetOptions(
    'file|f=s' => \$file,
) or die "Usage: $0 --file <snippets_file>\n";

die "Usage: $0 --file <snippets_file>\n" unless $file;

# Read entire snippet file
open my $fh, '<', $file or die "Cannot open '$file': $!\n";
local $/;  # slurp mode
my $content = <$fh>;
close $fh;

my %snippets;

# Match snippet blocks
while ($content =~ /snippet\s+(\S+)\s+"(.*?)"(?:\s+\S*)?\n(.*?)\nendsnippet/sg) {
    my ($trigger, $desc, $body) = ($1, $2, $3);
    $body =~ s/\s+$//mg;   # remove trailing whitespace on each line
    $snippets{$trigger} = {
        description => $desc,
        body        => $body
    };
}

# Encode JSON (pretty)
my $json_text = JSON::PP->new->ascii->pretty->encode(\%snippets);

# Remove spaces before colon
$json_text =~ s/(\S)\s+:(?=\s)/$1:/g;

# Print to stdout
print $json_text;
