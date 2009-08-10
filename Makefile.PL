use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'			=> 'Data::FormValidator::Filters::Demoroniser',
    'VERSION_FROM'	=> 'lib/Data/FormValidator/Filters/Demoroniser.pm',
    'PREREQ_PM'		=> {

        Encode::ZapCP1252   => 0,
		Test::More	        => 0.70,	# for testing
	},
	NO_META			=> 1,

    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT	=> 'A Data::FormValidator filter that allows you to demoronise a string',
       AUTHOR	=> 'Barbie <barbie@cpan.org>') : ()),
);
