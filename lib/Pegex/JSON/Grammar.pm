##
# name:      Pegex::JSON::Grammar
# abstract:  Pegex Grammar for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

package Pegex::JSON::Grammar;
use Mo;
extends 'Pegex::Grammar';

use constant text => '../pegex-json-pgx/json.pgx';

sub tree {
  {
    '+top' => 'TOP',
    'TOP' => {
      '.any' => [
        {
          '-pass' => 1,
          '.ref' => 'map'
        },
        {
          '-pass' => 1,
          '.ref' => 'seq'
        }
      ]
    },
    'boolean' => {
      '.any' => [
        {
          '-pass' => 1,
          '.ref' => 'true'
        },
        {
          '-pass' => 1,
          '.ref' => 'false'
        }
      ]
    },
    'false' => {
      '.rgx' => qr/(?-xism:\G(f)alse)/
    },
    'map' => {
      '.all' => [
        {
          '.rgx' => qr/(?-xism:\G\s*\{\s*)/
        },
        {
          '+qty' => '?',
          '-pass' => 1,
          '.ref' => 'pair',
          '.sep' => {
            '.rgx' => qr/(?-xism:\G\s*,\s*)/
          }
        },
        {
          '.rgx' => qr/(?-xism:\G\s*\}\s*)/
        }
      ]
    },
    'node' => {
      '.any' => [
        {
          '-pass' => 1,
          '.ref' => 'map'
        },
        {
          '-pass' => 1,
          '.ref' => 'seq'
        },
        {
          '-pass' => 1,
          '.ref' => 'scalar'
        }
      ]
    },
    'null' => {
      '.rgx' => qr/(?-xism:\Gnull)/
    },
    'number' => {
      '.rgx' => qr/(?-xism:\G([0-9]+(?:\.[0-9]*)?|\.[0-9]+))/
    },
    'pair' => {
      '.all' => [
        {
          '.ref' => 'string'
        },
        {
          '.rgx' => qr/(?-xism:\G\s*:\s*)/
        },
        {
          '-pass' => 1,
          '.ref' => 'node'
        }
      ]
    },
    'scalar' => {
      '.any' => [
        {
          '.ref' => 'string'
        },
        {
          '.ref' => 'number'
        },
        {
          '.ref' => 'boolean'
        },
        {
          '.ref' => 'null'
        }
      ]
    },
    'seq' => {
      '.all' => [
        {
          '.rgx' => qr/(?-xism:\G\s*\[\s*)/
        },
        {
          '+qty' => '?',
          '-pass' => 1,
          '.ref' => 'node',
          '.sep' => {
            '.rgx' => qr/(?-xism:\G\s*,\s*)/
          }
        },
        {
          '.rgx' => qr/(?-xism:\G\s*\]\s*)/
        }
      ]
    },
    'string' => {
      '.rgx' => qr/(?-xism:\G"((?:\\\\|\\"|[^"\n])*)")/
    },
    'true' => {
      '.rgx' => qr/(?-xism:\G(t)rue)/
    }
  }
}

1;
