# $Id: Makefile.PL 526 2005-08-06 20:33:24Z sungo $

use inc::Module::Install;

name           ('POE-Exceptions');
author         ('Matt Cashner (sungo@pobox.com)');
version_from   ('VERSION');
license        ('bsd');

requires       ('POE');
requires       ('Test::More');
requires       ('Carp');

sign           (1);

WriteAll();

