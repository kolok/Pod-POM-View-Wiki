#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Pod::POM::View::Wiki' ) || print "Bail out!
";
}

diag( "Testing Pod::POM::View::Wiki $Pod::POM::View::Wiki::VERSION, Perl $], $^X" );
