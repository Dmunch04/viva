module viva.io.console;

import std.stdio;
import std.conv;

@property private File getStdout() @trusted { return stdout; }

/++
 + Prints the given values
 + Params:
 +      values = The values to print to console
 +/
void print(T...)(T values) @safe
if (!is(T[0] : File))
{
    //import core.stdc : printf;
    //foreach (value; values)
        //printf(value);
    // Is this a bad way? I wanted to use `printf`, but it writes some weird output sometimes
    getStdout().write(values);
}

/++
 + Prints the given values and a newline (`\n`) after printing the values
 + Params:
 +      values = The values to print to console
 +/
void println(T...)(T values) @safe
{
    foreach (i, value; values)
    {
        if (i < values.length - 1)
            print(value.to!string, ' ');
        else
            print(value.to!string);
    }

    print('\n');
}

/++
 + Prints the given values and a newline (`\n`) after each value
 + Params:
 +      values = The values to print to console
 +/
void printfln(T...)(T values) @safe
{
    foreach (value; values)
        print(value.to!string, '\n');
}