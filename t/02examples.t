#!/usr/bin/perl -w
use strict;

use Test::More tests => 8;
use Data::FormValidator::Filters::Demoroniser   qw(demoroniser demoroniser_utf8);

my %examples = (
    '–“”'       => [ '-""', 'â€“â€œâ€' ],
    'abc'       => [ 'abc', 'abc' ],
    ''          => [ '', '' ],
);

my $sub = demoroniser();
is(ref($sub), 'CODE', 'demoroniser returns a code block');
$sub = demoroniser_utf8();
is(ref($sub), 'CODE', 'demoroniser_utf8 returns a code block');

for my $ex (keys %examples) {
    is(Data::FormValidator::Filters::Demoroniser::_demoroniser($ex),      $examples{$ex}->[0],"_demoroniser returns valid ASCII string for '$ex'");
    is(Data::FormValidator::Filters::Demoroniser::_demoroniser_utf8($ex), $examples{$ex}->[1],"_demoroniser_utf8 returns valid UTF8 string for '$ex'");
}