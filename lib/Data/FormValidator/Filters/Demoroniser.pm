package Data::FormValidator::Filters::Demoroniser;

use strict;
use vars qw( $VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS );
use Encode::ZapCP1252;

BEGIN {
	require Exporter;
	$VERSION = '0.01';
	@ISA = qw( Exporter );
	@EXPORT = qw();
	%EXPORT_TAGS = (
		'all' => [ qw( demoroniser demoroniser_utf8 ) ]
	);
	@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
}

sub demoroniser {
	return sub { return _demoroniser( shift ) };
}

sub _demoroniser {
	my $str	= shift;
    return  unless(defined $str);

	$str =~ s/\xE2\x80\x9A/,/g;		# 82 - SINGLE LOW-9 QUOTATION MARK
	$str =~ s/\xE2\x80\x9E/,,/g;	# 84 - DOUBLE LOW-9 QUOTATION MARK
	$str =~ s/\xE2\x80\xA6/.../g;	# 85 - HORIZONTAL ELLIPSIS

	$str =~ s/\xCB\x86/^/g;			# 88 - MODIFIER LETTER CIRCUMFLEX ACCENT

	$str =~ s/\xE2\x80\x98/`/g;		# 91 - LEFT SINGLE QUOTATION MARK
	$str =~ s/\xE2\x80\x99/'/g;		# 92 - RIGHT SINGLE QUOTATION MARK
	$str =~ s/\xE2\x80\x9C/"/g;		# 93 - LEFT DOUBLE QUOTATION MARK
	$str =~ s/\xE2\x80\x9D/"/g;		# 94 - RIGHT DOUBLE QUOTATION MARK
	$str =~ s/\xE2\x80\xA2/*/g;		# 95 - BULLET
	$str =~ s/\xE2\x80\x93/-/g;		# 96 - EN DASH
	$str =~ s/\xE2\x80\x94/-/g;		# 97 - EM DASH

	$str =~ s/\xE2\x80\xB9/</g;		# 8B - SINGLE LEFT-POINTING ANGLE QUOTATION MARK
	$str =~ s/\xE2\x80\xBA/>/g;		# 9B - SINGLE RIGHT-POINTING ANGLE QUOTATION MARK

	zap_cp1252($str);

    return $str;
}

sub demoroniser_utf8 {
	return sub { return _demoroniser_utf8( shift ) };
}

sub _demoroniser_utf8 {
	my $str	= shift;
    return  unless(defined $str);

	$str =~ s/\xE2\x80\x9A/,/g;		# 82 - SINGLE LOW-9 QUOTATION MARK
	$str =~ s/\xE2\x80\x9E/„/g;	# 84 - DOUBLE LOW-9 QUOTATION MARK
	$str =~ s/\xE2\x80\xA6/…/g;	# 85 - HORIZONTAL ELLIPSIS

	$str =~ s/\xCB\x86/ˆ/g;		# 88 - MODIFIER LETTER CIRCUMFLEX ACCENT

	$str =~ s/\xE2\x80\x98/‘/g;	# 91 - LEFT SINGLE QUOTATION MARK
	$str =~ s/\xE2\x80\x99/’/g;	# 92 - RIGHT SINGLE QUOTATION MARK
	$str =~ s/\xE2\x80\x9C/“/g;	# 93 - LEFT DOUBLE QUOTATION MARK
	$str =~ s/\xE2\x80\x9D/”/g;	# 94 - RIGHT DOUBLE QUOTATION MARK
	$str =~ s/\xE2\x80\xA2/•/g;	# 95 - BULLET
	$str =~ s/\xE2\x80\x93/–/g;	# 96 - EN DASH
	$str =~ s/\xE2\x80\x94/—/g;	# 97 - EM DASH

	$str =~ s/\xE2\x80\xB9/‹/g;	# 8B - SINGLE LEFT-POINTING ANGLE QUOTATION MARK
	$str =~ s/\xE2\x80\xBA/›/g;	# 9B - SINGLE RIGHT-POINTING ANGLE QUOTATION MARK

	fix_cp1252($str);

    return $str;
}

1;
__END__

=pod

=head1 NAME

Data::FormValidator::Filters::Demoroniser - Data::FormValidator filter that allows you to demoronise a string.

=head1 SYNOPSIS

   use Data::FormValidator::Filters::Demoroniser qw(demoroniser);

   # Data::FormValidator Profile:
   my $dfv_profile = {
      required => [ qw/foo bar/ ],
      field_filters => {
         foo => [ 'trim', demoroniser() ]
      }
   };

=head1 DESCRIPTION

Data::FormValidator filter that allows you to demoronise a string in form 
field values.

=head1 API

This module exports following filters:

=head2 demoroniser

Given a string, will replace the Microsoft "smart" characters with sensible
ACSII versions.

=head2 demoroniser_utf8

The same as demoroniser, but converts into correct UTF8 versions.

=head1 NOTES

Although Data-FormValidator is not a dependency, it is expected that this
module will be used as part of DFV's constraint framework.

This module was originally written as part of the Labyrinth website management
tool.

=head1 SEE ALSO

L<Data::FormValidator>, L<Encode::ZapCP1252>

=head1 THANK YOU

This module was written after Smylers spotted a problem in submitting a survey
for the YAPC::Europe 2009 Perl Conference. Unfortunately the forms were not
accepting the Microsoft "smart" characters and causing problems when submitting
the form. So a big thanks to Smylers for inspiring this module.

=head1 AUTHOR

Barbie, E<lt>barbie@missbarbell.co.ukE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Barbie

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.7 or,
at your option, any later version of Perl 5 you may have available.

=cut
