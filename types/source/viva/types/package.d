module viva.types;

public import viva.types.number;
public import viva.types.string;
public import viva.types.collection;

import std.typecons;

/++
 +
 +/
public R matches(T, R)(ref T value, T toMatch, R ifValue, Nullable!R elseValue)
{
    if (value == toMatch)
    {
        return ifValue;
    }
    else
    {
        if (elseValue.isNull)
            // maybe just return null?
            throw new Exception("values doesn't match and no else value is provided");
        
        return elseValue.get;
    }
}