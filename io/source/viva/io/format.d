module viva.io.format;

/++
 + Formats a given string
 + Params:
 +      str = The string to be formatted
 + Returns: The formatted string
 +/
string formatStr(string str) pure nothrow @safe
{
    return str;
}

/++
 + Appends text to both sides of a given string
 + Params:
 +      side = The text to be appended on both sides
 +      str = The string it should be appended to
 + Returns: The new string
 +/
string envelop(string side, string str) pure nothrow @safe
{
    return side ~ str ~ side;
}

/++
 + Appends a prefix and suffix to a given string
 + Params:
 +      prefix = The text to be appended on the right of the string
 +      str = The string it should be appended to
 +      suffix = The text to be appended on the left of the string
 + Returns: The new string
 +/
string envelop(string prefix, string str, string suffix) pure nothrow @safe
{
    return prefix ~ str ~ suffix;
}

/++
 + Sanitizes a given string
 + Params:
 +      str = The string that should be sanitized
 +      target = The text that should be removed
 + Returns: The new, sanitized string
 +/
string sanitize(string str, string target) pure nothrow @safe
{
    import std.array : replace;

    return str.replace(target, "");
}

/++
 + Prettifies a given string using regex
 + Params:
 +      str = The string to be prettified
 +      regex = The regex that should be used to prettify (Default = `(?<!^)(?=[A-Z])`)
 + Returns: The new, prettified string
 +/
string prettify(string str, string regex = r"(?<!^)(?=[A-Z])") pure nothrow @safe
{
    import std.array : replace;

    return str.replace(regex, " ");
}

/++
 + Checks if a string is empty, and returns a null
 + Params:
 +      str = The target string
 + Returns: `null` if the string is empty, else it returns the string
 +/
string asNullIfEmpty(string str) pure nothrow @safe
{
    if (str == "") return null;
    else return str;
}

/++
 + Checks if a string is empty, and returns an alternative
 + Params:
 +      str = The target string
 +      alt = The alternate string
 + Returns: `alt` if the string is empty, else it returns the string
 +/
string withAlternative(string str, string alt) pure nothrow @safe
{
    if (asNullIfEmpty(str) == null) return alt;
    else return str;
}