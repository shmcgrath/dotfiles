#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Mojo::DOM;
use open qw(:std :encoding(UTF-8));

# -----------------------------
# READ UTF-8 SAFELY
# -----------------------------
my $file = shift or die "Usage: $0 <file>\n";

open my $fh, '<:encoding(UTF-8)', $file or die "Cannot open $file: $!";
local $/;
my $html = <$fh>;
close $fh;

my $dom = Mojo::DOM->new($html);

# -------------------------------------------------
# 1. EXTRACT FOOTNOTES (raw DOM snapshots)
# -------------------------------------------------
my %footnotes;

for my $fn ($dom->find('p.footnote1[id]')->each) {
    my $id = $fn->{id};

    # keep raw HTML, but remove leading marker link only
    my $copy = $fn->to_string;
    $copy =~ s{<a[^>]*>.*?</a>}{}s;
    $copy =~ s{</?p[^>]*>}{}g;

    $footnotes{$id} = $copy;
}

# -------------------------------------------------
# 2. RECURSIVE RESOLVER (DOM-safe, spacing-safe)
# -------------------------------------------------
my %resolved;
my %seen;

sub resolve {
    my ($id) = @_;

    return $resolved{$id} if exists $resolved{$id};
    return '' unless exists $footnotes{$id};
    return '' if $seen{$id}++;

    my $html = $footnotes{$id};
    my $dom_fn = Mojo::DOM->new($html);

    # resolve nested footnote links using DOM (NOT regex)
    $dom_fn->find('a')->each(sub {
        my $a = shift;

        my $href = $a->{href} // '';
        $href =~ s/^#//;

        return unless exists $footnotes{$href};

        my $label = $a->at('sup') ? $a->at('sup')->all_text : $a->all_text;
        my $inner = resolve($href);

        #$a->replace(" [$label: $inner] ");
        $a->replace("<sup>$label</sup><span class=\"footnote-inline-inner\">[$label: $inner]</span>");
    });
    return $resolved{$id} = $dom_fn->to_string;

    # # extract clean text with spacing preserved
    # my $text = $dom_fn->all_text;
    #
    # # normalize whitespace but do NOT destroy spacing between tokens
    # $text =~ s/\s+/ /g;
    # $text =~ s/^\s+|\s+$//g;
    #
    # return $resolved{$id} = $text;
}

# resolve all footnotes first (graph closure)
resolve($_) for keys %footnotes;

# -------------------------------------------------
# 3. REPLACE BODY REFERENCES
# -------------------------------------------------
for my $a ($dom->find('a[href^="#calibre_link-"]')->each) {

    my $href = $a->{href} // '';
    $href =~ s/^#//;

    next unless exists $resolved{$href};

    my $num = $a->at('sup') ? $a->at('sup')->all_text : $a->all_text;

    $a->replace("<sup>$num</sup><span class=\"footnote-inline\">[$num:$resolved{$href}]</span>");
}

# -------------------------------------------------
# 4. REMOVE FOOTNOTE BLOCKS
# -------------------------------------------------
$dom->find('div#footnote, div.footnote')->each(sub { $_->remove });

# -----------------------------
# REMOVE CALIBRE EMPTY ANCHORS
# -----------------------------
$dom->find('a[id^="calibre_link-"]')->map(sub {
    my $a = $_;

    return if $a->{href};

    my $id = $a->{id} // '';

    # keep if something links TO this anchor
    my $has_incoming = $dom->at(qq{a[href="#$id"]});

    return if $has_incoming;

    $a->remove;
});

# OLD
# $dom->find('p a[id^="calibre_link-"]')->map(sub {
#     my $a = $_;
#     return if $a->{href};
#     $a->remove;
# });
#
# -----------------------------
# REMOVE EMPTY CALIBRE DIVS (SAFE)
# -----------------------------
$dom->find('div[id^="calibre_link-"]')->map(sub {
    my $d = $_;

    # only remove if truly empty or whitespace
    my $text = $d->all_text;
    $text =~ s/\x{00A0}/ /g;
    $text =~ s/\s+/ /g;

    if ($text !~ /\S/) {
        $d->remove;
    }
});

$dom->find('div[id^="calibre_link-"]')->map(sub {
    my $div = $_;

    # check if it contains ONLY whitespace + one heading
    my $text = $div->all_text;

    # if it contains an h1 or h2 inside, unwrap it
    if ($div->at('h1') || $div->at('h2')) {
        $div->replace($div->content);
    }
});

# $dom->find('a[id^="calibre_link-"]')->each(sub {
#     my $a = $_;
#
#     # only remove if truly empty (no text, no children)
#     if ($a->all_text !~ /\S/) {
#         $a->remove;
#     }
# });

