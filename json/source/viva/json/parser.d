module viva.json.parser;

import std.range;
import std.traits;
import std.format;
import std.algorithm;
import std.exception;

/++
 +
 +/
public struct JSONParser
{
    ///
    public enum JSONType
    {
        null_,
        string_,
        boolean,
        number,
        array,
        object
    }

    ///
    public ForwardRange!dchar input;
    ///
    size_t lineNumber = 1;

    @disable this();

    /++
     +
     +/
    public this(T)(T input)
    if (isForwardRange!T)
    {
        this.input = input.inputRangeObject;
    }

    /++
     +
     +/
    public JSONType peekType()
    {
        skipWhitespace();

        if (input.empty) throw new Exception("Unexpected end of file.");

        with (JSONType)
        switch (input.front)
        {
            case 'n': return null_;

            case 't':
            case 'f': return boolean;

            case '-':
            case '0':
                ..
            case '9': return number;

            case '"': return string_;

            case '[': return array;
            case '{': return object;

            case ']':
            case '}':
                throw new Exception(
                    failMsg(input.front.format!"unexpected '%s' (maybe there's a comma before it?)")
                );

            default:
                throw new Exception(
                    failMsg(input.front.format!"unexpected character '%s'")
                );

        }
    }

    private string getLineBreaks() {

        import viva.io : println;

        string match = "";
        dchar lineSep;

        loop: while (!input.empty)
        switch (input.front)
        {
            case '\n', '\r':
                match ~= input.front;

                if (lineSep == input.front || lineSep == dchar.init) lineNumber++;

                lineSep = input.front;
                input.popFront();

                continue;

            default: break loop;

        }

        return match;

    }

    private void skipWhitespace()
    {
        while (!input.empty)
        switch (input.front)
        {
            case '\n', '\r':
                getLineBreaks();
                continue;

            case ' ', '\t':
                input.popFront();
                continue;

            default:
                return;
        }
    }

    private string failMsg(string s)
    {
        return s.format!"%s ib kube %s"(lineNumber);
    }

    pragma(inline, true);
    private string failFoundMsg(string s)
    {
        skipWhitespace();
        return failMsg(s.format!"%s, found %s"(peekType));
    }
}