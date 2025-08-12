//
//  lex.swift
//  heat
//
//  Created by Elizabeth Luoma on 8/9/25.
//

enum Token {
    case IntLit(Int)
    case Eof
}

enum TokenizeError : Error {
    case invalidInput(String)
}

func tokenize(_ s: String) throws -> [Token] {
    if s == "" {
        return [Token.Eof]
    }
    
    let digitRgx = /([0-9]+)/
    
    if let match = s.firstMatch(of: digitRgx) {
        let val = match.1
        let next = match.range.upperBound
        return [Token.IntLit(Int(val)!)] + (try tokenize(String(s[next...])))
    }
    
    throw TokenizeError.invalidInput(s)
}
