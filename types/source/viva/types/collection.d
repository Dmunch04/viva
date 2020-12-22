module viva.types.collection;

import viva.collections;
import viva.types.string;

/++
 +
 +/
void forEach(T)(ref T[] arr, void delegate(ref T t) callback)
{
    foreach (ref e; arr)
    {
        callback(e);
    }
}

/++
 +
 +/
void forEach(T)(ref T[] arr, void delegate(T t) callback)
{
    foreach (e; arr)
    {
        callback(e);
    }
}

/++
 +
 +/
void forEach(ref HashTable table, void delegate(ref EntryValue value) callback)
{
    foreach (ref entryValue; table.getAll())
    {
        callback(entryValue);
    }
}

/++
 +
 +/
void forEach(ref HashTable table, void delegate(EntryValue value) callback)
{
    foreach (entryValue; table.getAll())
    {
        callback(entryValue);
    }
}

/++
 +
 +/
void forEach(T)(ref Cache!T cache, void delegate(ref EntryValue value) callback)
{
    foreach (ref entryValue; cache.getAll())
    {
        callback(entryValue);
    }
}

/++
 +
 +/
void forEach(T)(ref Cache!T cache, void delegate(EntryValue value) callback)
{
    foreach (entryValue; cache.getAll())
    {
        callback(entryValue);
    }
}

/++
 +
 +/
string join(T)(ref T[] arr, string joiner)
{
    import std.conv : to;

    string res = "";

    foreach (elem; arr)
    {
        res.append(elem.to!string);
        res.append(joiner);
    }
    
    res = res[0..$ - joiner.length];

    return res;
}