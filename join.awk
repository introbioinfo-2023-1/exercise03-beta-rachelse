#!/usr/bin/awk -f
NR == FNR { old[$1] = $0; next; }
$1 in old { print old[$1]"\t"$0; }
