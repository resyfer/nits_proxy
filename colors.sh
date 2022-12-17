if test -t 1; then

    # see if it supports colors...
    export ncolors=$(tput colors)

    if test -n "$ncolors" && test $ncolors -ge 8; then
        export bold="$(tput bold)"
        export underline="$(tput smul)"
        export standout="$(tput smso)"
        export normal="$(tput sgr0)"
        export black="$(tput setaf 0)"
        export red="$(tput setaf 1)"
        export green="$(tput setaf 2)"
        export yellow="$(tput setaf 3)"
        export blue="$(tput setaf 4)"
        export magenta="$(tput setaf 5)"
        export cyan="$(tput setaf 6)"
        export white="$(tput setaf 7)"
    fi
fi

