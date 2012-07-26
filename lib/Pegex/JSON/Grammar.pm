##
# name:      Pegex::JSON::Grammar
# abstract:  Pegex Grammar for JSON
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011, 2012

package Pegex::JSON::Grammar;
use Pegex::Mo;
extends 'Pegex::Grammar';

use constant text => '../json-pgx/json.pgx';

sub make_tree {
  {
    '+grammar' => 'json',
    '+toprule' => 'json',
    '+version' => '0.0.1',
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
      '.any' => [
        {
          '.ref' => 'map'
        },
        {
          '.ref' => 'seq'
        }
      ]
    },
    'map' => {
      '.all' => [
        {
          '.rgx' => qr/(?-xism:\G\s*\{\s*)/
        },
        {
          '+min' => 0,
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
      '.rgx' => qr/(?-xism:\G(\-?(?:0|[1-9][0-9]*)(?:\.[0-9]*)?(?:[eE][\-\+]?[0-9]+)?))/
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
          '+min' => 0,
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
      '.rgx' => qr/(?-xism:\Gtrue)/
    }
  }
}

1;
