package POE::Kernel::Exception;

use POE;

use base qw(POE::Kernel);

use warnings;
use strict;
use vars qw($VERSION);

$VERSION = (qw($Revision: 1.2 $))[1];

BEGIN {
  # Cheezy rebless hack to subclass POE::Kernel instance.
  $POE::Kernel::poe_kernel = bless $POE::Kernel::poe_kernel, __PACKAGE__;

  # Cheezy import hack.  TODO: Make Kernel constants macros again.
  eval 'sub ST_TYPE () { ' . POE::Kernel::ST_TYPE() . ' }';
  eval 'sub ST_ARGS () { ' . POE::Kernel::ST_ARGS() . ' }';
  eval 'sub ET_SIGNAL () { ' . POE::Kernel::ET_SIGNAL() . ' }';
};

sub _dispatch_event {
  my $self = shift;
  my ($event_type, $args) = @_[ST_TYPE, ST_ARGS];

  my $retval = $self->SUPER::_dispatch_event(@_);

  if ($event_type & ET_SIGNAL) {
    if ($args->[0] eq 'DIE') {
      if ($@) {
        die "double exception: $@";
      }
      elsif (!$retval) {
        die "unhandled exception: $args->[1]";
      }
    }
  }
}

=head1 NAME

POE::Kernel::Exception - POE::Kernel extension for handling exceptions

=head1 AUTHOR

Matt Cashner (eek+cpan@eekeek.org)

=head1 DATE

$Date: 2002/05/28 03:50:48 $

=head1 REVISION

$Revision: 1.2 $

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
