module viva.scrypt.crypto;

alias uint8_t = ubyte;
alias uint32_t = uint;
alias uint64_t = ulong;

extern (C):

/**
 * libscrypt_scrypt(passwd, passwdlen, salt, saltlen, N, r, p, buf, buflen):
 * Compute scrypt(passwd[0 .. passwdlen - 1], salt[0 .. saltlen - 1], N, r,
 * p, buflen) and write the result into buf.  The parameters r, p, and buflen
 * must satisfy r * p < 2^30 and buflen <= (2^32 - 1) * 32.  The parameter N
 * must be a power of 2 greater than 1.
 *
 * Return 0 on success; or -1 on error.
 */
int libscrypt_scrypt(const uint8_t*, size_t, const uint8_t*, size_t, uint64_t,
    uint32_t, uint32_t, uint8_t*, size_t);