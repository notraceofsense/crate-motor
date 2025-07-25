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
        }
    }
}

protocol Offset<T: Operand> {
    var base: Reg { get }
    var offset: T { get }
}

struct RegOffset : Offset<Reg> {
    var base: Reg
    var offset: Reg
}

struct ImmOffset : Offset<Imm> {
    var base: Reg
    var offset: Imm
}

protocol Instr {
    func toAsm()
}

enum ArithInstr<T: Operand> : Instr {
    case add(Reg, T, Reg)
    case sub(Reg, T, Reg)
    case and(Reg, T, Reg)
    case andn(Reg, T, Reg)
    case or(Reg, T, Reg)
    case orn(Reg, T, Reg)
    case xor(Reg, T, Reg)
    case xnor(Reg, T, Reg)
    // Condition code setting opcodes
    case addcc(Reg, T, Reg)
    case subcc(Reg, T, Reg)
    case andcc(Reg, T, Reg)
    case andncc(Reg, T, Reg)
    case orcc(Reg, T, Reg)
    case orncc(Reg, T, Reg)
    case xorcc(Reg, T, Reg)
    case xnorcc(Reg, T, Reg)
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
    
}