package POE::Exceptions;

use strict;
use warnings;

use POE::Kernel::Exception;
use POE::Session::Exception;

=head1 NAME

POE::Exceptions - POE class for handling exceptions

=head1 SYNOPSIS

    use POE::Exceptions;

    POE::Session::Exception->create(
        inline_states => {
            _start => sub { print 'START';
                            $_[KERNEL]->sig('DIE','death_handled');
                            return 1; 
                          },
            death_handled => sub { print 'EXCEPTION CAUGHT' },
            _stop => { print 'END' }
        }
    );

    $poe_kernel->run();

=head1 AUTHOR

Matt Cashner (eek+cpan@eekeek.org)

=head1 DISCUSSION

POE::Exceptions extends POE to catch exceptions neatly. A new signal,
C<DIE>, is introduced. This signal will be fired every time an exception
occurs. (For those of you new to the term B<exception>, an exception is
whenever the code decides to bail out by C<die>'ing.)  If the signal
handler returns 1 (as in the example above), POE will assume that the
handler dealt with the signal appropriately. If the signal handler
returns 0, POE will assume that the handler does not want to deal with
the signal and POE will propgate the exception as if the handler never
existed.

B<Caveat:> POE::Exceptions will die on its own in the case of a double
exception fault. If the C<DIE> signal handler itself throws an
exception, POE::Exceptions will shut the program down and bail out.

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2002, Matt Cashner 

Permission is hereby granted, free of charge, to any person obtaining 
a copy of this software and associated documentation files (the 
"Software"), to deal in the Software without restriction, including 
without limitation the rights to use, copy, modify, merge, publish, 
distribute, sublicense, and/or sell copies of the Software, and to 
permit persons to whom the Software is furnished to do so, subject 
to the following conditions:

The above copyright notice and this permission notice shall be included 
in all copies or substantial portions of the Software.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

1;
