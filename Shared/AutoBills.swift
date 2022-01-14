//
//  AutoBills.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-01.
//

import SwiftUI

struct Bill: Identifiable  {
    
    let id = UUID()
    let ImageName : String
    let LogoName : String
    var Catagory : String
    let MainColor : Color
    let SideColor : Color
    let SecondImageName : String
    let int : String
    
}

struct BillList {
    
    static let icons_info = [
        
        Bill(ImageName: "Netflix2", LogoName: "Netflix", Catagory: "Entertainment" , MainColor: .black, SideColor: .red , SecondImageName: "Netflix3", int: "1 Day Before"),
       
        Bill(ImageName: "SnapChat", LogoName: "Snapchat", Catagory: "Entertainment", MainColor: .yellow, SideColor: .white, SecondImageName: "SnapChat2", int: "1 Day Before"),
        
        Bill(ImageName: "Cash-App", LogoName: "CashApp", Catagory: "Banking", MainColor: Color(#colorLiteral(red: 0.38606351613998413, green: 0.9125000238418579, blue: 0.30036455392837524, alpha: 1)), SideColor: .white, SecondImageName: "Cash-App2", int: "1 Day Before"),
        
        Bill(ImageName: "Wish", LogoName: "Wish", Catagory: "Shopping", MainColor: Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)), SideColor: .white, SecondImageName: "Wish", int: "1 Day Before"),
        
        Bill(ImageName: "Mcdonalds", LogoName: "McDonalds", Catagory: "Food", MainColor: .red, SideColor: .yellow, SecondImageName: "Mcdonalds", int: "1 Day Before"),
        
        Bill(ImageName: "Twitch", LogoName: "Twitch", Catagory: "Entertainment", MainColor: Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)), SideColor: .white, SecondImageName: "Twitch", int: "1 Day Before"),
        
        Bill(ImageName: "Apple-Tv", LogoName: "Apple Tv", Catagory: "Entertainment", MainColor: .white, SideColor: .purple, SecondImageName: "Apple-Tv2", int: "1 Day Before"),
        
        Bill(ImageName: "Amazon", LogoName: "Amazon Prime", Catagory: "Shopping", MainColor: .white, SideColor: .black, SecondImageName: "Amason2", int: "1 Day Before"),
        
        Bill(ImageName: "Adobe", LogoName: "Adobe Ilustration", Catagory: "Utilities", MainColor: .pink, SideColor: .white, SecondImageName: "Adobe", int: "1 Day Before"),
        
        Bill(ImageName: "Adobe-Scan", LogoName: "Adobe Scan", Catagory: "Utilities", MainColor: .teal, SideColor: .white, SecondImageName: "Adobe-Scan", int: "1 Day Before"),
        
        Bill(ImageName: "spotify", LogoName: "Spotify", Catagory: "Music", MainColor: .white, SideColor: .green, SecondImageName: "spotify", int: "1 Day Before"),
        
        Bill(ImageName: "Uber", LogoName: "Uber", Catagory: "Transport", MainColor: .black, SideColor: .white, SecondImageName: "Uber", int: "1 Day Before"),
        
        Bill(ImageName: "UberEats", LogoName: "UberEats", Catagory: "Food", MainColor: .black, SideColor: .white, SecondImageName: "UberEats", int: "1 Day Before")
        
        
    ]
}


