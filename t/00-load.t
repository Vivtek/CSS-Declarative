#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'CSS::Declarative' ) || print "Bail out!
";
}

diag( "Testing CSS::Declarative $CSS::Declarative::VERSION, Perl $], $^X" );
