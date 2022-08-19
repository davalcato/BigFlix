//
//  Extensions.swift
//  BigFlix
//
//  Created by Daval Cato on 8/19/22.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        // choosing the letter and the remaining lower case letters
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
        
    }
}











