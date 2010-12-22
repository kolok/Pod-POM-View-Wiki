use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Pod::POM::View::Wiki',
    AUTHOR              => q{Nicolas Oudard <nicolas@oudard.org>},
    VERSION_FROM        => 'lib/Pod/POM/View/Wiki.pm',
    ABSTRACT_FROM       => 'lib/Pod/POM/View/Wiki.pm',
    LICENSE             => 'perl',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Pod::POM'   => 0.27,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Pod-POM-View-Wiki-*' },
);
