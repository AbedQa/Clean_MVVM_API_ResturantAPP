//
//  ValidationManager.swift
//  Resturant
//
//  Created by Abed Qassim on 10/10/20.
//

import Foundation
class Validator {
    static var manager = Validator()
    private init(){}
    func validate(text: String, with rules: [Rule]) -> Bool? {
        return rules.compactMap({ $0.check(text) }).first?.isEmpty
    }
}

struct Rule {
    // Return nil if matches, error message otherwise
    let check: (String) -> String?

    static let notEmpty = Rule(check: {
        return $0.isEmpty ? "not empty" : nil
    })
    

    static let validEmail = Rule(check: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "not valid email"
    })

    static let countryCode = Rule(check: {
        let regex = #"^\+\d+.*"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "not have prefix country code"
    })
    static let validPassword = Rule(check: { password in
        if(password.count > 7 && password.count < 17) == false {
            return "should be between 7 & 17"
        }
        // has one char at least upper case
        let nonUpperCase = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
        let letters = password.components(separatedBy: nonUpperCase)
        let strUpper: String = letters.joined()
        
        // has one char at least small Letter case
        let smallLetterRegEx  = ".*[a-z]+.*"
        let samlltest = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
        let smallresult = samlltest.evaluate(with: password)
        
        // has number
        let numberRegEx  = ".*[0-9]+.*"
        let numbertest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = numbertest.evaluate(with: password)

        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        var isSpecial :Bool = false
        if regex.firstMatch(in: password, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, password.count)) != nil {
         print("could not handle special characters")
            isSpecial = true
        }else{
            isSpecial = false
        }
        return (strUpper.count >= 1) && smallresult && numberresult && isSpecial ? nil: "check Password"
    })
    
}
