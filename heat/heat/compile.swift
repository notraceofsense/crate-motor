//
//  compile.swift
//  heat
//
//  Created by Elizabeth Luoma on 8/9/25.
//

import flame

func compile(_ e: Ast) -> [flame.Instr] {
    return [
        
    ] + compile_e(e)
}

func compile_e(_ e: Ast) -> [flame.Instr] {
    switch e {
    case .IntLit(let i):
        return [Setx(val: i, tmp: Reg.o1, dest: Reg.o0)]
    default:
        return []
    }
}
