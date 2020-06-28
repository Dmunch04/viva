module viva.types.number;

/++
 + Checks whether or not the given type is a number type
 + Returns: `true` if the type is a number, else `false`
 +/
template isNumber(T)
{
    static if (is(T : short)) enum bool isNumber = true;
    else static if (is(T : ushort)) enum bool isNumber = true;
    else static if (is(T : int)) enum bool isNumber = true;
    else static if (is(T : uint)) enum bool isNumber = true;
    else static if (is(T : long)) enum bool isNumber = true;
    else static if (is(T : ulong)) enum bool isNumber = true;
    else static if (is(T : float)) enum bool isNumber = true;
    else static if (is(T : double)) enum bool isNumber = true;
    else enum bool isNumber = false;
}

/++
 + Checks whether or not the given value is a number
 + Returns: `true` if the value is a number, else `false`
 +/
public bool isValueNumber(T)(T value) pure nothrow @safe
{
    static if (is(T : short)) return true;
    else static if (is(T : ushort)) return true;
    else static if (is(T : int)) return true;
    else static if (is(T : uint)) return true;
    else static if (is(T : long)) return true;
    else static if (is(T : ulong)) return true;
    else static if (is(T : float)) return true;
    else static if (is(T : double)) return true;
    else return false;
}

/++
 + Clamps a reference to a value to minimum and maximum value
 + Params:
 +      value = The value to clamp
 +      min = The minimum value
 +      max = The maximum value
 +/
public void clampRef(T)(ref T value, T min, T max) pure nothrow @safe
if (isNumber!T)
{
    if (value < min) value = min;
    if (value > max) value = max;
}

/++
 + Clamps a value to minimum and maximum value
 + Params:
 +      value = The value to clamp
 +      min = The minimum value
 +      max = The maximum value
 + Returns: The clamped value
 +/
public T clamp(T)(T value, T min, T max) pure nothrow @safe
if (isNumber!T)
{
    if (value < min) value = min;
    if (value > max) value = max;
    return value;
}