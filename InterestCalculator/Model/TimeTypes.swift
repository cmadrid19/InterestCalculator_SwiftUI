//
//  TimeTypes.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 9/3/21.
//

import SwiftUI

enum TimeTypes: String, Equatable, CaseIterable{
    case threeHundrednSixty = "days 360/yr"
    case threeHundrednSixtyFive = "days 365/yr"
    case weaks = "weaks"
    case months = "months"
    case quarters = "quarters"
    case years = "years"
}

class MyTime {
    var years: Double
    
    init(years: Double) {
        self.years = years
    }
    
    private var quarters: Double {
        return self.years.truncatingRemainder(dividingBy: 1) * 4
    }
    
    private var months: Double {
        return self.quarters.truncatingRemainder(dividingBy: 1) * 3
    }
    
    private var weeks: Double{
        return self.months.truncatingRemainder(dividingBy: 1) * 4
    }
    
    private var days: Double{
        return self.weeks.truncatingRemainder(dividingBy: 1) * 7
    }
    
    private var hours: Double{
        return self.weeks.truncatingRemainder(dividingBy: 1) * 24
    }
    
    private var yearsString: String{
        return (self.years == Double.zero ? "something went wrong" : (String(format: "%.0f", self.years) + "years"))
    }
    
    private var monthsString: String{
        return (self.months == Double.zero ? "" : (String(format: "%.0f", self.months) + " months"))
    }
    
    private var daysString: String{
        return (self.days == Double.zero ? "" : (String(format: "%.0f", self.days) + " days"))
    }
    
    private var hrsString: String{
        return (self.hours == Double.zero ? "" : (String(format: "%.0f", self.hours) + " hrs"))
    }
    
    func showTimeString() -> String{
        return "\(yearsString)\(monthsString)\(daysString)\(hrsString)"
    }
}
