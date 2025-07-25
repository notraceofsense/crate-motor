// Starting with this because I ain't readin allat for the actual instruction reference
// We can do that later
// https://moss.csc.ncsu.edu/~mueller/codeopt/codeopt00/notes/sparc.html

protocol Operand {}

enum Reg : Operand {
    case g0, g1, g2, g3, g4, g5, g6, g7
    case o0, o1, o2, o3, o4, o5, o6, o7
    case l0, l1, l2, l3, l4, l5, l6, l7
    case i0, i1, i2, i3, i4, i5, i6, i7
}

struct Imm : Operand {
    enum ImmError: Error {
        case outOfRange
    }

    var value: Int
    init(value: Int) throws {
        if(value > 4095 || value < -4096) {
            throw ImmError.outOfRange
        } else {
            self.value = value
        }
    }
}

struct Offset {
    var base: Reg { get }
    var offset: Operand { get }

    init(base: Reg, offset: Operand) {
        self.base = base
        self.offset = offset
    }
}

protocol Label {}

protocol Instr {
    func toAsm()
}

enum ArithInstr : Instr {
    case add(Reg, Operand, Reg)
    case sub(Reg, Operand, Reg)
    case and(Reg, Operand, Reg)
    case andn(Reg, Operand, Reg)
    case or(Reg, Operand, Reg)
    case orn(Reg, Operand, Reg)
    case xor(Reg, Operand, Reg)
    case xnor(Reg, Operand, Reg)
    // Condition code setting opcodes
    case addcc(Reg, Operand, Reg)
    case subcc(Reg, Operand, Reg)
    case andcc(Reg, Operand, Reg)
    case andncc(Reg, Operand, Reg)
    case orcc(Reg, Operand, Reg)
    case orncc(Reg, Operand, Reg)
    case xorcc(Reg, Operand, Reg)
    case xnorcc(Reg, Operand, Reg)
}

enum LoadStoreInstr : Instr {
    case ld(Offset, Reg)
    case ldub(Offset, Reg)
    case ldsb(Offset, Reg)
    case lduh(Offset, Reg)
    case ldsh(Offset, Reg)
    case ldd(Offset, Reg)
    case st(Reg, Offset)
    case stb(Reg, Offset)
    case sth(Reg, Offset)
    case std(Reg, Offset)
}

enum BranchInstr : Instr {
    case ba(Label)
    case bn(Label)
    case bne(Label)
    case bnz(Label)
    case be(Label)
    case bz(Label)
    case bg(Label)
    case ble(Label)
    case bge(Label)
    case bl(Label)
    case bgu(Label)
    case bleu(Label)
    case bcc(Label)
    case bcs(Label)
    case bpos(Label)
    case bneg(Label)
    case bvc(Label)
    case bvs(Label)
}

enum CallInstr : Instr {
    case call(Label)
}

