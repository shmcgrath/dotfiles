#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use open qw(:std :encoding(UTF-8));
use Time::Piece;
use Time::Seconds qw(ONE_DAY);
use Getopt::Long;

# --- Functions ---

my $include_weekly = 0;

GetOptions(
    'weekly' => \$include_weekly,
) or die "Error in command line arguments\n";

sub easter_gregorian {
    my ($year) = @_;
    my $a = $year % 19;
    my $b = int($year / 100);
    my $c = $year % 100;
    my $d = int($b / 4);
    my $e = $b % 4;
    my $f = int(($b + 8) / 25);
    my $g = int(($b - $f + 1) / 3);
    my $h = (19 * $a + $b - $d - $g + 15) % 30;
    my $i = int($c / 4);
    my $k = $c % 4;
    my $l = (32 + 2 * $e + 2 * $i - $h - $k) % 7;
    my $m = int(($a + 11 * $h + 22 * $l) / 451);
    my $month = int(($h + $l - 7 * $m + 114) / 31);
    my $day   = (($h + $l - 7 * $m + 114) % 31) + 1;
    return Time::Piece->strptime(
        sprintf('%04d-%02d-%02d', $year, $month, $day),
        '%Y-%m-%d'
    );
}

sub first_sunday_of_advent {
    my ($year) = @_;
    my $nov27 = Time::Piece->strptime(
        sprintf('%04d-11-27', $year),
        '%Y-%m-%d'
    );
    my $days_until_sunday = (8 - $nov27->wday) % 7; # wday: Sunday=1
    return $nov27 + ($days_until_sunday * ONE_DAY);
}

sub cycle_year_for_advent_year {
    my ($year) = @_;
    my @cycle = ('A', 'B', 'C');
    return $cycle[($year - 2025) % 3];
}

sub liturgical_cycle_year {
    my ($date) = @_;
    my $year = $date->year;
    my $advent_this_year = first_sunday_of_advent($year);
    if ($date >= $advent_this_year) {
        return cycle_year_for_advent_year($year);
    } else {
        return cycle_year_for_advent_year($year - 1);
    }
}

sub csv_escape {
    my ($value) = @_;
    if ($value =~ /[,"\n]/) {
        $value =~ s/"/""/g;
        return qq{"$value"};
    }
    return $value;
}

sub iso_date { $_[0]->strftime('%Y-%m-%d') }

# --- Main loop ---

my @all_rows;

for my $year (2025 .. 2100) {

    my $advent1    = first_sunday_of_advent($year);
    my $advent2 = $advent1 + (7  * ONE_DAY);
    my $advent3 = $advent1 + (14 * ONE_DAY);
    my $advent4 = $advent1 + (21 * ONE_DAY);

    my $easter        = easter_gregorian($year);
    my $ash_wednesday = $easter - (46 * ONE_DAY);
    my $palm_sunday   = $easter - (7  * ONE_DAY);
    my $spy_wednesday = $easter - (4  * ONE_DAY);
    my $holy_thursday = $easter - (3  * ONE_DAY);
    my $good_friday   = $easter - (2  * ONE_DAY);
    my $holy_saturday = $easter - (1  * ONE_DAY);
    my $easter2 = $easter + (7  * ONE_DAY);
    my $easter3 = $easter + (14 * ONE_DAY);
    my $easter4 = $easter + (21 * ONE_DAY);
    my $easter5 = $easter + (28 * ONE_DAY);
    my $easter6 = $easter + (35 * ONE_DAY);
    my $easter7 = $easter + (42 * ONE_DAY); # optional depending on naming
    my $ascension     = $easter + (39 * ONE_DAY); # Thursday observance
    my $pentecost     = $easter + (49 * ONE_DAY);
    my $corpus        = $easter + (60 * ONE_DAY); # Thursday observance
    my $sacred_heart  = $easter + (68 * ONE_DAY); # Friday after Corpus Christi
    my $christ_king   = $advent1 - (7  * ONE_DAY); # Sunday before next Advent

    # Sundays for the entire liturgical year
    my $next_advent1 = first_sunday_of_advent($year + 1);

    my @weekly_masses;

    if ($include_weekly) {
        for (
            my $weekly_mass = $advent1;
            $weekly_mass < $next_advent1;
            $weekly_mass += (7 * ONE_DAY)
        ) {
            push @weekly_masses, ['✠ Sunday Mass', $weekly_mass];
            #['☦ Lenten Sunday', $lenten sunday],
        }
    }

    my @holidays = (
        @weekly_masses,
        ['🕯️First Sunday of Advent', $advent1],
        ['🕯️Second Sunday of Advent', $advent2],
        ['🕯️Third Sunday of Advent (Gaudete)', $advent3],
        ['🕯️Fourth Sunday of Advent', $advent4],
        ['☨ Ash Wednesday', $ash_wednesday],
        ['☨ Palm Sunday', $palm_sunday],
        ['☨ Spy Wednesday', $spy_wednesday],
        ['☨ Holy Thursday', $holy_thursday],
        ['☦ Good Friday', $good_friday],
        ['☨ Holy Saturday', $holy_saturday],
        ['⛪ Easter', $easter],
        ['☨ Second Sunday of Easter (Divine Mercy Sunday)', $easter2],
        ['☨ Third Sunday of Easter', $easter3],
        ['☨ Fourth Sunday of Easter', $easter4],
        ['☨ Fifth Sunday of Easter', $easter5],
        ['☨ Sixth Sunday of Easter', $easter6],
        ['☨ Seventh Sunday of Easter', $easter7],
        ['⛪ Solemnity of the Ascension of the Lord', $ascension],
        ['🕊️ Pentecost', $pentecost],
        ['♰ Solemnity of the Most Holy Body and Blood of Christ', $corpus],
        ['♰ Solemnity of the Most Sacred Heart of Jesus', $sacred_heart],
        ['♰ Solemnity of Our Lord Jesus Christ, King of the Universe', $christ_king],
    );

    for my $row (@holidays) {
        my ($holiday, $dt) = @{$row};
        my $cycle_year = liturgical_cycle_year($dt);
        push @all_rows, [$cycle_year, $holiday, iso_date($dt)];
    }
}

# --- Sort all rows by date and print ---
say 'Cycle Year,Holiday,Date';
for my $r (sort { $a->[2] cmp $b->[2] } @all_rows) {
    printf "%s,%s,%s\n",
        $r->[0],
        csv_escape($r->[1]),
        $r->[2];
}
