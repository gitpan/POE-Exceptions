# $Id: Exception.pm 629 2005-12-11 23:44:13Z sungo $
package POE::Kernel::Exception;

=pod

=head1 NAME

POE::Kernel::Exception - POE::Kernel extension for handling exceptions

=begin devel

=cut

use POE;

use base qw(POE::Kernel);

use warnings;
use strict;

our $VERSION = '3.'.sprintf "%04d", (qw($Rev: 8 $))[1];

=head2 EV_TYPE

=head2 EV_ARGS

=head2 ET_SIGNAL

In order to properly override C<_dispatch_event>, we have to pull in some
constants from L<POE::Kernel>.

=cut

BEGIN {
	eval 'sub EV_TYPE () { ' . POE::Kernel::EV_TYPE() . ' }';
	eval 'sub EV_ARGS () { ' . POE::Kernel::EV_ARGS() . ' }';
	eval 'sub ET_SIGNAL () { ' . POE::Kernel::ET_SIGNAL() . ' }';
};

sub _dispatch_event {
	my $self = shift;
	my ($event_type, $args) = @_[EV_TYPE, EV_ARGS];
	my $retval = $self->SUPER::_dispatch_event(@_);
	if ($event_type & ET_SIGNAL) {
		my $signal = $args->[0];
		my $msg = $args->[1];
		my @responses = $POE::Kernel::poe_kernel->_data_sig_handled_status();
		if ($signal eq 'DIE') {
			if($POE::Session::Exception::DEATH) {
				die "double exception fault: $msg";
			}
			my $total_handled;
			if($POE::VERSION > 0.30) {
				$total_handled = $responses[0];
			} else {
				$total_handled = $responses[2];
			}
			unless($total_handled) {  # equiv to sig_handled();
				die "unhandled exception: $msg";
			}
		}
	}
	return $retval;
}

1;
__END__

=pod

=head1 AUTHOR

Matt Cashner (sungo@pobox.com)

See L<perlwhore.com> for the latest on all of sungo's modules.

=head1 DATE

$Date: 2006-03-26 17:13:33 -0500 (Sun, 26 Mar 2006) $

=head1 REVISION

$Revision: 8 $

=head1 NOTE

Please see POE::Exceptions for documentation on how to use this extension

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

# sungo // vim: ts=4 sw=4 et
