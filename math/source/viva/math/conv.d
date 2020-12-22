module viva.math.conv;

// Based on https://github.com/CosmoMyst/CosmoMyst.Math/blob/master/source/cosmomyst/math/core.d
// thanks code :)

/++
 +
 +/
float rad(float deg) pure nothrow @nogc
{
    import std.math : PI;

    return deg * (PI / 180);
}

/++
 +
 +/
float deg(float rad) pure nothrow @nogc
{
    import std.math : PI;

    return rad * 180 / PI;
}