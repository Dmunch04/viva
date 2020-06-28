module viva.json.value;

import std.array;
import std.conv;
import std.range.primitives;
import std.traits;

/++
 +
 +/
enum JSONType : int
{
    NULL,
    STRING,
    INTEGER,
    UINTEGER,
    FLOAT,
    OBJECT,
    ARRAY,
    TRUE,
    FALSE,
}

// https://github.com/dlang/phobos/blob/master/std/json.d
struct JSONValue
{
    import std.exception : enforce;

    /++
     +
     +/
    union Store
    {
        /++
         +
         +/
        string str;

        /++
         +
         +/
        long integer;

        /++
         +
         +/
        ulong uinteger;

        /++
         +
         +/
        double floating;

        /++
         +
         +/
        JSONValue[string] object;

        /++
         +
         +/
        JSONValue[] array;
    }

    private {
        Store _store;
        JSONType _type;
    }

    public {
        /++
         +
         +/
        @property JSONType type() const nothrow @safe @nogc { return _type; }

        /++
         +
         +/
        @property string str() const @trusted
        {
            enforce!JSONException(_type == JSONType.STRING, "Value is not a string!");
            return _store.str;
        }

        /++
         +
         +/
        @property long integer() const @safe
        {
            enforce!JSONException(_type == JSONType.INTEGER, "Value is not an integer!");
            return _store.integer;
        }

        /++
         +
         +/
        @property ulong uinteger() const @safe
        {
            enforce!JSONException(_type == JSONType.UINTEGER, "Value is not an uinteger!");
            return _store.uinteger;
        }

        /++
         +
         +/
        @property double floating() const @safe
        {
            enforce!JSONException(_type == JSONType.FLOAT, "Value is not a float!");
            return _store.floating;
        }

        /++
         +
         +/
        @property bool boolean() const @safe
        {
            if (_type == JSONType.TRUE) return true;
            else if (_type == JSONType.FALSE) return false;

            throw new JSONException("Value is not a boolean!");
        }

        /++
         +
         +/
        @property ref JSONValue[string] object() @system
        {
            enforce!JSONException(_type == JSONType.OBJECT, "Value is not an object!");
            return _store.object;
        }

        /++
         +
         +/
        @property JSONValue[string] objectNoRef() @trusted
        {
            enforce!JSONException(_type == JSONType.OBJECT, "Value is not an object!");
            return _store.object;
        }

        /++
         +
         +/
        @property ref JSONValue[] array() @system
        {
            enforce!JSONException(_type == JSONType.ARRAY, "Value is not an array!");
            return _store.array;
        }

        /++
         +
         +/
        @property JSONValue[] arrayNoRef() @trusted
        {
            enforce!JSONException(_type == JSONType.ARRAY, "Value is not an array!");
            return _store.array;
        }

        /++
         +
         +/
        @property bool isNull() const nothrow @safe @nogc
        {
            return _type == JSONType.NULL;
        }

        /++
         +
         +/
        @property T get(T)() const @safe
        {
            static if (is(Unqual!T == string)) return str();
            else static if (is(Unqual!T == bool)) return boolean();
            else static if (isFloatingPoint!T)
            {
                switch (_type)
                {
                    case JSONType.FLOAT: return cast(T) floating();
                    case JSONType.UINTEGER: return cast(T) uinteger();
                    case JSONType.INTEGER: return cast(T) integer();
                }
            }
            else static if (__traits(isUnsigned, T)) return cast(T) uinteger();
            else static if (isSigned!T) return cast(T) integer();
            else static assert(false, text("Unsupported type '", T.stringof, "'!"));
        }

        /++
         +
         +/
        @property T get(T : JSONValue[])() @trusted
        {
            return arrayNoRef();
        }

        /++
         +
         +/
        @property T get(T : JSONValue[string])() @trusted
        {
            return object();
        }
    }

    /++
     +
     +/
    this(T)(T value) if (!isStaticArray!T)
    {
        assign(value);
    }

    /++
     +
     +/
    this(T)(ref T value) if (isStaticArray!T)
    {
        assignRef(value);
    }

    /++
     +
     +/
    this(T : JSONValue)(T value)
    {
        _type = value.type();
        _store = value.store();
    }

    private void assign(T)(T value)
    {
        static if (is(T : typeof(null))) _type = JSONType.NULL;
        else static if (is(T : string))
        {
            _type = JSONType.STRING;
            _store.str = value.to!string;
        }
        else static if (is(T : bool)) _type = value ? JSONType.TRUE : JSONType.FALSE;
        else static if (is(T : ulong) && isUnsigned!T)
        {
            _type = JSONType.UINTEGER;
            _store.uinteger = value;
        }
        else static if (is(T : long))
        {
            _type = JSONType.INTEGER;
            _store.integer = value;
        }
        else static if (isFloatingPoint!T)
        {
            _type = JSONType.FLOAT;
            _store.floating = value;
        }
        else static if (is(T : Value[Key], Key, Value))
        {
            static assert(is(Key : string), "Key most be a string!");
            _type = JSONType.OBJECT;
            static if (is(Value : JSONValue))
            {
                JSONValue[string] val = value;
                _store.object = val;
            }
            else
            {
                JSONValue[string] obj;
                foreach (key, val; value)
                    obj[key] = JSONValue(val);
                _store.object = obj;
            }
        }
        else static if (isArray!T)
        {
            _type = JSONType.ARRAY;
            static if (is(ElementEncodingType!T : JSONValue))
            {
                JSONValue[] val = value;
                _store.array = val;
            }
            else
            {
                JSONValue[] val = new JSONValue[value.length];
                foreach (i, elem; value)
                    val[i] = JSONValue(elem);
                _store.array = val;
            }
        }
        else static if (is(T : JSONValue))
        {
            _type = value.type();
            _store = value.store();
        }
        else
        {
            static assert(false, text("Unable to convert type '", T.stringof, "' to json!"));
        }
    }

    private void assignRef(T)(ref T value) if (isStaticArray!T)
    {
        _type = JSONType.ARRAY;
        static if (is(ElementEncodingType!T : JSONValue)) _store.array = value;
        else
        {
            JSONValue[] val = new JSONValue[value.length];
            foreach (i, elem; value)
                val[i] = JSONValue(elem);
            _store.array = val;
        }
    }

    /++
     +
     +/
    void opAssign(T)(T value) if (!isStaticArray!T && !is(T : JSONValue))
    {
        assign(value);
    }

    /++
     +
     +/
    void opAssign(T)(ref T value) if (isStaticArray!T)
    {
        assignRef(value);
    }

    /++
     +
     +/
    ref JSONValue opIndex(size_t index) @safe
    {
        auto value = arrayNoRef();
        enforce!JSONException(index < value.length, "Value array index is out of range!");

        return value[index];
    }

    /++
     +
     +/
    ref JSONValue opIndex(string key) @safe
    {
        auto value = objectNoRef();
        return *enforce!JSONException(key in value, text("Key not found: ", key));
    }
}

/++
 +
 +/
class JSONException : Exception
{
    /++
     +
     +/
    this(string message, int line = 0, int position = 0) nothrow @safe
    {
        if (line && position) super(text(message, "{Line: ", line, ", ", "Position: ", position, "}"));
        else if (line) super(text(message, "{Line: ", line, "}"));
        else if (position) super(text(message, "{Position: ", position, "}"));
        else super(message);
    }

    /++
     +
     +/
    this(string message, string file, size_t line) nothrow @safe
    {
        super(message, file, line);
    }
}