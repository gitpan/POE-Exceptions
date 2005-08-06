package POE::Session::Exception;

use POE;

use base qw(POE::Session);

use warnings;
use strict;
use vars qw($DEATH);

our $VERSION = '1.'.sprintf "%04d", (qw($Rev: 528 $))[1];

sub create {
    my $class = shift;
    $POE::Kernel::poe_kernel = bless $POE::Kernel::poe_kernel, 'POE::Kernel::Exception';
    $POE::Kernel::poe_kernel->_initialize_kernel_session();
    return $class->SUPER::create(@_);
}


sub _invoke_state {
    my $self = shift;
    my $retval = eval {
        $self->SUPER::_invoke_state(@_);
    };

    if($@) {
        $DEATH = 1;
        $poe_kernel->signal($self,'DIE',$@);
    } elsif ($_[1] ne '_signal') {
        $DEATH = 0;
    }
    return $retval;
}

=head1 NAME

POE::Session::Exception - POE::Session extension for handling exceptions

=head1 AUTHOR

Matt Cashner (sungo@pobox.com)

=head1 DATE

$Date: 2005-08-06 16:38:12 -0400 (Sat, 06 Aug 2005) $

=head1 REVISION

$Revision: 528 $

=head1 NOTE

Please see POE::Exceptions for documentation on how to use this extension.

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
