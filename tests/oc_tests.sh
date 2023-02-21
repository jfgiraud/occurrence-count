#!/bin/bash

cd $(dirname $(readlink -f $0))

total=0
ok=0
ko=0

function assert_equals() {
    total=$((total+1))
    expected="$1"
    actual="$2"
    message="$3"
    if [[ "$expected" == "$actual" ]]; then
        ok=$((ok+1))
        echo "OK: ${message}" >&2
    else
        ko=$((ko+1))
        echo "KO: ${message}" >&2
        echo "   expects: ${expected}" >&2
        echo "   but receives: ${actual}" >&2
    fi
}

function assert_exec_equals() {
    command="${1}"
    actual=$(eval "${command}")
    expected="${2}"
    assert_equals "${expected}" "${actual}" "${command}"

}

read -r -d '' EXPECTED <<'EOF'
LICENSE:1: Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
LICENSE:1:  The GNU General Public License is a free, copyleft license for
LICENSE:1:to take away your freedom to share and change the works.  By contrast,
LICENSE:1:the GNU General Public License is intended to guarantee your freedom to
LICENSE:1:share and change all versions of a program--to make sure it remains free
LICENSE:1:software for all its users.  We, the Free Software Foundation, use the
LICENSE:2:  When we speak of free software, we are referring to freedom, not
LICENSE:2:have the freedom to distribute copies of free software (and charge for
LICENSE:1:free programs, and that you know you can do these things.
LICENSE:1:you modify it: responsibilities to respect the freedom of others.
LICENSE:1:freedoms that you received.  You must make sure that they, too, receive
LICENSE:1:that there is no warranty for this free software.  For both users' and
LICENSE:1:protecting users' freedom to change the software.  The systematic
LICENSE:1:of the GPL, as needed to protect the freedom of users.
LICENSE:1:avoid the special danger that patents applied to a free program could
LICENSE:1:patents cannot be used to render the program non-free.
LICENSE:1:System Libraries, or general-purpose tools or generally available free
LICENSE:1:  Each contributor grants you a non-exclusive, worldwide, royalty-free
LICENSE:1:to copy, free of charge and under the terms of this License, through a
LICENSE:1:  12. No Surrender of Others' Freedom.
LICENSE:1:  The Free Software Foundation may publish revised and/or new versions of
LICENSE:1:version or of any later version published by the Free Software
LICENSE:1:by the Free Software Foundation.
LICENSE:1:free software which everyone can redistribute and change under these terms.
LICENSE:1:    This program is free software: you can redistribute it and/or modify
LICENSE:1:    the Free Software Foundation, either version 3 of the License, or
LICENSE:1:    This is free software, and you are welcome to redistribute it
LICENSE:#29
EOF

assert_exec_equals \
    "cd .. ; ./bin/oc -Piot -F 'free' LICENSE" \
     "${EXPECTED}"

echo "${ok}/${total} (${ko} errors)"

if [[ ${ok} -ne ${total} ]]; then
    exit 1
else
    exit 0
fi
