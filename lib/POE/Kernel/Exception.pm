package POE::Kernel::Exception;

use POE;

use base qw(POE::Kernel);

use warnings;
use strict;
use vars qw($VERSION);

$VERSION = (qw($Revision: 1.7 $))[1];

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
            unless($responses[2]) {  # equiv to sig_handled();
                die "unhandled exception: $msg";
            }
        }
    }
    return $retval;
}

=head1 NAME

POE::Kernel::Exception - POE::Kernel extension for handling exceptions

=head1 AUTHOR

Matt Cashner (eek+cpan@eekeek.org)

=head1 DATE

$Date: 2003/10/16 00:54:13 $

=head1 REVISION

$Revision: 1.7 $

=head1 NOTE

Please see POE::Exceptions for documentation on how to use this extension

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