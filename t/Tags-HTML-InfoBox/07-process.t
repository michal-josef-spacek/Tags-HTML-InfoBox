use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::InfoBox;
use Tags::Output::Structure;
use Test::More 'tests' => 4;
use Test::NoWarnings;
use Test::Shared::Fixture::Data::InfoBox::Street;
use Unicode::UTF8 qw(decode_utf8);

# Test.
my $tags = Tags::Output::Structure->new;
my $obj = Tags::HTML::InfoBox->new(
	'tags' => $tags,
);
my $info_box = Test::Shared::Fixture::Data::InfoBox::Street->new;
$obj->init($info_box);
$obj->process;
my $ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[
		['b', 'table'],
		['a', 'class', 'info-box'],

		['b', 'tr'],
		['b', 'td'],
		['e', 'td'],
		['b', 'td'],
		['d', decode_utf8('Nábřeží Rudoarmějců')],
		['e', 'td'],
		['e', 'tr'],

		['b', 'tr'],
		['b', 'td'],
		['e', 'td'],
		['b', 'td'],
		['d', decode_utf8('Příbor')],
		['e', 'td'],
		['e', 'tr'],

		['b', 'tr'],
		['b', 'td'],
		['e', 'td'],
		['b', 'td'],
		['d', decode_utf8('Česká republika')],
		['e', 'td'],
		['e', 'tr'],

		['e', 'table'],
	],
	'InfoBox HTML code (street fixture).',
);

# Test.
$tags = Tags::Output::Structure->new;
$obj = Tags::HTML::InfoBox->new(
	'tags' => $tags,
);
$obj->process;
$ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[],
	'Image HTML code (no init).',
);

# Test.
$obj = Tags::HTML::InfoBox->new;
eval {
	$obj->process;
};
is($EVAL_ERROR, "Parameter 'tags' isn't defined.\n",
	"Parameter 'tags' isn't defined.");
clean();