use strict;
use warnings;

use Tags::HTML::InfoBox;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Tags::HTML::InfoBox::VERSION, 0.02, 'Version.');
