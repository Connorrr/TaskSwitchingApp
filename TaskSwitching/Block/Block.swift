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
    var isTrialSwitch : [Bool] = []
    
    
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
    
    
    /// Initializer used for the updated practice trials and mixed block
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
            print("This is the switch list for \(numberTrials) trials")
            sortMixedBlock()
            
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
            
            trial = getTrial(trialNum: i)
            
            if blockType != .single {
                trial.isSwitchTrial = isTrialSwitch[i-1]
            }else{
                trial.isSwitchTrial = false
            }
            trials?.append(trial)
            
            print(trial.stimLabel!)
        }

    }
    
    private func sortMixedBlock() {
        
        var randomBool : Bool {
            let b = false
            return b.randomBool()
        }
        
        let nonSwitchCount : Int = Int(Float(numberOfTrials!/2).rounded(.up))
        let switchCount : Int = Int(Float(numberOfTrials!/2).rounded(.down))
        var switchArray = Array(repeating: true, count: switchCount)
        var nonSwitchArray = Array(repeating: false, count: nonSwitchCount)
        
        var repeatSwitchCount : Int = 0
        var repeatNonSwitchCount : Int = 1
        
        isTrialSwitch.append(nonSwitchArray.removeFirst())
        for _ in 1 ..< numberOfTrials! {
            if repeatSwitchCount >= 3 {
                isTrialSwitch.append(nonSwitchArray.removeFirst())
                repeatNonSwitchCount = repeatNonSwitchCount + 1
                repeatSwitchCount = 0
            }else if repeatNonSwitchCount >= 3 {
                isTrialSwitch.append(switchArray.removeFirst())
                repeatSwitchCount = repeatSwitchCount + 1
                repeatNonSwitchCount = 0
            }else{
                if randomBool {     // Put in a switch trial if it's still available
                    if switchArray.count > 0 {
                        isTrialSwitch.append(switchArray.removeFirst())
                        repeatSwitchCount = repeatSwitchCount + 1
                        repeatNonSwitchCount = 0
                    }else{
                        isTrialSwitch.append(nonSwitchArray.removeFirst())
                        repeatNonSwitchCount = repeatNonSwitchCount + 1
                        repeatSwitchCount = 0
                    }
                }else{              // Put in a nonswitch trial if it's still available
                    if nonSwitchArray.count > 0 {
                        isTrialSwitch.append(nonSwitchArray.removeFirst())
                        repeatNonSwitchCount = repeatNonSwitchCount + 1
                        repeatSwitchCount = 0
                    }else{
                        isTrialSwitch.append(switchArray.removeFirst())
                        repeatSwitchCount = repeatSwitchCount + 1
                        repeatNonSwitchCount = 0
                    }
                }
            }
        }
        print(isTrialSwitch)
    }
    
    
    /// Returns the LetterNumberSim object that works for this trial.  This function makes usre that there aren't repeats.
    ///
    /// - Parameter trialNum: the current trial number
    /// - Returns: The LetterNumberStim object for this trial
    private func getTrial(trialNum: Int) -> TrialInfo {
        
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
            if isOdd != trials![trialNum-2].isEven {        //  Does this and the last trial share number conditions
                if isVowel == trials![trialNum-2].isVowel { //  Does this and the last trial share letter conditions
                    if randomBool == true {                 //  Make sure the numbers are different
                        trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex, excludingNumber: trials![trialNum-2].letterNumberPair!._number!)
                    }else{                                  // Make sure the letters are different
                        trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, excludingLetter: trials![trialNum-2].letterNumberPair!._letter!, isOdd: isOdd, numberIndex: randomIndex)
                    }
                }else{
                    trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
                }
            }else{
                trialLetterNum = LetterNumberStim(isVowel: isVowel, letterIndex: randomIndex, isOdd: isOdd, numberIndex: randomIndex)
            }
        }
        trial.isEvenOdd = true      // TODO:  This needs to be changed to show whether the current trial is a EvenOdd trial or a VowelConsonant trial
        trial.stimLabel = "\(trialLetterNum!._letter!)\(trialLetterNum!._number!)"
        trial.letterNumberPair = trialLetterNum
        
        return trial
    }
    
}
