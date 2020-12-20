module viva.dvm.vm.instruction;

import viva.dvm.vm.opcode;

/++
 +
 +/
struct Instruction
{
    ///
    Opcode opcode;
    ///
    int[] operands;

    /++
     +
     +/
    this(Opcode opcode, int[] operands...)
    {
        this.opcode = opcode;
        this.operands = operands;
    }
}