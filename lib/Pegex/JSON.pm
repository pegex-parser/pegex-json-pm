##
# name:      Pegex::JSON
# abstract:  Pegex Parser for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011
# see:
# - Pegex
# - JSON

use 5.010;

use Pegex 0.18 ();
use boolean 0.28 ();

package Pegex::JSON;
use Pegex::Mo;
extends 'Pegex::Module';

our $VERSION = '0.11';

use constant receiver => 'Pegex::JSON::Data';

1;

=head1 SYNOPSIS

    my $data = Pegex::JSON->parse($json);

=head1 DESCRIPTION

Pegex::JSON is a JSON parser written in Pegex.
