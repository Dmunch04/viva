module viva.dvm.vm.vm;

import viva.dvm.vm.instruction;
import viva.dvm.vm.opcode;

/++
 +
 +/
struct VM
{
    private int[] stack;
    private int ip = 0;
    private int sp = -1;

    ///
    public Instruction[] instructions;

    /++
     +
     +/
    this(Instruction[] instructions)
    {
        this.instructions = instructions;

        this.stack = new int[countStackInstructions() -1];
    }

    private int countStackInstructions()
    {
        int count = 0;

        foreach (instruction; instructions)
        {
            if (
                instruction.opcode == Opcode.ICONST
                || instruction.opcode == Opcode.IADD
                || instruction.opcode == Opcode.ISUB
                || instruction.opcode == Opcode.IMUL
                || instruction.opcode == Opcode.IDIV
                || instruction.opcode == Opcode.INEG
            )
                count++;

            else if (instruction.operands.length != 0)
                count++;
        }

        return count;
    }

    private int pop()
    {
        int val = stack[sp];
        stack[sp] = 0;
        sp--;
        return val;
    }

    private void push(int val)
    {
        sp++;
        stack[sp] = val;
        return;
    }

    /++
     +
     +/
    public void execute()
    {
        foreach (instruction; instructions)
        {
            ip++;

            final switch (instruction.opcode)
            {
                case Opcode.HALT: return;

                case Opcode.PRINT:
                {
                    import viva.io.console : println;

                    int i = stack[sp];
                    println(i);

                    continue;
                }

                case Opcode.DUP:
                {
                    int i = stack[sp];
                    push(i);

                    continue;
                }

                case Opcode.SWAP:
                {
                    int i = pop();
                    int j = pop();
                    push(i);
                    push(j);

                    continue;
                }

                case Opcode.ICONST:
                {
                    int i = instruction.operands[0];
                    push(i);

                    continue;
                }

                case Opcode.IADD:
                {
                    int i = pop();
                    int j = pop();
                    push(i + j);

                    continue;
                }

                case Opcode.ISUB:
                {
                    int i = pop();
                    int j = pop();
                    push(j - i);

                    continue;
                }

                case Opcode.IMUL:
                {
                    int i = pop();
                    int j = pop();
                    push(j * i);

                    continue;
                }

                case Opcode.IDIV:
                {
                    int i = pop();
                    int j = pop();
                    push(j / i);

                    continue;
                }

                case Opcode.INEG:
                {
                    int i = pop();
                    push(-i);

                    continue;
                }
            }
        }
    }
}