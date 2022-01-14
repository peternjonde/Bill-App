//
//  CatagoryBills.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-03.
//

import SwiftUI

struct catagory: Identifiable  {
    
    let id = UUID()
    let Name : String
    let color : Color
    let image : String
    
}

struct interval: Identifiable {
    
    let id = UUID()
    let inters: String
}



struct CatagoryList{
    
    static let catagoryInfo = [
        
        catagory(Name: "Music", color: .red, image : "headphones.circle"),
        catagory(Name: "Entertainment", color: .orange, image : "play.tv"),
        catagory(Name: "Utilities", color: Color(#colorLiteral(red: 0.38606351613998413, green: 0.9125000238418579, blue: 0.30036455392837524, alpha: 1)), image : "power.circle"),
        catagory(Name: "Food", color: Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)), image : "cart.circle"),
        catagory(Name: "Health", color: .blue, image : "staroflife.circle"),
        catagory(Name: "Productivity", color: .teal, image : "hammer.circle"),
        catagory(Name: "Banking", color: .purple, image : "dollarsign.circle"),
        catagory(Name: "Transport", color: .cyan, image : "car.circle"),
        catagory(Name: "Education", color: .pink, image : "book.circle"),
        catagory(Name: "Insurance", color: .yellow, image : "globe"),
        catagory(Name: "Shopping", color: .mint, image : "hbag.circle")
    ]
}


struct IntervalList{
    
    static let intervalInfo = [
        interval(inters: "1 Day Before"),
        interval(inters: "2 Day Before"),
        interval(inters: "3 Day Before"),
        interval(inters: "4 Day Before"),
        interval(inters: "1 Week Before")
    ]
}


struct Add: Identifiable{
    
    var id = UUID()
    var imageNames = String()
    var serviceName = String()
    var finalPrice = Double()
    var PayDay = String()
    var from = String()
    var color2 : Color
}

class AddService: ObservableObject{
    
    @Published var add = [Add]()
    
}
