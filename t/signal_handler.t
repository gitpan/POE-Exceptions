#!/usr/bin/perl

use warnings;
use strict;

use Test::More qw(no_plan);
BEGIN { use_ok('POE::Exceptions'); } 
use POE;

eval {

POE::Session::Exception->create
  ( inline_states =>
    { _start => sub {
        $_[KERNEL]->sig('DIE','death_handled');
        die "this die should be handled";
      },
      death_handled => sub {
        ok(1,"HANDLED EXCEPTION: $_[ARG1]");
        $_[KERNEL]->sig('DIE','death_redieing');
        $_[KERNEL]->yield( "die_again" );
        $_[KERNEL]->sig_handled();
      },
      die_again => sub {
        die "this die will be handled, too";
      },
      death_redieing => sub {
        ok(1,"REDIEING EXCEPTION: $_[ARG1]");
        die "dieing from a death handler";
      },
      _stop => sub {
        warn "Termination";
      }
    },
  );

$poe_kernel->run();
};

ok($@, 'double exception caught');
