#!/usr/bin/env bash
# Shuffle paragraphs separated by blank lines.
# Lines stating with % are ignored.
# Return latex code for 3 diagrams per line.

sed '
# Delete comment lines
  /^%/d
# Group paragraphs in lines
  /^[ \t]*$/!{
    H
    $!d
  }
  x
  s/\n//g' |
sed '
# Delete remaining blank lines
  /^[ \t]*$/d' |
sort -R | # Shuffle lines
awk '
  NR%3 == 1 { printf "\\setbox\\diagone=\\diagram{%%\n%s}%%\n", $0 }
  NR%3 == 2 { printf "\\setbox\\diagtwo=\\diagram{%%\n%s}%%\n", $0 }
  NR%3 == 0 { print "\\hbox to \\hsize{%"
              print "\\box\\diagone\\hfil\\box\\diagtwo\\hfil"
              printf "\\diagram{%%\n%s}}%%\n", $0
              print "\\bigskip\\bigskip" }
  END { if (NR%3 == 1) {
          print "\\hbox to \\hsize{%"
          print "\\box\\diagone\\hfil}%"
        }
        else if (NR%3 == 2) {
          print "\\hbox to \\hsize{%"
          print "\\box\\diagone\\hfil\\box\\diagtwo\\hfil"
          print "\\hbox to \\diagramwidth{\\hfil}}%"
        }
      }'
