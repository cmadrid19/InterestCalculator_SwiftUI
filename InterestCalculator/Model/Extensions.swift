//
//  Extensions.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 9/3/21.
//

import SwiftUI

extension Double{
    var intoLocaleCurrency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = false
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}

//to dismiss keyboard
extension UIApplication {
    func hideKeyboard(){
        sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

////Measurement for time
//extension Double {
//    var hours: Measurement<UnitDuration>{
//        return Measurement(value: self, unit: UnitDuration.hours)
//    }
//    var minutes: Measurement<UnitDuration>{
//        return Measurement(value: self, unit: UnitDuration.minutes)
//    }
//    var seconds: Measurement<UnitDuration>{
//        return Measurement(value: self, unit: UnitDuration.seconds)
//    }
//}
//
//
