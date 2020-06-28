module viva.exceptions.check;

/++
 + Checks a condition
 + Params:
 +      cond = The condition
 +      message = The user defined exception message
 + Throws: `Exception` if `cond` is false
 +/
void check(bool cond, string message) pure @safe
{
    checkBare!Exception(cond, "check failed with message: " ~ message);
}

/++
 + Checks a condition
 + Params:
 +      cond = The condition
 +      message = The user defined exception message
 + Throws: The given exception (`T`) if `cond` is false
 +/
void check(T)(bool cond, string message) pure @safe
if (is(T : Exception))
{
    checkBare!T(cond, "check failed with message: " ~ message);
}

/++
 + Checks a condition
 + Params:
 +      cond = The condition
 +      message = The exception message
 + Throws: `Exception` if `cond` is false
 +/
void checkBare(bool cond, string message) pure @safe
{
    checkBare!Exception(cond, message);
}

/++
 + Checks a condition
 + Params:
 +      cond = The condition
 +      message = The exception message
 + Throws: The given exception (`T`) if `cond` is false
 +/
void checkBare(T)(bool cond, string message) pure @safe
if (is(T : Exception))
{
    if (!cond)
        throw new T(message);
}

/++
 + Checks if 2 values are equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The user defined exception message
 + Throws: `Exception` if they're not equals
 +/
void checkEquals(K, V)(K obj1, V obj2, string message) pure @safe
{
    checkEquals!(Exception, K, V)(obj1, obj2, message);
}

/++
 + Checks if 2 values are equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The user defined exception message
 + Throws: The given exception (`T`) if they're not equals
 +/
void checkEquals(T, K, V)(K obj1, V obj2, string message) pure @safe
if (is(T : Exception))
{
    checkBare!(T)(obj1 == obj2, "checkEquals failed with message: " ~ message);
}

/++
 + Checks if 2 values are equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The exception message
 + Throws: `Exception` if they're not equals
 +/
void checkEqualsBare(K, V)(K obj1, V obj2, string message) pure @safe
{
    checkEqualsBare!(Exception, K, V)(obj1, obj2, message);
}

/++
 + Checks if 2 values are equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The exception message
 + Throws: The given exception (`T`) if they're not equals
 +/
void checkEqualsBare(T, K, V)(K obj1, V obj2, string message) pure @safe
if (is(T : Exception))
{
    checkBare!(T)(obj1 == obj2, message);
}

/++
 + Checks if 2 values are not equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The user defined exception message
 + Throws: `Exception` if they're equals
 +/
void checkNotEquals(K, V)(K obj1, V obj2, string message) pure @safe
{
    checkNotEquals!(Exception, K, V)(obj1, obj2, message);
}

/++
 + Checks if 2 values are not equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The user defined exception message
 + Throws: The given exception (`T`) if they're equals
 +/
void checkNotEquals(T, K, V)(K obj1, V obj2, string message) pure @safe
if (is(T : Exception))
{
    checkBare!(T)(obj1 != obj2, "checkNotEquals failed with message: " ~ message);
}

/++
 + Checks if 2 values are not equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The exception message
 + Throws: `Exception` if they're equals
 +/
void checkNotEqualsBare(K, V)(K obj1, V obj2, string message) pure @safe
{
    checkNotEqualsBare!(Exception, K, V)(obj1, obj2, message);
}

/++
 + Checks if 2 values are not equals
 + Params:
 +      obj1 = The first value
 +      obj2 = The second value
 +      message = The exception message
 + Throws: The given exception (`T`) if they're equals
 +/
void checkNotEqualsBare(T, K, V)(K obj1, V obj2, string message) pure @safe
if (is(T : Exception))
{
    checkBare!(T)(obj1 != obj2, message);
}