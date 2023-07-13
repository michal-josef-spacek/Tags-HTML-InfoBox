use strict;
use warnings;

use Tags::HTML::InfoBox;
use Tags::Output::Raw;
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::InfoBox->new;
isa_ok($obj, 'Tags::HTML::InfoBox');

# Test.
$obj = Tags::HTML::InfoBox->new(
	'tags' => Tags::Output::Raw->new,
);
isa_ok($obj, 'Tags::HTML::InfoBox');
