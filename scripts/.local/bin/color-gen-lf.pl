#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;

my ($vivid_theme_file, $vivid_filetypes_file);
GetOptions(
    'theme|t=s' => \$vivid_theme_file,
    'database|d' => \$vivid_filetypes_file,
) or die "Usage: $0 [--theme PATH] [--database PATH]\n";

$vivid_theme_file ||= "$ENV{HOME}/dotfiles/vivid/cyberdream.yml";

-f $vivid_theme_file or die "Theme file not found: $vivid_theme_file\n";

-f $vivid_filetypes_file or die "Database file not found: $vivid_filetypes_file\n"
    if defined $vivid_filetypes_file;

my @cmd = ('vivid');
push @cmd, ('--database', $vivid_filetypes_file) if defined $vivid_filetypes_file;
push @cmd, ('generate', $vivid_theme_file);

open my $fh, '-|', @cmd
    or die "failed to run vivid\n";

my $ls_colors = <$fh>;
chomp $ls_colors;
close $fh;

for my $entry (split /:/, $ls_colors) {
    my ($key, $val) = split /=/, $entry, 2;
    next unless defined $val;
    printf "%s   %s\n", $key, $val;
}
