module viva.types.string;

/++
 + Creates a string of multiple other strings
 + Params:
 +      values = The values that should be combined into a string
 + Returns: The new string
 +/
public string str(T...)(T values) pure nothrow @safe
{
    string result = "";
    if (values.length > 1)
        foreach (value; values)
            result ~= value;

    return result;
}

/++
 + Appends additional data to a string
 + Params:
 +      s = The string to append the value to
 +      a = The value to be appended
 + Returns: `s` with `a` appended
 +/
public string append(T)(ref string s, T a) pure nothrow @safe
{
    import std.conv : to;

    string b = a.to!string;
    s = s ~ b;

    return s;
}

/++
 + Get the FNV-1a hash of the string
 + Example:
 +      ```d
 +       println(str.hash);
 +      ```
 + Params:
 +      s = The string that should be hashed
 +/
@property public uint hash(ref string s) pure nothrow @safe
{
    uint hash = 2_166_136_261;

    foreach (c; s)
    {
        hash ^= c;
        hash *= 16_777_619;
    }

    return hash;
}

/++
 + Get the FNV-1a hash of the string
 + Example:
 +      ```d
 +       println("Hello, World!".hash);
 +      ```
 + Params:
 +      s = The string that should be hashed
 +/
@property public uint hash(string s) pure nothrow @safe
{
    return hash(s);
}

/++
 + Repeats a string `n` times
 + Params:
 +      s = The string that should be repeated
 +      n = The amount of times it should be repeated
 + Returns: The string repeated `n` times
 +/
@property public string repeat(ref string s, long n) pure nothrow @safe
{
    string a = "";

    for (int i = 0; i < n; i++)
    {
        a ~= s;
    }

    return a;
}

/++
 + Repeats a string `n` times
 + Params:
 +      s = The string that should be repeated
 +      n = The amount of times it should be repeated
 + Returns: The string repeated `n` times
 +/
@property public string repeat(string s, long n) pure nothrow @safe
{
    return repeat(s, n);
}

/++
 + Converts all characters in a givens string to uppercase
 + Params:
 +      s = The string to be processed
 + Returns: The new string
 +/
@property public string toUpper(ref string s) pure @safe
{
    import viva.types.number : inRange;
    import std.format : format;

    char[] a = new char[s.length];

    int idx;
    foreach (c; s)
    {
        int i = cast(int) c;

        if (i.inRange(97, 122))
        {
            i -= 32;
        }

        a[idx] = cast(char) i;
        idx++;
    }

    return format!"%s"(a);
}

/++
 + Converts all characters in a givens string to uppercase
 + Params:
 +      s = The string to be processed
 + Returns: The new string
 +/
@property public string toUpper(string s) pure @safe
{
    return toUpper(s);
}

/++
 + Converts all characters in a givens string to lowercase
 + Params:
 +      s = The string to be processed
 + Returns: The new string
 +/
@property public string toLower(ref string s) @safe
{
    import viva.types.number : inRange;
    import std.format : format;

    char[] a = new char[s.length];

    int idx;
    foreach (c; s)
    {
        int i = cast(int) c;

        if (i.inRange(65, 90))
        {
            i += 32;
        }

        a[idx] = cast(char) i;
        idx++;
    }

    return format!"%s"(a);
}

/++
 + Converts all characters in a givens string to lowercase
 + Params:
 +      s = The string to be processed
 + Returns: The new string
 +/
@property public string toLower(string s) @safe
{
    return toLower(s);
}

/++
 + Splits a string into an array by a given seperator
 + Params:
 +      s = The string to be splitted
 +      sep = The seperator specifying where to split
 + Returns: An array of the elements from the splitted string
 +/
@property public string[] split(ref string s, string sep) @safe
{
    string[] values;

    foreach (c; s)
    {
        // TODO: What if the sep is more than just a char
    }

    return values;
}

/++
 + Splits a string into an array by a given seperator
 + Params:
 +      s = The string to be splitted
 +      sep = The seperator specifying where to split
 + Returns: An array of the elements from the splitted string
 +/
@property public string[] split(string s, string sep) @safe
{
    return split(s, sep);
}