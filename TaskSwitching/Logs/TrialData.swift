//
//  CSV.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 27/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

struct TrialData {
    var blockNumber : Int
    var trialNum : Int
    var trialCondition : String
    var blockType : String
    var stim : String
    var response : String
    var rt : Double
    var corr : Int
    var time : String
    
    init() {
        self.blockNumber = 0
        self.trialNum = 0
        self.trialCondition = " "
        self.blockType = " "
        self.stim = " "
        self.response = " "
        self.rt = 0.0
        self.corr = -1
        self.time = " "
    }
    
    init?(blockNumber: Int, trialNum : Int, trialCondition : String, blockType : String, stim : String, response : String, rt : Double, corr : Int, time : String) {
        self.blockNumber = blockNumber
        self.trialNum = trialNum
        self.trialCondition = trialCondition
        self.blockType = blockType
        self.stim = stim
        self.response = response
        self.rt = rt
        self.corr = corr
        self.time = time
    }
    
    init?(dictionary : [String:Any]) {
        guard let blockNumber = dictionary["blockNumber"],
        let trialNum = dictionary["trialNum"],
        let trialCondition = dictionary["trialCondition"],
        let blockType = dictionary["blockType"],
        let stim = dictionary["stim"],
        let response = dictionary["response"],
        let rt = dictionary["rt"],
        let corr = dictionary["corr"],
        let time = dictionary["time"]
        else { return nil }
        

        self.init(blockNumber: blockNumber as! Int, trialNum: trialNum as! Int, trialCondition: trialCondition as! String, blockType: blockType as! String, stim: stim as! String, response: response as! String, rt: rt as! Double, corr: corr as! Int, time: time as! String)
        
    }
    
    var propertyListRepresentation : [String : Any] {
        return ["blockNumber" : blockNumber, "trialNum" : trialNum, "trialCondition" : trialCondition, "blockType" : blockType, "stim" : stim, "response" : response, "rt" : rt, "corr" : corr, "time" : time]
    }
    
    var stringPropertyListRepresentation : [String : String] {
        return ["blockNumber" : String(blockNumber), "trialNum" : String(trialNum), "trialCondition" : String(trialCondition), "blockType" : String(blockType), "stim" : String(stim), "response" : String(response), "rt" : String(rt), "corr" : String(corr), "time" : String(time)]
    }
}
