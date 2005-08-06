package POE::Exceptions;

use strict;
use warnings;

use POE::Kernel::Exception;
use POE::Session::Exception;

our $VERSION = '1.'.sprintf "%04d", (qw($Rev: 528 $))[1];

=head1 NAME

POE::Exceptions - POE class for handling exceptions

=head1 SYNOPSIS

    use POE::Exceptions;

    POE::Session::Exception->create(
        inline_states => {
            _start => sub { print 'START';
                            $_[KERNEL]->sig('DIE','death_handled');
                          },
            death_handled => sub { print 'EXCEPTION CAUGHT' 
                                   $_[KERNEL]->sig_handled();
                                 },
            _stop => { print 'END' }
        }
    );

    $poe_kernel->run();

=head1 AUTHOR

Matt Cashner (sungo@pobox.com)

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

=head1 LICENSE

Copyright (c) 2002-2005, Matt Cashner. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

=over 4

=item * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.  

=item * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

=item * Neither the name of the Matt Cashner nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

=back

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

1;
