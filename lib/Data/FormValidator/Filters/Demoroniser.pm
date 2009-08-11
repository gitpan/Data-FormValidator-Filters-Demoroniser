package Data::FormValidator::Filters::Demoroniser;

use strict;
use vars qw( $VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS );
use Text::Demoroniser;

BEGIN {
	require Exporter;
	$VERSION = '0.02';
	@ISA = qw( Exporter );
	@EXPORT = qw();
	%EXPORT_TAGS = (
		'all' => [ qw( demoroniser demoroniser_utf8 ) ]
	);
	@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
}

sub demoroniser {
	return sub { return Text::Demoroniser::demoroniser( shift ) };
}

sub demoroniser_utf8 {
	return sub { return Text::Demoroniser::demoroniser_utf8( shift ) };
}

1;
__END__

=pod

=head1 NAME

Data::FormValidator::Filters::Demoroniser - A Data::FormValidator filter that allows you to demoronise a string.

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

This module exports the following filters:

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

L<Data::FormValidator>, L<Text::Demoroniser>

=head1 THANK YOU

This module was written after Smylers spotted a problem in submitting a survey
for the YAPC::Europe 2009 Perl Conference. Unfortunately the forms were not
accepting the Microsoft "smart" characters and causing problems when submitting
the form. So a big thanks to Smylers for inspiring this module.

Also thanks to Brian Cassidy for further suggestions for improvements.

=head1 AUTHOR

Barbie, E<lt>barbie@missbarbell.co.ukE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Barbie

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.7 or,
at your option, any later version of Perl 5 you may have available.

=cut
