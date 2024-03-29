NAME
====

oc - Count occurrences of a string or pattern in each line of files

SYNOPSIS
========

**oc** \[*OPTION*\] \[*FILE*\]

DESCRIPTION
===========

**oc** is a small utility to count occurences of a string or pattern in
each line of files.

With no FILE, or when FILE is `-`, read standard input.

OPTIONS
=======

**-h**  
Display help.

**-v**  
Display version.

Select and sort items
---------------------

**-c** *selection*  
Check if the current line count is in the given selection. If true, the
matching line is displayed. The selection is a list separed by the `,`
character. Each item of the list is an integer or a range `begin-end`
where **begin** is by default 1 (if `-o` setted) or 0. **begin** and
**end** values are optional and inclusives.

**-E** *pattern*  
Interpret PATTERN as an extended regular expression.

**-F** *pattern*  
Interpret PATTERN as a list of fixed strings (instead of regular
expressions), separated by newlines, any of which is to be matched.

**-P**  
Print the file name for each line. This is the default when there is
more than one file to search.

**-p**  
Suppress the prefixing of file names on output. This is the default when
there is only one file (or only standard input) to search.

**-i**  
Ignore case distinctions, so that characters that differ only in case
match each other.

**-n**  
Prefix each line of output with the 1-based line number within its input
file.

**-o**  
Print only the matching lines.

**-t**  
Display the count of occurrences in the file

EXAMPLES
========

**Display only the count of lines which match the pattern (`-n` line
number ; `-o` only matching).**

    $ oc -no -E 's[aei]' /etc/passwd
    22:1:messagebus:x:103:107::/nonexistent:/usr/sbin/nologin
    29:2:cups-pk-helper:x:110:115:user for cups-pk-helper service,,,:/home/cups-pk-helper:/usr/sbin/nologin
    30:2:saned:x:111:117::/var/lib/saned:/usr/sbin/nologin
    31:1:speech-dispatcher:x:112:29:Speech Dispatcher,,,:/var/run/speech-dispatcher:/bin/false
    33:3:pulse:x:114:119:PulseAudio daemon,,,:/var/run/pulse:/usr/sbin/nologin
    35:1:gdm:x:116:122:Gnome Display Manager:/var/lib/gdm3:/bin/false
    39:1:omi:x:999:998::/home/omi:/bin/false

**Display only the count of lines which match one of the given string
(`-P` print file ; `-i` ignore case ; `-o` only matching ; `-t` display
total count of file).**

    $ oc -Piot -F $'mes\ngno' /etc/passwd
    /etc/passwd:3:games:x:5:60:games:/usr/games:/usr/sbin/nologin
    /etc/passwd:1:messagebus:x:103:107::/nonexistent:/usr/sbin/nologin
    /etc/passwd:1:gdm:x:116:122:Gnome Display Manager:/var/lib/gdm3:/bin/false
    /etc/passwd:#5

**Display lines having a count `==1` **or** `>=3`.**

    $ oc -Pit -F $'mes\ngno' -c '1,3-' /etc/passwd
    /etc/passwd:3:games:x:5:60:games:/usr/games:/usr/sbin/nologin
    /etc/passwd:1:messagebus:x:103:107::/nonexistent:/usr/sbin/nologin
    /etc/passwd:1:gdm:x:116:122:Gnome Display Manager:/var/lib/gdm3:/bin/false
    /etc/passwd:#5
