# $Id: Exception.pm 629 2005-12-11 23:44:13Z sungo $
package POE::Session::Exception;

=pod

=head1 NAME

POE::Session::Exception - POE::Session extension for handling exceptions

=begin devel

=cut

use POE;

use base qw(POE::Session);

use warnings;
use strict;
use vars qw($DEATH);

our $VERSION = '3.'.sprintf "%04d", (qw($Rev: 8 $))[1];

=head2 create

We override POE::Session::create so we can install our version of the
kernel.

=cut

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

1;
__END__

=end devel

=head1 AUTHOR

Matt Cashner (sungo@pobox.com)

See L<http://perlwhore.com> for the latest on all of sungo's modules.

=head1 DATE

$Date: 2006-03-26 17:13:33 -0500 (Sun, 26 Mar 2006) $

=head1 REVISION

$Revision: 8 $

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