# Remove ID of headers if it is h2 or below and class=seciton
$dom->find('h2, h3, h4, h5, h6')->each(sub {
    my $h = $_;

    # only proceed if class contains "section"
    my $class = $h->{class} // '';
    return unless $class =~ /\bsection\b/;

    my $id = $h->{id} // '';

    if ($id =~ /^calibre_link-\d+$/) {
        delete $h->{id};
    }
});


# -------------------------------------------------
# BUILD ID MAP (ONLY REAL IDS IN DOC)
# -------------------------------------------------

my %id_exists;

$dom->find('[id^="calibre_link-"]')->each(sub {
    my $el = shift;
    my $id = $el->{id} // '';
    $id_exists{$id} = 1;
});

# -------------------------------------------------
# BUILD REFERENCE MAP (ONLY REAL LINKS THAT MATCH IDS)
# -------------------------------------------------

my %ref;

$dom->find('a[href^="#calibre_link-"]')->each(sub {
    my $a = shift;
    my $href = $a->{href} // '';
    $href =~ s/^#//;

    return unless $id_exists{$href};

    $ref{$href} = 1;
});

# -------------------------------------------------
# RENAME IDS (ONLY THOSE ACTUALLY REFERENCED)
# -------------------------------------------------

for my $id (keys %ref) {
    my $el = $dom->at("[id='$id']") or next;

    (my $new = $id) =~ s/^calibre_link-/shm_link-/;
    $el->{id} = $new;
}

# -------------------------------------------------
# RENAME HREFS (ONLY THOSE THAT MATCH RENAMED IDS)
# -------------------------------------------------

$dom->find('a[href^="#calibre_link-"]')->each(sub {
    my $a = shift;
    my $href = $a->{href} // '';
    $href =~ s/^#calibre_link-/#shm_link-/;

    # only update if target actually exists
    return unless exists $ref{ (my $old = $href) =~ s/^#shm_link-/calibre_link-/r };

    $a->{href} = $href;
});


# -----------------------------
# EXPORT DOM BACK TO HTML STRING
# -----------------------------
$html = $dom->to_string;

# =========================================================
# REGEX CLEANUP PASS (Calibre formatting normalization)
# =========================================================

# SCAP / dropcap / SUB spans
$html =~ s|<span class="scap[01]?">(.*?)</span>|$1|sg;
$html =~ s|<span class="dropcap[01]?">(.*?)</span>|$1|sg;
$html =~ s|<span class="sub">(.*?)</span>|<sub>$1</sub>|sg;

# Remove class from em/b
$html =~ s{<\s*(em|b)([^>]*)\s+class="[^"]*"([^>]*)>}{<$1$2$3>}gi;

# blockquote collapse
1 while $html =~ s|<blockquote(?:\s+class="[^"]*")?>(\s*<blockquote(?:\s+class="[^"]*")?>)+|<blockquote>|g;
1 while $html =~ s|(</blockquote>\s*){2,}|</blockquote>|g;

# italic/bold spans
$html =~ s|<span class="italic">(.*?)</span>|<em>$1</em>|gs;
$html =~ s|<span class="bold">(.*?)</span>|<strong>$1</strong>|gs;

$html =~ s|<i\b[^>]*>(.*?)</i>|<em>$1</em>|gs;
$html =~ s|<b\b[^>]*>(.*?)</b>|<strong>$1</strong>|gs;

$html =~ s|<span\b[^>]*class="underline"[^>]*>(.*?)</span>|<u>$1</u>|gs;

# class cleanup
$html =~ s|(class="[^"]*?)\bindent\d+\b([^"]*")|$1indent$2|g;
$html =~ s|(class="[^"]*?)\bcenter\d+\b([^"]*")|$1center$2|g;
$html =~ s|(class="[^"]*?)\bsmall\d+\b([^"]*")|$1small$2|g;

$html =~ s/\s+class="calibre\d*"/ /g;

# remove empty spans/divs
$html =~ s|<div[^>]*style="height:0pt"[^>]*>.*?</div>||sg;
$html =~ s|<span[^>]*>\s*</span>||sg;

# remove lines with four spaces
$html =~ s/^ {4}\R//mg;
$html =~ s/^ {2}\R//mg;

# remove double spaces between <a and the first descriptior
$html =~ s|<a\s+([a-zA-Z:-]+=)|<a $1|g;

# remove random double spaces
$html =~ s/([a-z]) {2,}/$1 /g;

# -----------------------------
# WRITE BACK UTF-8
# -----------------------------
open my $out, '>:encoding(UTF-8)', $file or die "Cannot write $file: $!";
print $out $html;
close $out;

print "HTML cleaned (DOM + regex pass) in $file\n";
