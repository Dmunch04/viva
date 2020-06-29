module viva.collections.table;

import viva.exceptions.check : checkEquals;
import viva.types.string;

import std.typecons;
import std.traits;

/++
 + Enum of all entry value types
 +/
enum EntryValueType : byte
{
    null_,
    string_,
    integer_,
    uinteger_,
    float_,
    true_,
    false_
}

/++
 + Object for holding the entry value
 +/
struct EntryValue
{
    /++
     + Takes in the value
     + Params:
     +      value = The value of the object
     +/
    this(T)(T value)
    {
        assign(value);
    }

    /++
     + Union for storing each type of value
     +/
    union Store
    {
        /++
         + String value
         +/
        string str;

        /++
         + Integer/long value
         +/
        long integer;
        
        /++
         + Uinteger/ulong value
         +/
        ulong uinteger;
        
        /++
         + Floating/double value
         +/
        double floating;
    }

    private {
        Store store;
        EntryValueType valueType;
    }

    /++
     + Get the values `EntryValueType` type
     + Returns: The type of value from the `EntryValueType` enum
     +/
    @property EntryValueType type() const pure nothrow @safe @nogc
    {
        return valueType;
    }

    /++
     + Get the string value, if the value is a string
     + Returns: The value as a string
     +/
    @property string str() const pure @trusted
    {
        checkEquals(valueType, EntryValueType.string_, "EntryValue is not a string!");
        return store.str;
    }

    /++
     + Get the int/long value, if the value is a int/long
     + Returns: The value as a long
     +/
    @property long integer() const pure @safe
    {
        checkEquals(valueType, EntryValueType.integer_, "EntryValue is not an integer!");
        return store.integer;
    }

    /++
     + Get the uint/ulong value, if the value is a uing/ulong
     + Returns: The value as a ulong
     +/
    @property ulong uinteger() const pure @safe
    {
        checkEquals(valueType, EntryValueType.uinteger_, "EntryValue is not an unsigned integer!");
        return store.uinteger;
    }

    /++
     + Get the float/double value, if the value is a float/double
     + Returns: The value as a double
     +/
    @property double floating() @safe const pure
    {
        checkEquals(valueType, EntryValueType.float_, "EntryValue is not a float!");
        return store.floating;
    }

    /++
     + Get the bool value, if the value is a bool
     + Returns: The value as a boolean
     +/
    @property bool boolean() @safe const pure
    {
        if (valueType == EntryValueType.true_) return true;
        if (valueType == EntryValueType.false_) return false;

        // TODO: Throw exception
        return false;
    }

    /++
     + Returns: Whether or not the entries value is null
     +/
    @property bool isNull() @safe @nogc const pure nothrow
    {
        return valueType == EntryValueType.null_;
    }

    /++
     + Gets the value of the object, depending on the type given (`T`)
     +/
    @property inout(T) get(T)() @safe inout const pure
    {
        static if (is(Unqual!T == string))
        {
            return str;
        }
        else static if (is(Unqual!T == bool))
        {
            return boolean;
        }
        else static if (isFloatingPoint!T)
        {
            switch(valueType)
            {
                case EntryValueType.float_: return cast(T) floating;
                case EntryValueType.integer_: return cast(T) integer;
                case EntryValueType.uinteger_: return cast(T) uinteger;
                default:
                {
                    return null;
                    // TODO: Throw exception
                }
            }
        }
        else static if (__traits(isUnsigned, T))
        {
            return cast(T) uinteger;
        }
        else static if (isSigned!T)
        {
            return cast(T) integer;
        }
        else
        {
            static assert(false, "Unsupported type!");
        }
    }

    private void assign(T)(T value)
    {
        static if (is(T : typeof(null)))
        {
            valueType = EntryValueType.null_;
        }
        else static if (is(T : string))
        {
            valueType = EntryValueType.string_;
            string t = value;
            () @trusted { store.str = t; }();
        }
        else static if (is(T : bool))
        {
            valueType = value ? EntryValueType.true_ : EntryValueType.false_;
        }
        else static if (is(T : ulong) && isUnsigned!T)
        {
            valueType = EntryValueType.uinteger_;
            store.uinteger = value;
        }
        else static if (is(T : long))
        {
            valueType = EntryValueType.integer_;
            store.integer = value;
        }
        else static if (isFloatingPoint!T)
        {
            valueType = EntryValueType.float_;
            store.floating = value;
        }
        else static if (is(T : EntryValue))
        {
            valueType = value.type;
            store = value.store;
        }
        else
        {
            static assert(false, "Error message here...");
        }
    }

