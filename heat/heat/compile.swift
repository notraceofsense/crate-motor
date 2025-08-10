//
//  compile.swift
//  heat
//
//  Created by Elizabeth Luoma on 8/9/25.
//

import flame

func compile(e: Ast) -> Array<flame.Instr> {
    switch e {
    case .IntLit(let i):
        return [Setx(val: i, tmp: Reg.o1, dest: Reg.o0)]
    default:
        return []
    }
}
