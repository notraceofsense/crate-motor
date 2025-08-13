//
//  main.swift
//  heat
//
//  Created by Elizabeth Luoma on 8/9/25.
//

import Foundation
import flame

var input: String = ""

while let line = readLine() {
    input += line
}

print(try flame.toAsm(compile(parse(tokenize(input)))))

