//
//  parse.swift
//  heat
//
//  Created by Elizabeth Luoma on 8/9/25.
//

enum ParseError : Error {
    case invalidToken(Token)
    case eofExpected
}

func lookahead(_ ts: [Token]) throws -> (Token, [Token]) {
    return (ts.first!, Array(ts.dropFirst()))
}

func parse(_ ts: [Token]) throws -> Ast {
    switch try lookahead(ts) {
    case let (.IntLit(i), rts):
        switch try lookahead(rts) {
        case (.Eof, _):
            return Ast.IntLit(i)
        default:
            throw ParseError.eofExpected
        }
    default:
        throw ParseError.invalidToken(ts.first!)
    }
}
