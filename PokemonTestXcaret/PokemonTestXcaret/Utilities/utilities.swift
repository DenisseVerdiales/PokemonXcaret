//
//  utilities.swift
//  PokemonTestXcaret
//
//  Created by Consultant on 1/3/23.
//

import UIKit

class Utilities{

    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&.])[A-Za-z\\d$@$#!%*?&.]{8,}")
        return passwordTest.evaluate(with: password)
    }
}

struct result {
    var message: String
    var status: Bool
    
    init(msg: String, status: Bool) {
        self.message = msg
        self.status = status
    }
}
