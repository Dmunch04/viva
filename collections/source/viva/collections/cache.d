module viva.collections.cache;

import std.typecons : Nullable;

import viva.collections.table;

/++
 +
 +/
struct Cache(T)
{
    private HashTable cache = HashTable(5);

    /++
     +
     +/
    //public T get(string key)
    public Nullable!EntryValue get(string key)
    {
        // TODO: Find a way to make it spit out the direct value of type `T`

        //return cache.get(key);
        
        //Nullable!EntryValue result = cache.get(key);
        //if (result.isNull) throw new Exception("");
        //return cast(int) result.get.integer;
        
        return cache.get(key);
    }

    /++
     +
     +/
    //public T[] getAll()
    public EntryValue[] getAll()
    {
        EntryValue[] values = new EntryValue[cache.count];

        int i;
        foreach (entry; cache.entries)
        {
            if (!entry.value.isNull)
            {
                values[i] = entry.value.get;
                i++;
            }
        }

        return values;
    }

    /++
     +
     +/
    public void add(string key, T value)
    {
        cache.set(key, value);
    }

    /++
     +
     +/
    public void update(string key, T value)
    {
        cache.set(key, value);
    }

    /++
     +
     +/
    public void remove(string key)
    {
        cache.remove(key);
    }
}