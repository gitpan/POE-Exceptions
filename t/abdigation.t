#!/usr/bin/perl

use warnings;
use strict;

use Test::More qw(no_plan);
BEGIN { use_ok('POE::Exceptions'); };

use POE;

eval {

POE::Session::Exception->create
  ( inline_states =>
    { _start => sub {
        $_[KERNEL]->sig('DIE','death');
        die "we die now";
      },
      death => sub {
        # not handling it here
        ok(1,"not handling die");
        return 0;
      },
      _stop => sub {
        warn "Termination";
      }
    },
  );

$poe_kernel->run();

};

like($@, qr/unhandled exception/, "die not caught by order of signal handler");
