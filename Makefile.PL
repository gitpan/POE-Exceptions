#!/usr/bin/perl
# $Id: Makefile.PL,v 1.2 2003/06/24 02:14:45 sungo Exp $

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
    PREREQ_PM      => { 'POE' => '0.25',
                        'Test::More' => '0',
                        'Carp' => '0',
                      },
  );

