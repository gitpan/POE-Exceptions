#!/usr/bin/perl
# $Id: Makefile.PL,v 1.1.1.1 2002/05/28 02:53:04 matt Exp $

use ExtUtils::MakeMaker;
use File::Find;

my @tests;
sub wanted { /\.t$/ && push @tests, $_ }
find({ wanted => \&wanted , no_chdir => 1}, 't/');
@tests = sort @tests;
WriteMakefile
  ( NAME           => 'POE::Exceptions',

    ( ($^O eq 'MacOS')
      ? ()
      : ( AUTHOR   => 'Matt Cashner (eek+cpan@eekeek.org)',
          ABSTRACT => 'Exception Handling for POE',
        )
    ),

    VERSION_FROM   => 'VERSION',
    dist           => { 'COMPRESS' => 'gzip -9f',
                        'SUFFIX'   => 'gz',
                      },
    test => {
            TESTS => join " ", @tests
    }, 
    PREREQ_PM      => { 'POE' => '.19',
                        'Test::More' => '0',
                        'Carp' => '0',
                      },
  );

