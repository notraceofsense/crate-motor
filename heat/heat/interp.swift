//
//  interp.swift
//  heat
//
//  Created by Elizabeth Luoma on 8/12/25.
//

func interp(_ e: Ast) -> Any {
    switch e {
    case let .IntLit(i):
        return i
    }
}
