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
    /// - Parameter trialCondition: This is the trial condition that will define wheather it is even/odd or above/below (note: the specific condition will be ignored)
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
    ///   - startingTrialCondition: This is the trial condition that will define wheather we start with even/odd or above/below (note: the specific condition will be ignored)
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
    ///   - numberOfPracticeTrials: The numer of practice trials to be built in this block
    ///   - startingTrialCondition: This is the trial condition that will define wheather we start with even/odd or above/below (note: the specific condition will be ignored) however if this is a single blocktype then this value will describe the condition for the whole block
    ///   - isMixed: is this a mixed trial condition
    ///   - numerOfSwitches: if it is mixed how many switches will there be in the block
    init(numberOfPracticeTrials: Int, startingTrialCondition: TrialCondition, isMixed: Bool, numerOfSwitches: Int?) {
        numberOfTrials = numberOfPracticeTrials
        if isMixed {
            blockType = .mixed
            startTrialCondition = startingTrialCondition
            numSwitches = numerOfSwitches!
            if numerOfSwitches == nil {
                print("numerOfSwitches must be set for mixed practice block")
                return
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
        var isevenOdd = true
        if (startTrialCondition == .consonant || startTrialCondition == .odd) {
            isevenOdd = false
        }

        for i in 1 ... numberOfTrials! {
                
            if blockType == .mixed {
                let switchEvery = numberOfTrials!/numSwitches!
                    
                if ( i % switchEvery == 0 ) {
                    isevenOdd = !isevenOdd
                }
                    
            }
                
            if isevenOdd {
                trial.isVegeFruit = false
                if isevenOdd.randomBool() {
                    let data = img.getRedStimulus()
                    trial.condition = .vowel
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }else{
                    let data = img.getGreenStimulus()
                    trial.condition = .even
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }
            }else{
                trial.isVegeFruit = true
                if isevenOdd.randomBool() {
                    let data = img.getVegeStimulus()
                    trial.condition = .consonant
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }else{
                    let data = img.getFruitStimulus()
                    trial.condition = .odd
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }
            }
                
            trials?.append(trial)
        }

    }
    
}
