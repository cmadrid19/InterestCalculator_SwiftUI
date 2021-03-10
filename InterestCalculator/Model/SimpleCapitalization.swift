//
//  SimpleCapitalization.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI

struct SimpleCapitalization {
    var time: Int?
    var principal: String?
    var accrued: Decimal?
    var rate: Double?
    
    init(time: Int?, principal: Double? , accrued: Decimal?, rate: Double?) {
        self.time = time
        self.principal = principal
        self.accrued = accrued
        self.rate = rate
    }
    
}

