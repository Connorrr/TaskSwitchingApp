//
//  TrialInfo.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit

struct TrialInfo {
    var question : String?          //  Not really necessary at the moment
    var condition : TrialCondition?
    var correctResponse : TrialCondition?
    var stim : UIImage?
    var stimName : String?
    var isVegeFruit : Bool?
}
