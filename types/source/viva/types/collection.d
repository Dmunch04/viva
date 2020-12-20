module viva.types.collection;

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