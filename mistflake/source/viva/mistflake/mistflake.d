module viva.mistflake.mistflake;

import viva.types.string;

import std.datetime;
import std.random;

/++
 + The `Mistflake` struct contains information about a mistflake id. The mistflake id consists of the following  parts:
 + 1111111111 1111 11111111111
 + 10         4    11
 + Fields:
 +      timestamp = The `timestamp` field is a UNIX timestamp, and consists of 10 bits
 +      workerId = The `workerId` is the ID of the generator that generated the mistflake. This can be user defined or randomly generated. Consists of 4 bits
 +      id = The `id` field is the unique ID. For every ID that is generated in the generator, the number is incremented. Consists of 11 bits
 +
 + Example: An example Mistflake ID may look like `1593375000795500000000001`
 +/
struct Mistflake
{
    /++
     + The UNIX timestamp
     +/
    SysTime time;

    /++
     + The workers ID
     +/
    ulong worker;
    
    /++
     + The unique ID
     +/
    ulong id;

    /++
     + Generates a string representation out of the object
     + Returns: A Mistflake string representation
     +/
    @property string asString() const @safe
    {
        import std.conv : to;

        // TODO: Make sure worker ID isn't more than 4 digits long
        string workerStr = worker.to!string;
        const(ulong) workerZerosToAdd = 4 - workerStr.length;
        workerStr = str("0".repeat(workerZerosToAdd), workerStr);

        string idStr = id.to!string;
        const(ulong) idZerosToAdd = 11 - idStr.length;
        idStr = str("0".repeat(idZerosToAdd), idStr);

        return str(time.toUnixTime().to!string, workerStr, idStr);
    }

    string toString() const @safe
    {
        return asString;
    }

    static Mistflake fromString(string s) @safe
    {
        return MistflakeParser().parse(s);
    }
}

/++
 + The `MistflakeGenerator` can generate Mistflakes
 +/
struct MistflakeGenerator
{
    private {
        Random random;

        ulong start;
        ulong worker;
    }

    /++
     + Takes in a starting ID and a worker ID
     + Params:
     +      start = The starting ID (If value is `0` it will be set to `1`)
     +      worker = The worker ID (If value is `0` it will be set to a random value)
     +/
    this(ulong start, ulong worker)
    {
        this.random = Random(unpredictableSeed);

        this.start = start == 0 ? 1 : start;
        this.worker = worker == 0 ? uniform(1000, 9999, random) : worker;
    }

    /++
     + Takes in a starting Mistflake and a worker ID
     + Params:
     +      start = The starting Mistflake. The start will be the given Mistflakes ID
     +      worker = The worker ID (If value is `0` it will be set to a random value)
     +/
    this(Mistflake start, ulong worker)
    {
        this(start.id, worker);
    }
 
    /++
     + Takes in a starting Mistflake
     + Params:
     +      start = The starting Mistflake. The start and worker will be the given Mistflakes ID
     +/
    this(Mistflake start)
    {
        this(start.id, start.worker);
    }

    /++
     + Generate the next Mistflake
     +/
    public Mistflake next() @safe
    {
        return Mistflake(Clock.currTime(), worker, start++);
    }
}

/++
 + The `MistflakeParser` containes functions for parsing Mistflake string representations
 +/
struct MistflakeParser
{
    /++
     + Parse a mistflake
     + Params:
     +      mistflake = The Mistflake string representation to be parsed
     + Returns: The generated Mistflake
     +/
    public Mistflake parse(string mistflake) @safe
    {
        import std.conv : to;

        const(string) unix = mistflake[0..10];
        const(string) worker = mistflake[10..14];
        const(string) id = mistflake[14..$];
        return Mistflake(SysTime.fromUnixTime(unix.to!ulong), worker.to!ulong, id.to!ulong);
    }
}
