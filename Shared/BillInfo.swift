//
//  BillInfo.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-05.
//

import SwiftUI

class Info: ObservableObject {
    
    @Published var catagoryName = ""
    @Published var NewImage = "power.circle"
    @Published var intervalName = ""
    @Published var NewintervalName = "1 Day Before"
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var notification = true
    @Published var views = false
    @Published var swit = 0
    @Published var pageColor  = Color(#colorLiteral(red: 0.45328882336616516, green: 0.9041666388511658, blue: 0.24111109972000122, alpha: 1))
    @Published var billName = ""
    @Published var NewCatagoryName = "Utilities"
    @Published var image = ["Netflix2"]
    @Published var name = ["Netflix"]
    @Published var lastPrice = ["10.00"]
    @Published var payDay = ["may 20"]
    @Published var addBill = ["Netflix2","Netflix","10.00","may 20"]
}
