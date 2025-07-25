// Starting with this because I ain't readin allat for the actual instruction reference
// We can do that later
// https://moss.csc.ncsu.edu/~mueller/codeopt/codeopt00/notes/sparc.html

protocol AsmObject {
    func toAsm() -> String
}

protocol Operand : AsmObject {}
protocol ArithOperand : Operand {}

protocol Address : AsmObject {}

class Constant : AsmObject {
    static var bitLength: Int
    static var signed: Bool
    static var upperBound: Int
    static var lowerBound: Int
    var value: Int

    enum ConstError: Error {
        case outOfRange
    }
}

struct NormConstant : Constant {
    static var bitLength: Int = 32
     static var signed: Bool = true
     static var upperBound: Int = pow(2, bitLength - 1) - 1
     static var lowerBound: Int = -(pow(2, bitLength - 1))
     var value: Int

     init(value: Int) throws {
        if(value > upperBound || value < lowerBound) {
            throw ConstError.outOfRange
        } else {
            self.value = value
        }
    }

    func toAsm() -> String {
        return String(value)
    }
}

// TODO: Find a better way to do these that repeats less code
struct ArithConst : ArithOperand, Constant {
     static var bitLength: Int = 13
     static var signed: Bool = true
     static var upperBound: Int = pow(2, bitLength - 1) - 1
     static var lowerBound: Int = -(pow(2, bitLength - 1))
     var value: Int

     init(value: Int) throws {
        if(value > upperBound || value < lowerBound) {
            throw ConstError.outOfRange
        } else {
            self.value = value
        }
    }

    func toAsm() -> String {
        return String(value)
    }
}

struct SethiConst : Constant {
    static var bitLength: Int = 22
    static var signed: Bool = false
    static var upperBound: Int = pow(2, bitLength) - 1
    static var lowerBound: Int = 0
    var value: Int

    init(value: Int) throws {
        if(value > upperBound || value < lowerBound) {
            throw ConstError.outOfRange
        } else {
            self.value = value
        }
    }

    func toAsm() -> String {
        return String(value)
    }
}

struct UnaryHi : SethiConst {
    case hi(NormConstant)
    case lo(NormConstant)

    func toAsm() -> String {
        switch self {
            case let .hi(operand):
                return "%hi(\(operand.toAsm()))"
            case let .lo(operand):
                return "%lo(\(operand.toAsm()))"
        }
    }
}

enum Reg : Operand, ArithOperand {
    // general purpose
    case g0, g1, g2, g3, g4, g5, g6, g7
    case o0, o1, o2, o3, o4, o5, o6, o7
    case l0, l1, l2, l3, l4, l5, l6, l7
    case i0, i1, i2, i3, i4, i5, i6, i7
    // floating-point
    case f0, f1, f2, f3, f4, f5, f6, f7
    case f8, f9, f10, f11, f12, f13, f14, f15
    case f16, f17, f18, f19, f20, f21, f22, f23
    case f24, f25, f26, f27, f28, f29, f30, f31
    case fsr, fq
    // co-processor
    case c0, c1, c2, c3, c4, c5, c6, c7
    case c8, c9, c10, c11, c12, c13, c14, c15
    case c16, c17, c18, c19, c20, c21, c22, c23
    case c24, c25, c26, c27, c28, c29, c30, c31
    case csr, cq
    // special regs
    case psr, tbr, wim, y

    static let sp = Reg.o6
    static let fp = Reg.i6

