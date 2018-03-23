//
//  Validations.swift
//  DataBase Controller
//
//  Created by Appinventiv-Mac on 19/03/18.
//  Copyright © 2018 Appinventiv-Mac. All rights reserved.
//

import Foundation

class Validations {
   
    //MARK : MOBILE
    
    static func validate_mobile(mobile:String)->Bool {
        let set = CharacterSet(charactersIn: "0123456789")
        if mobile.rangeOfCharacter(from: set.inverted) != nil || mobile.count != 10 {
            return false
        }
        else {
            return true
        }
    }
    
    //MARK: NAME
    
    static func validate_name(name:String)->Bool {
        let nameRX = "^[a-zA-Z]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@",nameRX)
        let resultname = nameTest.evaluate(with: name)
        if resultname == true {
            return true
        }
        else {
            return false
        }
    }
    
}
