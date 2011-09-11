##
# name:      Pegex::JSON::Data
# abstract:  Pegex Data Structure Builder for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

package Pegex::JSON::Data;
use Mo;
extends 'Pegex::Receiver';

sub got_json {
    return $_[1][1];
}

sub got_node {
    return $_[1];
}

sub got_scalar {
    return $_[1];
}

sub got_map {
    my $map = {};
    my $array = $_[1][1];
    my $pair = shift @$array or return $map;
    $map->{$pair->[0]} = $pair->[1];
    my $pairs = shift @$array or return $map;
    $pairs = $pairs->[0];
    shift @$pairs;
    for my $pair (@$pairs) {
        $map->{$pair->[0]} = $pair->[1];
    }
    return $map;
}

sub got_seq {
    my $seq = [];
    my $array = $_[1][1];

    return $seq unless @$array;
    push @$seq, shift @$array;
    return $seq unless @$array;
    $array = $array->[0];
    for my $elem (@$array) {
        push @$seq, $elem->[1];
    }
    return $seq;
}

sub got_pair {
    return [
        $_[1][0], $_[1][2]
    ];
}

sub got_string {
    return $_[1]{1};
}

sub got_number {
    return $_[1]{1} + 0;
}

sub got_boolean {
    return $_[1];
}

sub got_true {
    return 1;
}

sub got_false {
    return 0;
}

1;
