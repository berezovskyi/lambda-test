#!/usr/bin/env bash

tm() {
    cd $1
    if [ -n "$3" ]
    then
        $3
    fi
    time (for i in $(seq 100); do $2; done) > ../output/$1.run 2>&1
    cd ..
}

tm python "python main.py"
tm nodejs "nodejs main"
tm java "java Main" "javac main.java"
tm c "./a.out" "gcc -O2 main.c"
tm go "./main" "go build main.go"

tail -n +1 output/*.run

