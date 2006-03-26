# $Id: Makefile.PL 629 2005-12-11 23:44:13Z sungo $

print STDERR <<EOF;

+==============================================================+
| THIS DISTRIBUTION IS DEPRECATED! As of POE 0.33, the         | 
| functionality provided by this distribution has been rolled  |
| back into the core of POE. Please upgrade to POE 0.33 or     |
| later.                                                       |
|                                                              |
| This distribution is deprecated and will receive no further  |
| updates. At some point in the near future, this distribution |
| will be removed entirely from CPAN.                          |
+==============================================================+

EOF

use inc::Module::Install;

name            ('POE-Exceptions');
author          ('Matt Cashner (sungo@pobox.com)');
version_from    ('VERSION');
license         ('bsd');

requires        ('POE');
requires        ('Test::More');

build_requires  ('Test::Distribution');
build_requires  ('Test::Pod::Coverage');
build_requires  ('Module::Signature');

WriteAll();

