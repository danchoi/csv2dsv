# csv2dsv

Converts CSV to delimiter separated value (DSV) format. 

Also provides `dsv2csv` which does the reverse.

## Install

From project directory:

    stack install

Requires [stack](http://docs.haskellstack.org/en/stable/README.html), a Haskell build tool.

## Synopses

```
csv2dsv

Usage: csv2dsv [-d|--delimiter CHAR] FILE
  Converts CSV to DSV format

Available options:
  -h,--help                Show this help text
  -d,--delimiter CHAR      Delimiter characters. Defaults to \t.
  FILE                     Source CSV file. '-' for STDIN

```

```
dsv2csv

Usage: dsv2csv [-d|--delimiter CHAR] FILE
  Converts DSV to CSV format

Available options:
  -h,--help                Show this help text
  -d,--delimiter CHAR      Delimiter characters of DSV input. Defaults to \t.
  FILE                     Source DSV file. '-' for STDIN

```


## Author

Daniel Choi https://github.com/danchoi
