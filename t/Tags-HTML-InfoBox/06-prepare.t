use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::InfoBox;
use Test::MockObject;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::InfoBox->new;
my $ret = $obj->prepare;
is($ret, undef, 'Prepare returns undef.');

# Test.
$obj = Tags::HTML::InfoBox->new;
eval {
	$obj->prepare('bad');
};
is($EVAL_ERROR, "Data object for infobox is not valid.\n",
	"Data object for infobox is not valid.");
clean();

# Test.
$obj = Tags::HTML::InfoBox->new;
my $bad_object = Test::MockObject->new;
eval {
	$obj->init($bad_object);
};
is($EVAL_ERROR, "Data object for infobox is not valid.\n",
	"Data object for infobox is not valid.");
clean();
