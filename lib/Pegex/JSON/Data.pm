##
# name:      Pegex::JSON::Data
# abstract:  Pegex Data Structure Builder for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

package Pegex::JSON::Data;
use Pegex::Mo;
extends 'Pegex::Receiver';

use boolean;

sub got_map {
    my ($self, $pairs) = @_;
    return {map @$_, map @$_, @$pairs};
}

sub got_seq {
    my ($self, $list) = @_;
    return [map @$_, map @$_, $list];
}

sub got_string {
    my ($self, $string) = @_;
    $string = $string->{1};
    $string =~ s/\\n/\n/g; # XXX need to do other escapes
    return $string;
}

sub got_number {
    return $_[1]->{1} + 0;
}

sub got_true {
    return &boolean::true;
}

sub got_false {
    return &boolean::false;
}

sub got_null {
    return undef;
}

1;