    func toAsm() -> String {
        // This is horible but I can't think of a better way
        // TODO: Do this better
        switch self {
            case .g0:
                return "%g0"
            case .g1:
                return "%g1"
            case .g2:
                return "%g2"
            case .g3:
                return "%g3"
            case .g4:
                return "%g4"
            case .g5:
                return "%g5"
            case .g6:
                return "%g6"
            case .g7:
                return "%g7"
            case .o0:
                return "%o0"
            case .o1:
                return "%o1"
            case .o2:
                return "%o2"
            case .o3:
                return "%o3"
            case .o4:
                return "%o4"
            case .o5:
                return "%o5"
            case .o6:
                return "%o6"
            case .o7:
                return "%o7"
            case .l0:
                return "%l0"
            case .l1:
                return "%l1"
            case .l2:
                return "%l2"
            case .l3:
                return "%l3"
            case .l4:
                return "%l4"
            case .l5:
                return "%l5"
            case .l6:
                return "%l6"
            case .l7:
                return "%l7"
            case .i0:
                return "%i0"
            case .i1:
                return "%i1"
            case .i2:
                return "%i2"
            case .i3:
                return "%i3"
            case .i4:
                return "%i4"
            case .i5:
                return "%i5"
            case .i6:
                return "%i6"
            case .i7:
                return "%i7"
            case .f0:
                return "%f0"
            case .f1:
                return "%f1"
            case .f2:
                return "%f2"
            case .f3:
                return "%f3"
            case .f4:
                return "%f4"
            case .f5:
                return "%f5"
            case .f6:
                return "%f6"
            case .f7:
                return "%f7"
            case .f8:
                return "%f8"
            case .f9:
                return "%f9"
            case .f10:
                return "%f10"
            case .f11:
                return "%f11"
            case .f12:
                return "%f12"
            case .f13:
                return "%f13"
            case .f14:
                return "%f14"
            case .f15:
                return "%f15"
            case .f16:
                return "%f16"
            case .f17:
                return "%f17"
            case .f18:
                return "%f18"
            case .f19:
                return "%f19"
            case .f20:
                return "%f20"
            case .f21:
                return "%f21"
            case .f22:
                return "%f22"
            case .f23:
                return "%f23"
            case .f24:
                return "%f24"
            case .f25:
                return "%f25"
            case .f26:
                return "%f26"
            case .f27:
                return "%f27"
            case .f28:
                return "%f28"
            case .f29:
                return "%f29"
            case .f30:
                return "%f30"
            case .f31:
                return "%f31"
            case .fsr:
                return "%fsr"
            case .fq:
                return "%fq"
            case .c0:
                return "%c0"
            case .c1:
                return "%c1"
            case .c2:
                return "%c2"
            case .c3:
                return "%c3"
            case .c4:
                return "%c4"
            case .c5:
                return "%c5"
            case .c6:
                return "%c6"
            case .c7:
                return "%c7"
            case .c8:
                return "%c8"
            case .c9:
                return "%c9"
            case .c10:
                return "%c10"
            case .c11:
                return "%c11"
            case .c12:
                return "%c12"
            case .c13:
                return "%c13"
            case .c14:
                return "%c14"
            case .c15:
                return "%c15"
            case .c16:
                return "%c16"
            case .c17:
                return "%c17"
            case .c18:
                return "%c18"
            case .c19:
                return "%c19"
            case .c20:
                return "%c20"
            case .c21:
                return "%c21"
            case .c22:
                return "%c22"
            case .c23:
                return "%c23"
            case .c24:
                return "%c24"
            case .c25:
                return "%c25"
            case .c26:
                return "%c26"
            case .c27:
                return "%c27"
            case .c28:
                return "%c28"
            case .c29:
                return "%c29"
            case .c30:
                return "%c30"
            case .c31:
                return "%c31"
            case .csr:
                return "%csr"
            case .cq:
                return "%cq"
            case .psr:
                return "%psr"
            case .tbr:
                return "%tbr"
            case .wim:
                return "%wim"
            case .y:
                return "%y"
        }
    }
}

struct Offset : AsmObject {
    var base: Reg { get }
    var offset: ArithOperand { get }

    init(base: Reg, offset: ArithOperand = ArithConst(0)) {
        self.base = base
        self.offset = offset
    }

    func toAsm() -> String {
        return "[\(base.toAsm())+\(offset.toAsm())]"
    }
}

struct Label : Address {
    var value : String { get }
    init(value: String) {
        // TODO: Check validity of label
        self.value = value
    }

    func toAsm() -> String {
        return value
    }
}

struct BranchAddress : Address, Constant {
    static var bitLength: Int = 22
    static var signed: Bool = false
    static var upperBound: Int = pow(2, bitLength) - 1
    static var lowerBound: Int = 0
    var value: Int

    init(value: Int) throws {
        if(value > upperBound || value < lowerBound) {
            throw ConstError.outOfRange
        } else {
            self.value = value
        }
    }

    func toAsm() -> String {
        return String(value)
    }
}

struct JumpAddress : Address, Constant {
    static var bitLength: Int = 30
    static var signed: Bool = false
    static var upperBound: Int = pow(2, bitLength) - 1
    static var lowerBound: Int = 0
    var value: Int

    init(value: Int) throws {
        if(value > upperBound || value < lowerBound) {
            throw ConstError.outOfRange
        } else {
            self.value = value
        }
    }

    func toAsm() -> String {
        return String(value)
    }
}

protocol Instr : AsmObject {}

struct LabelInstr : Instr {
    var label : Label { get }
    init(label: Label) {
        self.label = label
    }

    func toAsm() -> String {
        return "\(label):"
    }
}

enum ArithInstr : Instr {
    case add(Reg, ArithOperand, Reg)
    case sub(Reg, ArithOperand, Reg)
    case and(Reg, ArithOperand, Reg)
    case andn(Reg, ArithOperand, Reg)
    case or(Reg, ArithOperand, Reg)
    case orn(Reg, ArithOperand, Reg)
    case xor(Reg, ArithOperand, Reg)
    case xnor(Reg, ArithOperand, Reg)
    // Condition code setting opcodes
    case addcc(Reg, ArithOperand, Reg)
    case subcc(Reg, ArithOperand, Reg)
    case andcc(Reg, ArithOperand, Reg)
    case andncc(Reg, ArithOperand, Reg)
    case orcc(Reg, ArithOperand, Reg)
    case orncc(Reg, ArithOperand, Reg)
    case xorcc(Reg, ArithOperand, Reg)
    case xnorcc(Reg, ArithOperand, Reg)
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

enum RegWinInstr : Instr {
    case restore(Reg, Operand, Reg)
    case save(Reg, Operand, Reg)
}

enum JmplInstr : Instr {
    case jmpl(Label, Reg)
}

enum MiscInstr : Instr {
    case sethi(SethiConst, Reg)
}

enum SynthInstr : Instr {
    case cmp(Reg, Operand)
    case jmp(Label)
    case call(Label)
    case tst(Reg)
    case ret
    case retl
    case restore
    case save 
    case set(Int, Reg)
    case not(Reg, Reg)
    case neg(Reg, Reg)
}

enum PseudoOps : AsmObject {
    case align(Int)
    case ascii(String)
    case file(String)
    case global(String)
    case ident(String)
    case proc(Int)
    case section(String)
    case size(Int)
    case skip(Int)
    case type(String)
    case word(Int)
}