package POE::Session::Exception;

use POE;

use base qw(POE::Session);

use warnings;
use strict;
use vars qw($VERSION $DEATH);

$VERSION = (qw($Revision: 1.5 $))[1];

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

Matt Cashner (eek+cpan@eekeek.org)

=head1 DATE

$Date: 2003/10/16 00:54:13 $

=head1 REVISION

$Revision: 1.5 $

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
