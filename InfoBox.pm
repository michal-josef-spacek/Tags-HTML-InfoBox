package Tags::HTML::InfoBox;

use base qw(Tags::HTML);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Error::Pure qw(err);
use Scalar::Util qw(blessed);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my ($object_params_ar, $other_params_ar) = split_params(
		['css_box', 'lang'], @params);
	my $self = $class->SUPER::new(@{$other_params_ar});

	$self->{'lang'} = undef;

	# CSS style for info box.
	$self->{'css_box'} = 'info-box';

	# Process params.
	set_params($self, @{$object_params_ar});

	# Object.
	return $self;
}

# Process 'Tags'.
sub _process {
	my ($self, $infobox) = @_;

	if (! blessed($infobox) && ! $infobox->isa('Data::InfoBox')) {
		err 'Data object for infobox is not valid.';
	}

	$self->{'tags'}->put(
		['b', 'div'],
		['a', 'class', $self->{'css_box'}],
	);
	foreach my $item (@{$infobox->items}) {
		$self->{'tags'}->put(
			['b', 'div'],
		);
		if ($item->icon_utf8) {
			$self->{'tags'}->put(
				['b', 'span'],
				['a', 'class', 'icon'],
				['d', $item->icon_utf8],
				['e', 'span'],
			);
		}
		# TODO icon_url
		$self->{'tags'}->put(
			['b', 'span'],
			(defined $self->{'lang'} && defined $item->text->lang
				&& $item->text->lang ne $self->{'lang'}) ? (

				['a', 'lang', $self->text->lang],
			) : (),
			['d', $item->text->text],
			['e', 'span'],
			['e', 'div'],
		);
	}
	$self->{'tags'}->put(
		['e', 'div'],
	);

	return;
}

sub _process_css {
	my $self = shift;

	$self->{'css'}->put(
		['s', '.'.$self->{'css_box'}],
		['d', 'background-color', '#32a4a8'],
		['d', 'padding', '1em'],
		['e'],
	);

	return;
}

1;
