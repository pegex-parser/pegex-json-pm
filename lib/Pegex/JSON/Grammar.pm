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
    '+top' => 'json',
    'boolean' => {
      '.any' => [
        {
          '.ref' => 'true'
        },
        {
          '.ref' => 'false'
        }
      ]
    },
    'false' => {
      '.rgx' => qr/(?-xism:\Gfalse)/
    },
    'json' => {
      '.all' => [
        {
          '.rgx' => qr/(?-xism:\G\s*)/
        },
        {
          '.any' => [
            {
              '.ref' => 'map'
            },
            {
              '.ref' => 'seq'
            }
          ]
        },
        {
          '.rgx' => qr/(?-xism:\G\s*)/
        }
      ]
    },
    'map' => {
      '.all' => [
        {
          '.rgx' => qr/(?-xism:\G\s*\{\s*)/
        },
        {
          '+mod' => '?',
          '.all' => [
            {
              '.ref' => 'pair'
            },
            {
              '+mod' => '*',
              '.all' => [
                {
                  '.rgx' => qr/(?-xism:\G\s*,\s*)/
                },
                {
                  '.ref' => 'pair'
                }
              ]
            }
          ]
        },
        {
          '.rgx' => qr/(?-xism:\G\s*\}\s*)/
        }
      ]
    },
    'node' => {
      '.any' => [
        {
          '.ref' => 'map'
        },
        {
          '.ref' => 'seq'
        },
        {
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
          '+mod' => '?',
          '.all' => [
            {
              '.ref' => 'node'
            },
            {
              '+mod' => '*',
              '.all' => [
                {
                  '.rgx' => qr/(?-xism:\G\s*,\s*)/
                },
                {
                  '.ref' => 'node'
                }
              ]
            }
          ]
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
      '.rgx' => qr/(?-xism:\Gtrue)/
    }
  }
}

1;
