package Pegex::JSON;
# VERSION

use Pegex::Base;

use Pegex::Parser;
use Pegex::JSON::Grammar;
use Pegex::JSON::Data;

sub load {
    my ($self, $json) = @_;
    Pegex::Parser->new(
        grammar => Pegex::JSON::Grammar->new,
        receiver => Pegex::JSON::Data->new,
    )->parse($json);
}

1;

=encoding utf8

=head1 NAME

Pegex::JSONY - Pegex Loader for JSON

=head1 SYNOPSIS

    my $data = Pegex::JSON->new->load($json);

=head1 DESCRIPTION

Pegex::JSON is a JSON parser written in Pegex.

=head1 SEE ALSO

=over

=item L<Pegex>

=item L<JSON>

=back

=head1 AUTHOR

Ingy döt Net (ingy) <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2011-2014 Ingy döt Net

=head1 LICENSE

This library is free software and may be distributed under the same terms as
perl itself.
