use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'CSS::Declarative',
    AUTHOR              => q{Michael Roberts <michael@vivtek.com>},
    VERSION_FROM        => 'lib/CSS/Declarative.pm',
    ABSTRACT_FROM       => 'lib/CSS/Declarative.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Decl' => 0.08,
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'CSS-Declarative-*' },
);
