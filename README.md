AWS Lambda cold start (pseudo-)benchmark
==============================================================================

**tl;dr** Python starts fastest (numbers below are for 100 invocations):

    ==> java.run <==

    real	0m8.461s
    user	0m6.365s
    sys	    0m1.783s

    ==> nodejs.run <==

    real	0m4.205s
    user	0m3.043s
    sys	    0m1.184s

    ==> python.run <==

    real	0m1.601s
    user	0m1.051s
    sys	    0m0.531s

# Methodology

Dummy (w/o "Hello world") programs were exected on Ubuntu 14.04.3 LTS inside
Virtualbox using the following commands. For Python 2.7.6:

    cd python
    time (for i in $(seq 100); do python main.py; done) > ../python.run 2>&1

For Oracle Java 1.8.0_72:

    cd java
    javac main.java
    time (for i in $(seq 100); do java Main; done) > ../java.run 2>&1

For Node.js 0.10.25:

    cd nodejs/
    time (for i in $(seq 100); do nodejs main; done) > ../nodejs.run 2>&1

For memory, the measurement was done even more naively ([/usr/bin/time
trick](http://stackoverflow.com/questions/774556/peak-memory-usage-of-a-linux-unix-process)):

    /usr/bin/time -v python main.py
            ...
            Maximum resident set size (kbytes): 4940
            ...

    /usr/bin/time -v java Main
            ...
            Maximum resident set size (kbytes): 18388
            ...

    /usr/bin/time -v nodejs main
            ...
            Maximum resident set size (kbytes): 8776
            ...

Results were concatenated using the following command
([credit](http://stackoverflow.com/questions/5917413/cat-multiple-files-but-include-filename-as-headers)):

    tail -n +1 *.run

Better (more representative) and/or more extensive (include native process
invocation time and test C/C++/Go) measurements are more than welcome via pull
requests!

