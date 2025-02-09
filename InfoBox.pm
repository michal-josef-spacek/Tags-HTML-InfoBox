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
		['css_class', 'lang'], @params);
	my $self = $class->SUPER::new(@{$other_params_ar});

	# CSS style for info box.
	$self->{'css_class'} = 'info-box';

	$self->{'lang'} = undef;

	# Process params.
	set_params($self, @{$object_params_ar});

	# Object.
	return $self;
}

sub _cleanup {
	my $self = shift;

	delete $self->{'_infobox'};

	return;
}

sub _init {
	my ($self, @params) = @_;

	return $self->_set_infobox(@params);
}

sub _prepare {
	my ($self, @params) = @_;

	return $self->_set_infobox(@params);
}

# Process 'Tags'.
sub _process {
	my $self = shift;

	if (! exists $self->{'_infobox'}) {
		return;
	}

	$self->{'tags'}->put(
		['b', 'table'],
		['a', 'class', $self->{'css_class'}],
	);
	foreach my $item (@{$self->{'_infobox'}->items}) {
		$self->{'tags'}->put(
			['b', 'tr'],
		);
		if ($item->can('icon_char') && $item->icon_char) {
			$self->{'tags'}->put(
				['b', 'td'],
				['a', 'class', 'icon'],
				['d', $item->icon_char],
				['e', 'td'],
			);
		} elsif ($item->can('icon_url') && $item->icon_url) {
			$self->{'tags'}->put(
				['b', 'td'],
				['b', 'img'],
				['a', 'src', $item->icon_url],
				['e', 'img'],
				['e', 'td'],
			);
		} else {
			$self->{'tags'}->put(
				['b', 'td'],
				['e', 'td'],
			);
		}
		$self->{'tags'}->put(
			['b', 'td'],
			(defined $self->{'lang'} && defined $item->text->lang
				&& $item->text->lang ne $self->{'lang'}) ? (

				['a', 'lang', $self->text->lang],
			) : (),
			defined $item->uri ? (
				['b', 'a'],
				['a', 'href', $item->uri],
			) : (),
			['d', $item->text->text],
			defined $item->uri ? (
				['e', 'a'],
			) : (),
			['e', 'td'],
			['e', 'tr'],
		);
	}
	$self->{'tags'}->put(
		['e', 'table'],
	);

	return;
}

sub _process_css {
	my $self = shift;

	if (! exists $self->{'_infobox'}) {
		return;
	}

	$self->{'css'}->put(
		['s', '.'.$self->{'css_class'}],
		['d', 'background-color', '#32a4a8'],
		['d', 'padding', '1em'],
		['e'],

		['s', '.'.$self->{'css_class'}.' .icon'],
		['d', 'text-align', 'center'],
		['e'],

		['s', '.'.$self->{'css_class'}.' a'],
		['d', 'text-decoration', 'none'],
		['e'],
	);

	return;
}

sub _set_infobox {
	my ($self, $infobox) = @_;

	if (! defined $infobox) {
		return;
	}

	if (! blessed($infobox) || ! $infobox->isa('Data::InfoBox')) {
		err 'Data object for infobox is not valid.';
	}

	$self->{'_infobox'} = $infobox;

	return;
}

1;
