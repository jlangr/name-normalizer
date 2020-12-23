# Name Normalizer: C++ version (gcc)

This project includes a distribution of googletest.

# Building

If you already have the latest version of GoogleTest installed, you can update the CMakeLists.txt file in ./libraryTest to properly reference it (or an env variable). Or you can choose to build the included distribution of GoogleTest. One way to build it:

    cd googletest
    cmake .
    make

You can specify a path for 3rd party dependencies using the `EXT_PREFIX` variable. By
default this is set to `/usr/local`. For example

    # use 3rd party libraries installed in /opt/local
    EXT_PREFIX=/opt/local make

Run the bash script that builds and executes the tests:

    ./test
