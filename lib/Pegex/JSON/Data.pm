##
# name:      Pegex::JSON::Data
# abstract:  Pegex Data Structure Builder for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

package Pegex::JSON::Data;
use Pegex::Mo;
extends 'Pegex::Receiver';

sub got_map {
    my ($self, $pairs) = @_;
    return {map @$_, map @$_, @$pairs};
}

sub got_seq {
    my ($self, $nodes) = @_;
    return [map @$_, map @$_, $nodes];
}

sub got_string {
    my ($self, $string) = @_;
    $string = $string->{1};
    $string =~ s/\\n/\n/g; # XXX need to do other escapes
    return $string;
}

sub got_number {
    my ($self, $number) = @_;
    return $number->{1} + 0;
}

sub got_boolean {
    require boolean;
    my ($self, $boolean) = @_;
    return
        $boolean->{1} eq 't' ? &boolean::true :
        $boolean->{1} eq 'f' ? &boolean::false : undef;
}

1;
