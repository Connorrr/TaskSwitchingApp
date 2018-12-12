//
//  Block.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation
import UIKit

class Block {
    
    let blockType : BlockType
    let numberOfTrials : Int?
    let startTrialCondition : TrialCondition
    let numSwitches : Int?
    var trials : [TrialInfo]? = []
    
    
    
    /// Single condition initializer
    ///
    /// - Parameter trialCondition: This is the trial condition that will define wheather it is even/odd or vowel/consonants (note: the specific condition will be ignored)
    init(trialCondition: TrialCondition) {
        numberOfTrials = 17
        blockType = .single
        startTrialCondition = trialCondition
        numSwitches = nil
        buildTrialList()
    }
    
    /// Mixed condition initialized
    ///
    /// - Parameters:
    ///   - startingTrialCondition: This is the trial condition that will define wheather we start with even/odd or vowel/consonants (note: the specific condition will be ignored)
    ///   - numerOfSwitches: number of switches in throughout the trial list
    init(startingTrialCondition: TrialCondition, numerOfSwitches: Int) {
        numberOfTrials = 17
        blockType = .mixed
        startTrialCondition = startingTrialCondition
        numSwitches = numerOfSwitches
        buildTrialList()
    }
    
    
    /// Initializer used for the updated practice trials
    ///
    /// - Parameters:
    ///   - numberTrials: The numer of trials to be built in this block
    ///   - startingTrialCondition: This is the trial condition that will define wheather we start with even/odd or above/below (note: the specific condition will be ignored) however if this is a single blocktype then this value will describe the condition for the whole block
    ///   - isMixed: is this a mixed trial condition
    ///   - numerOfSwitches: if it is mixed how many switches will there be in the block
    init(numberTrials: Int, startingTrialCondition: TrialCondition, isMixed: Bool, numerOfSwitches: Int?) {
        numberOfTrials = numberTrials
        if isMixed {
            blockType = .mixed
            startTrialCondition = startingTrialCondition
            if numerOfSwitches == nil {
                print("numerOfSwitches must be set for mixed practice block")
                numSwitches = 0
                return
            }else{
                numSwitches = numerOfSwitches!
            }
            
        } else {
            blockType = .single
            startTrialCondition = startingTrialCondition
            numSwitches = nil
        }
        buildTrialList()
    }
    
    private func buildTrialList() {
        
        let img = UIImage()
        
        var trial = TrialInfo()
        var isevenOdd = false
        if (startTrialCondition == .even || startTrialCondition == .odd) {
            isevenOdd = true
        }
        
        var randomIndex : Int {
            return Int.random( in: 0 ... 3 )
        }

        for i in 1 ... numberOfTrials! {
            
            trial = getTria(trialNum: i)
            
            //TODO:  Impliment the code to handle the trial strucure for mixed business
                
            trials?.append(trial)
            
            print("\(String(describing: trial.letterNumberPair!._letter))\(String(describing: trial.letterNumberPair!._number))\n")
        }

    }
    
    
    /// Returns the LetterNumberSim object that works for this trial.  This function makes usre that there aren't repeats.
    ///
    /// - Parameter trialNum: the current trial number
    /// - Returns: The LetterNumberStim object for this trial
    private func getTria(trialNum: Int) -> TrialInfo {
        
        var trial = TrialInfo()
        var trialLetterNum : LetterNumberStim?
        var randomBool : Bool {
            let foo = false
            return foo.randomBool()
        }
        var randomIndex : Int {
            return Int.random( in: 0 ... 3 )
        }
        let isOdd = randomBool
        let isVowel = randomBool
        
        if isVowel {
            trial.condition = .vowel
        }else{
            trial.condition = .consonant
        }
        
        if isOdd {
            trial.condition = .odd
        }else{
            trial.condition = .even
        }
        
        if trialNum == 1 {
            trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
        }else{
            if isOdd != trials![trialNum-1].isEven {        //  Does this and the last trial share number conditions
                if isVowel == trials![trialNum-1].isVowel { //  Does this and the last trial share letter conditions
                    if randomBool == true {                 //  Make sure the numbers are different
                        trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex, excludingNumber: trials![trialNum-1].letterNumberPair!._number!)
                    }else{                                  // Make sure the letters are different
                        trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, excludingLetter: trials![trialNum-1].letterNumberPair!._letter!, isOdd: isOdd, numberIndex: randomIndex)
                    }
                }else{
                    trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
                }
            }else{
                trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
            }
        }
        
        trial.letterNumberPair = trialLetterNum
        
        return trial
    }
    
}
