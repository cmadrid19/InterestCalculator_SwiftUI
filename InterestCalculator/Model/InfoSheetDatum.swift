//
//  InfoSheetDatum.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 11/3/21.
//

import SwiftUI

struct SheetData {
    var definition: String
    var legends: [String]
    var notes: [String]
}

let simlpeInfoSheet: SheetData = SheetData(definition: "Use this simple interest calculator to find A, the Final Investment Value, using the simple interest formula: Co = Cn(1 + rt) where Co is the Principal amount of money to be invested at an Interest Rate R% per period for t Number of Time Periods.  Where r is in decimal form; r=R/100; r and t are in the same units of time.",
                                      legends: [
                                        "Cn = Total Accrued Amount (principal + interest)",
                                        "Co = Principal Amount",
                                        "I = Interest Amount",
                                        "r = Rate of Interest per year in decimal; r = R/100",
                                        "t = Time Period involved in months or years"],
                                      notes: [
                                        "1. Note that rate r and time t should be in the same time units such as months or years. ",
                                        "2. Time conversions that are based on day count of 365 days/year have 30.4167 days/month and 91.2501 days/quarter. 360 days/year have 30 days/month and 90 days/quarter."
                                      ])

var periodicCompoundInfoSheet: SheetData = SheetData(definition: "Using the compound interest formula, calculate principal plus interest or principal or rate or periods (time). Periods are any time units you want as long as you are consistent using the same base time units for periods and interest rate. Periods can be in days, months, quarters, years, etc.",
                                            legends: [
                                                "A = Accrued Amount (principal + interest)",
                                                "A = P + I",
                                                "P = Principal Amount",
                                                "I = Interest Amount",
                                                "R = Rate of Interest per period in percent",
                                                "r = Rate of Interest per period as a decimal",
                                                "t = Number of Periods"
                                            ],
                                            notes: [
                                               ""
                                                
                                            ])

var rentInfoSheet: SheetData = SheetData(definition: "What do Payroll, mortgages and mutual funds have in common? They are rents. What will we do with the rents? We will be interested in comparing them, for this we will calculate their present value (PV) and their future value (FV)",
                                         legends: [
                                            "CV: value of an expected income stream determined as of the date of valuation",
                                            "FV: The future value is the value of a given amount of money at a certain point in the future if it earns a rate of interest.",
                                            "R = Rate of Interest per period in percent",
                                            "r = Rate of Interest per period as a decimal",
                                            "t = Number of Periods",
                                            "deferred = put a payment to a later time"
                                         ],
                                         notes: [
                                            "We will use the compound discount or compound capitalization law.",
                                            "Payments allways rule, not the rate. Dempending on the payments, the rate is changed.",
                                            "FV is not influenced by the deferral.",
//                                            "PV is no influenced by the promptness",
                                            "Early loan only makes sense in the final value.",
                                            "In a final value there is no deferral."
                                            
                                         ])
