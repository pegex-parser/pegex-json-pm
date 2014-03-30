package Pegex::JSON::Grammar;
use Pegex::Base;
extends 'Pegex::Grammar';

use constant file => '../json-pgx/json.pgx';

sub make_tree {
  {
    '+grammar' => 'json',
    '+include' => 'pegex-atoms',
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
      '.rgx' => qr/\Gfalse/
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
          '.rgx' => qr/\G\s*\{\s*/
        },
        {
          '+min' => 0,
          '.ref' => 'pair',
          '.sep' => {
            '.rgx' => qr/\G\s*,\s*/
          }
        },
        {
          '.rgx' => qr/\G\s*\}\s*/
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
      '.rgx' => qr/\Gnull/
    },
    'number' => {
      '.rgx' => qr/\G(\-?(?:0|[1-9][0-9]*)(?:\.[0-9]*)?(?:[eE][\-\+]?[0-9]+)?)/
    },
    'pair' => {
      '.all' => [
        {
          '.ref' => 'string'
        },
        {
          '.rgx' => qr/\G\s*:\s*/
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
          '.rgx' => qr/\G\s*\[\s*/
        },
        {
          '+min' => 0,
          '.ref' => 'node',
          '.sep' => {
            '.rgx' => qr/\G\s*,\s*/
          }
        },
        {
          '.rgx' => qr/\G\s*\]\s*/
        }
      ]
    },
    'string' => {
      '.rgx' => qr/\G"((?:\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})|[^"\x00-\x1f])*)"/
    },
    'true' => {
      '.rgx' => qr/\Gtrue/
    }
  }
}

1;
