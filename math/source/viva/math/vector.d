module viva.math.vector;

// Based on https://github.com/CosmoMyst/CosmoMyst.Math/blob/master/source/cosmomyst/math/vector.d
// thanks code :)

alias Vector1 = Vector!1;
alias Vector2 = Vector!2;
alias Vector3 = Vector!3;
alias Vector4 = Vector!4;

/++
 +
 +/
struct Vector(ulong n)
if (n >= 1)
{
    union
    {
        ///
        float[n] v;

        struct
        {
            static if (n >= 1)
            {
                ///
                float x;
            }

            static if (n >= 2)
            {
                ///
                float y;
            }

            static if (n >= 3)
            {
                ///
                float z;
            }

            static if (n >= 4)
            {
                ///
                float w;
            }
        }
    }

    /++
     +
     +/
    this(T...)(T values) pure nothrow @nogc
    {
        import viva.types.number : isNumber;

        static foreach (value; values)
        {
            static assert(isNumber!(typeof(value)), "all values must be numeric");
        }

        static assert(values.length > 0, "no values provided");
        static assert(values.length == 1 || values.length == n, "number of values must be either 1 or number of components");

        static if (values.length == 1)
        {
            static foreach (i; 0..n)
            {
                v[i] = values[0];
            }
        }
        else
        {
            static foreach (i, value; values)
            {
                v[i] = value;
            }
        }
    }

    /++
     +
     +/
    auto ptr() pure const nothrow @nogc
    {
        return v.ptr;
    }

    /++
     +
     +/
    float length() pure const nothrow @nogc
    {
        import std.math : sqrt;

        float sum = 0;
        for (int i = 0; i < n; i++)
        {
            sum += v[i] * v[i];
        }

        return sqrt(sum);
    }

    /++
     +
     +/
    void normalize() pure nothrow @nogc
    {
        this = normalized();
    }

    /++
     +
     +/
    Vector!n normalized() pure const nothrow @nogc
    {
        if (length() == 0)
        {
            return Vector!n(0f);
        }

        return this / length();
    }

    /++
     +
     +/
    Vector!n opBinary(string op)(in float scalar) @nogc
    const if (op == "/")
    {
        Vector!n res;

        for (int i = 0; i < n; i++)
        {
            res.v[i] = v[i] / scalar;
        }

        return res;
    }

    /++
     +
     +/
    void opOpAssign(string op)(in float scalar) @nogc
    const if (s == "/")
    {
        auto res = this / scalar;
        this.v = res.v;
    }
}