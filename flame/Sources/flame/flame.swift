

public protocol AsmObject {
    func toAsm() -> String
}

public protocol Instr : AsmObject {}

public protocol Address : AsmObject {}

struct Label : Address {
    var name : String
    func toAsm() -> String {
        return name
    }
}

public protocol Reg_Or_Imm : AsmObject {}

struct Imm : Reg_Or_Imm, Address {
    var val : Int

    func toAsm() -> String {
        return String(val)
    }
}

struct LabelInstr : Instr {
    var name : Label
    func toAsm() -> String {
        return "\(name.toAsm()):"
    }
}

public enum Reg : Reg_Or_Imm {
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
    // special regs
    case psr, tbr, wim, y

    nonisolated(unsafe) static let sp = Reg.o6
    nonisolated(unsafe) static let fp = Reg.i6

    public func toAsm() -> String {
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

struct Call : Instr {
    var destination : Address

    func toAsm() -> String {
        return "call \(destination.toAsm())"
    }
}

struct Add : Instr {
    var src1: Reg
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "add \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Sub : Instr {
    var src1: Reg
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "sub \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Mul : Instr {
    var src1: Reg_Or_Imm
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "mul \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Sdiv : Instr {
    var src1: Reg_Or_Imm
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "sdiv \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Udiv : Instr {
    var src1: Reg_Or_Imm
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "udiv \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct And : Instr {
    var src1: Reg_Or_Imm
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "and \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Or : Instr {
    var src1: Reg_Or_Imm
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "or \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Xor : Instr {
    var src1: Reg_Or_Imm
    var src2: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "xor \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Sll : Instr {
    var src: Reg
    var count: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "sll \(src.toAsm()), \(count.toAsm()), \(dest.toAsm())"
    }
}

struct Srl : Instr {
    var src: Reg
    var count: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "srl \(src.toAsm()), \(count.toAsm()), \(dest.toAsm())"
    }
}

struct Sra : Instr {
    var src: Reg
    var count: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "sra \(src.toAsm()), \(count.toAsm()), \(dest.toAsm())"
    }
}

struct Set : Instr {
    var value: Int
    var dest: Reg

    func toAsm() -> String {
        return "set \(value), \(dest.toAsm())"
    }
}

struct Mov : Instr {
    var src: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "mov \(src.toAsm()), \(dest.toAsm())"
    }
}

struct Nop : Instr {
    func toAsm() -> String {
        return "nop"
    }
}

struct Ret : Instr {
    func toAsm() -> String {
        return "ret"
    }
}

struct Retl : Instr {
    func toAsm() -> String {
        return "retl"
    }
}

struct Save : Instr {
    var src: Reg
    var offset: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "save \(src.toAsm()), \(offset.toAsm()), \(dest.toAsm())"
    }
}

struct Restore : Instr {
    var src: Reg
    var offset: Reg_Or_Imm
    var dest: Reg

    func toAsm() -> String {
        return "restore \(src.toAsm()), \(offset.toAsm()), \(dest.toAsm())"
    }
}

struct Ba : Instr {
    var target: Address

    func toAsm() -> String {
        return "ba \(target.toAsm())"
    }
}

struct Bne : Instr {
    var target: Address

    func toAsm() -> String {
        return "bne \(target.toAsm())"
    }
}

struct Be : Instr {
    var target: Address

    func toAsm() -> String {
        return "be \(target.toAsm())"
    }
}

struct Bg : Instr {
    var target: Address

    func toAsm() -> String {
        return "bg \(target.toAsm())"
    }
}

struct Ble : Instr {
    var target: Address

    func toAsm() -> String {
        return "ble \(target.toAsm())"
    }
}

struct Bl : Instr {
    var target: Address

    func toAsm() -> String {
        return "bl \(target.toAsm())"
    }
}

struct Bge : Instr {
    var target: Address

    func toAsm() -> String {
        return "bge \(target.toAsm())"
    }
}

struct Load : Instr {
    var src: Address
    var dest: Reg

    func toAsm() -> String {
        return "ld [\(src.toAsm())], \(dest.toAsm())"
    }
}

struct Store : Instr {
    var src: Reg
    var dest: Address

    func toAsm() -> String {
        return "st \(src.toAsm()), [\(dest.toAsm())]"
    }
}

struct Ldub : Instr {
    var src: Address
    var dest: Reg

    func toAsm() -> String {
        return "ldub [\(src.toAsm())], \(dest.toAsm())"
    }
}

struct Lduh : Instr {
    var src: Address
    var dest: Reg

    func toAsm() -> String {
        return "lduh [\(src.toAsm())], \(dest.toAsm())"
    }
}

struct Ldd : Instr {
    var src: Address
    var dest: Reg

    func toAsm() -> String {
        return "ldd [\(src.toAsm())], \(dest.toAsm())"
    }
}

struct Std : Instr {
    var src: Reg
    var dest: Address

    func toAsm() -> String {
        return "std \(src.toAsm()), [\(dest.toAsm())]"
    }
}

struct Ldf : Instr {
    var src: Address
    var dest: Reg

    func toAsm() -> String {
        return "ldf [\(src.toAsm())], \(dest.toAsm())"
    }
}

struct Stf : Instr {
    var src: Reg
    var dest: Address

    func toAsm() -> String {
        return "stf \(src.toAsm()), [\(dest.toAsm())]"
    }
}

struct Fadd : Instr {
    var src1: Reg
    var src2: Reg
    var dest: Reg

    func toAsm() -> String {
        return "fadd \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Fsub : Instr {
    var src1: Reg
    var src2: Reg
    var dest: Reg

    func toAsm() -> String {
        return "fsub \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Fmul : Instr {
    var src1: Reg
    var src2: Reg
    var dest: Reg

    func toAsm() -> String {
        return "fmul \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Fdiv : Instr {
    var src1: Reg
    var src2: Reg
    var dest: Reg

    func toAsm() -> String {
        return "fdiv \(src1.toAsm()), \(src2.toAsm()), \(dest.toAsm())"
    }
}

struct Fmov : Instr {
    var src: Reg
    var dest: Reg

    func toAsm() -> String {
        return "fmov \(src.toAsm()), \(dest.toAsm())"
    }
}

public struct Setx : Instr {
    var val: Int
    var tmp: Reg
    var dest: Reg
    
    public init(val: Int, tmp: Reg, dest: Reg) {
        self.val = val
        self.tmp = tmp
        self.dest = dest
    }
    
    public func toAsm() -> String {
        return "setx \(val), \(tmp.toAsm()), \(dest.toAsm())"
    }
}
