module viva.dvm.vm.opcode;

/++
 +
 +/
enum Opcode : ubyte
{
    HALT,

    PRINT,
    DUP,
    SWAP,

    ICONST,
    IADD,
    ISUB,
    IMUL,
    IDIV,
    INEG
}