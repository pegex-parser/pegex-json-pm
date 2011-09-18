use TestML -run,
    -require_or_skip => 'YAML::XS';

use Pegex::JSON;

sub parse {
#     $Pegex::Parser::Debug = 1;
    return Pegex::JSON->new->parse((shift)->value);
}

sub yaml {
    my $yaml = YAML::XS::Dump((shift)->value);
    $yaml =~ s/^---\s+//;
    return $yaml;
}

__DATA__
%TestML 1.0

Plan = 9;

*json.parse.yaml == *yaml;

=== Simple Mapping
--- json
{ "a": 1, "b": 2 }
--- yaml
a: 1
b: 2

=== Empty Mapping
--- json
{}
--- yaml
{}

=== One Pair Mapping
--- json
{"alphabet": "city"}
--- yaml
alphabet: city

=== Simple Sequence
--- json
[ "a", 2, true ]
--- yaml
- a
- 2
- 1

=== Empty Sequence
--- json
[]
--- yaml
[]

=== One Elem Sequence
--- json
["foo"]
--- yaml
- foo

=== Seq in Map
--- json
{
    "xyz": [1,2,3]
}
--- yaml
xyz:
- 1
- 2
- 3

=== Map in Seq
--- json
[
{"xyz": [1,2,3]}
]
--- yaml
- xyz:
  - 1
  - 2
  - 3

=== Leading and Trailing Whitespace
--- json
       [
{  "xyz"  : [  1  ,  2  ,  3  ]  }  
]      
--- yaml
- xyz:
  - 1
  - 2
  - 3

