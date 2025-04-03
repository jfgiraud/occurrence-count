
[//]: # (This file is generated, modify doc/readme.adoc and regenerate it with 'make update-doc')

![<https://github.com/jfgiraud/occurrence-count/actions>](https://img.shields.io/github/actions/workflow/status/jfgiraud/occurrence-count/main.yml?label=CI)

Description
===========

**oc** is a small utility to count occurences of a string or pattern in
each line of files.

Installation
============

The destination directory will contain 3 sub-directories: `bin`, `share`
and `man`.

**Using git repo.**

    $ git clone https://github.com/jfgiraud/occurrence-count.git
    $ cd occurrence-count
    $ sudo apt update -y && sudo apt install -y make asciidoctor pandoc
    $ sudo make install DESTDIR=/usr/local

**Using latest tarball release.**

    $ curl -s -L https://api.github.com/repos/jfgiraud/occurrence-count/releases/latest | grep browser_download_url | cut -d':' -f2- | tr -d ' ",' | xargs wget -O occurrence-count.tgz
    $ sudo tar zxvf occurrence-count.tgz -C /usr/local

Usage
=====

**Use man.**

    $ man oc

**Use option.**

    $ oc -h

Examples
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