    string toString() const @safe
    {
        import std.conv : to;

        final switch (valueType)
        {
            case EntryValueType.null_: return "null";
            case EntryValueType.string_: return str;
            case EntryValueType.integer_: return integer.to!string;
            case EntryValueType.uinteger_: return uinteger.to!string;
            case EntryValueType.float_: return floating.to!string;
            case EntryValueType.true_: return "true";
            case EntryValueType.false_: return "false";
        }
    }
}

/++
 + The Entry object holds the needed information about all table entries
 +/
struct Entry
{
    /++
     + The key/name of the entry
     +/
    string key;
    
    /++
     + The value of the entry, which may be null
     +/
    Nullable!EntryValue value;
}

/++
 + A hash table associates a set of keys with a set of values.
 + Each key/value pair is an entry in the table. Given a key, you can look up its corresponding value.
 + You can add new key/value pairs and remove entries by key.
 + If you add a new value for an existing key, it replaces the previous entry.
 +
 + The table will automatically resize when it's close to being full, which means
 + you can never fill up the table.
 +/
struct HashTable
{
    /++
     + The size of the table. This keeps tracks of how many non-empty entries the table has
     +/
    int count;
    
    /++
     + The max amount of entries in the table
     +/
    int capacity;
    
    /++
     + An array of all the entries
     +/
    Entry[] entries;

    /++
     + Takes in the default capacity
     + Params:
     +      capacity = The default capacity for the table
     +/
    this(int capacity)
    {
        this.count = 0;
        this.capacity = capacity;
        this.entries = new Entry[capacity];
    }

    /++
     + Looks up an entry in the array, and returns it if it's key is empty or matching
     + Params:
     +      key = The key to look for in the entries
     + Returns: A pointer to the found entry
     +/
    Entry* findEntry(string key)
    {
        uint index = key.hash % capacity;

        for (;;)
        {
            Entry* entry = &entries[index];
            
            if (entry.key == key || entry.key == "")
            {
                return entry;
            }

            index = (index + 1) % capacity;
        }
    }

    private void adjustCapacity(int newCapacity)
    {
        Entry[] entriesHolder = entries;
        entries = new Entry[newCapacity];
        for (int i = 0; i < entriesHolder.length; i++)
        {
            const(Entry)* entry = &entriesHolder[i];
            if (entry.key == "") continue;
            
            entries[i].key = entriesHolder[i].key;
            entries[i].value = entriesHolder[i].value;
        }

        capacity = newCapacity;
    }

    /++
     + Adds a new entry, with the given name and value, to the table
     + Params:
     +      key = The name of the entry
     +      value = The raw value of the entry
     + Returns: A bool indicating whether or not the entry is new or already exists
     +/
    bool set(T)(string key, T value)
    {
        return set(key, EntryValue(value));
    }

    /++
     + Adds a new entry, with the given name and value, to the table
     + Params:
     +      key = The name of the entry
     +      value = The entry value of the entry
     + Returns: A bool indicating whether or not the entry is new or already exists
     +/
    bool set(string key, EntryValue value)
    {
        if (count > capacity * 0.75)
        {
            adjustCapacity(growCapacity(capacity));
        }

        Entry* entry = findEntry(key);

        const(bool) isNewKey = entry.key == "";
        if (isNewKey) count++;

        entry.key = key;
        entry.value = value.nullable;
        return isNewKey;
    }

    /++
     + Merges the entries of another table into the current tables entries
     + Params:
     +      table = The other table
     +/
    void merge(HashTable table)
    {
        for (int i = 0; i < table.capacity; i++)
        {
            Entry entry = table.entries[i];
            if (entry.key != "")
            {
                set(entry.key, entry.value.get);
            }
        }
    }

    /++
     + Gets an entry from the table
     + Params:
     +      key = The name of the entry
     + Returns: A nullable `EntryValue` object
     +/
    Nullable!EntryValue get(string key)
    {
        if (count == 0) return Nullable!EntryValue.init; // how?
        return findEntry(key).value.nullable.get; // how?
    }
}

private uint growCapacity(uint capacity)
{
    return capacity < 8 ? 8 : capacity * 2;
}
