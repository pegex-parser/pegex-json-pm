##
# name:      Pegex::JSON::Data
# abstract:  Pegex Data Structure Builder for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011, 2012

package Pegex::JSON::Data;
use Pegex::Mo;
extends 'Pegex::Receiver';

use boolean;

sub got_map { +{map @$_, map @$_, @{(pop)}} }
sub got_seq { [map @$_, @{(pop)}] }

sub got_string {
    my $string = pop;
    # XXX need to decode other string escapes here
    $string =~ s/\\n/\n/g;
    return $string;
}

sub got_number { $_[1] + 0 }
sub got_true { &boolean::true }
sub got_false { &boolean::false }
sub got_null { undef }
