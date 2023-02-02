# oc - occurrence-count

## description

Count occurrences of a string or pattern in each line of a file

## usage

    ${0##*/} [OPTION]... [FILE]...

    OPTION:

        -h              Display help

        -E <pattern>    Interpret PATTERN as an extended regular expression
        -F <pattern>    Interpret PATTERN as a list of fixed strings (instead of regular expressions), separated by newlines, any of which is to be matched.

        -P              Print the file name for each match.  This is the default when there is more than one file to search.
        -p              Suppress the prefixing of file names on output.  This is the default when there is only one file (or only standard input) to search.

        -i              Ignore case distinctions, so that characters that differ only in case match each other.
        -n              Prefix each line of output with the 1-based line number within its input file.
        -o              Print only the matching lines.
        -t              Display the count of occurrences in the file

    FILE:

        With no FILE, or when FILE is -, read standard input.

## examples

    $ bin/oc -no -E 's[aei]' /etc/passwd
    22:1:messagebus:x:103:107::/nonexistent:/usr/sbin/nologin
    29:2:cups-pk-helper:x:110:115:user for cups-pk-helper service,,,:/home/cups-pk-helper:/usr/sbin/nologin
    30:2:saned:x:111:117::/var/lib/saned:/usr/sbin/nologin
    31:1:speech-dispatcher:x:112:29:Speech Dispatcher,,,:/var/run/speech-dispatcher:/bin/false
    33:3:pulse:x:114:119:PulseAudio daemon,,,:/var/run/pulse:/usr/sbin/nologin
    35:1:gdm:x:116:122:Gnome Display Manager:/var/lib/gdm3:/bin/false
    39:1:omi:x:999:998::/home/omi:/bin/false

    $ bin/oc -Piot -F $'mes\ngno' /etc/passwd
    /etc/passwd:3:games:x:5:60:games:/usr/games:/usr/sbin/nologin
    /etc/passwd:1:messagebus:x:103:107::/nonexistent:/usr/sbin/nologin
    /etc/passwd:1:gdm:x:116:122:Gnome Display Manager:/var/lib/gdm3:/bin/false
    /etc/passwd:#5
