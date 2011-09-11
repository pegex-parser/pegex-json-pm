##
# name:      Pegex::JSON
# abstract:  Pegex Parser for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

use 5.010;
use Pegex 0.16;
use Mo 0.15;

package Pegex::JSON;
use Mo;
extends 'Pegex::Module';

our $VERSION = '0.10';

has receiver => default => sub { 'Pegex::JSON::Data' };

1;

=head1 SYNOPSIS

    my $data = Pegex::JSON->parse($json);

=head1 DESCRIPTION

Pegex::JSON is a JSON parser written in Pegex.