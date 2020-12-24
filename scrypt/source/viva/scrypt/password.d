module viva.scrypt.password;

/*
 * Copyright (C) 2013 Isak Andersson (BitPuffin@lavabit.com)
 * 
 * Distributed under the terms of the zlib/libpng license
 * See LICENSE.txt in project root for more info
 */

import viva.scrypt.crypto;
import std.string : indexOf;
import std.exception : enforce;
import std.digest : toHexString;
import std.uuid : randomUUID;
import std.algorithm : splitter;
import std.array: array;
import std.conv: to;

enum SCRYPT_N_DEFAULT = 16384;
enum SCRYPT_R_DEFAULT = 8;
enum SCRYPT_P_DEFAULT = 1;
enum SCRYPT_OUTPUTLEN_DEFAULT = 90;
private enum TERMINATOR = '$'; 

/// Takes no parameters, returns a random UUID in string form
string genRandomSalt() {
    return randomUUID().toString();
}

/**
  * Some info regarding the params
  * password: The password you want to hash, for example "my password"
  * salt: The salt you want to use when hashing your password, for example generateRandomSalt();
  * scrypt_outputlen: the length of the output string containing your hashed password from scrypt. Reccomended value is 90. Note, the actual output won't be 90 since it's a sha1 digest
  * N: General work factor, iteration count. Must be power of two. Recommended value for passwords: 2^14 and 2^20 for sensitive stuff
  * r: Blocksize for underlying hash. Reccommended value is 8
  * p: parallelization factor. Reccomended value is 1
  * If you want to you can use SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT, SCRYPT_OUTPUTLEN_DEFAULT as default params
  */
string genScryptPasswordHash(string password, string salt = genRandomSalt(),
    size_t scrypt_outputlen = SCRYPT_OUTPUTLEN_DEFAULT, ulong N = SCRYPT_N_DEFAULT, uint r = SCRYPT_R_DEFAULT,
    uint p = SCRYPT_P_DEFAULT) @trusted {
    ubyte[] outpw = new ubyte[scrypt_outputlen];
    libscrypt_scrypt(cast(ubyte*)password.ptr, password.length, cast(ubyte*)salt.ptr, salt.length, N, r, p, outpw.ptr, outpw.length);
    
    return toHexString(outpw).idup ~ TERMINATOR ~ salt ~ TERMINATOR ~ to!string(scrypt_outputlen) ~ TERMINATOR ~ to!string(N) ~ TERMINATOR ~ to!string(r) ~ TERMINATOR ~ to!string(p);
}

/**
  * Some info regarding the params
  * hash: An already hashed version of your password, for example fetched from a database
  * password: The password you wish to see if it matches
  */
bool checkScryptPasswordHash(string hash, string password) @trusted {
    auto params = hash.splitter(TERMINATOR).array[1 .. $];
    enforce(params.length == 5, "invalid hash string, does not meet requirements");
    return genScryptPasswordHash(password, params[0], to!size_t(params[1]), to!ulong(params[2]), to!uint(params[3]), to!uint(params[4])) == hash;
}