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


/*
 $ cat foo.s
         .file   "foo.c"
         .section        ".text"
         .align 4
         .global foo
         .type   foo, #function
         .proc   04
 foo:
         !#PROLOGUE# 0
         save    %sp, -112, %sp
         !#PROLOGUE# 1
         mov     1, %g1
         mov     %g1, %i0
         ret
         restore
         .size   foo, .-foo
         .ident  "GCC: (GNU) 3.4.3 (csl-sol210-3_4-20050802)"
 
 */
