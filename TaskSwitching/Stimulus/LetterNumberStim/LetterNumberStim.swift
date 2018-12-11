//
//  LetterNumberStim.swift
//  TaskSwitching
//
//  Created by Connor Reid on 11/12/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

struct LetterNumberStim {
    var _letter : String?
    var _number : Int?
    
    init(isVowel: Bool, letterIndex: Int, isOdd: Bool, numberIndex: Int) {
        if isVowel {
            _letter = getVowel(index: letterIndex)
        }else{
            _letter = getConsonant(index: letterIndex)
        }
        
        if isOdd {
            _number = getOdd(index: numberIndex)
        }else{
            _number = getEven(index: numberIndex)
        }
    }
}

extension LetterNumberStim {
    
    
    /// Returns one of the selected vowels indext by: ["A", "E", "I", "U"]
    ///
    /// - Parameter index: the index for the vowel array (0 - 3)
    /// - Returns: the vowel
    func getVowel(index: Int) -> String {
        let vowelLetters = ["A", "E", "I", "U"]
        return vowelLetters[index]
    }
    
    
    /// Returns one of the preselected consonants by the index: ["M", "K", "G", "R"]
    ///
    /// - Parameter index: the index for consonant array (0 - 3)
    /// - Returns: the consonant
    func getConsonant(index: Int) -> String {
        let consonantLetters = ["M", "K", "G", "R"]
        return consonantLetters[index]
    }
    
    /// Returns an Odd number from the preselected odd number array by the index: [3, 5, 7, 9]
    ///
    /// - Parameter index: the index for odd number array (0 - 3)
    /// - Returns: the odd number
    func getOdd(index: Int) -> Int {
        let oddNumbers = [3, 5, 7, 9]
        return oddNumbers[index]
    }
    
    
    /// Returns the Even number from the preselected even numbers by the index: [2, 4, 6, 8]
    ///
    /// - Parameter index: the index for the even number array (0 - 3)
    /// - Returns: the even number
    func getEven(index: Int) -> Int {
        let evenNumbers = [2, 4, 6, 8]
        return evenNumbers[index]
    }
    
}
