module viva.json.decoder;

import std.stdio;
import std.conv;
import std.file;

string[string] load(string path)
{
    auto data = cast(byte[]) read(path);
    return loads(data.to!string);
}

string[string] loads(string data)
{
    return null;
}