//
//  BillsDetails.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-02.
//

import SwiftUI

struct BillsDetails: View {
    @State var Nextbill = Date()
    @Environment(\.dismiss) var dismiss
    @State var setPrice = "0.00"
    @State var set = false
    @State var set2 = false
    @State var set3 = true
   @State var price = ""
    var bill: Bill
    @State private var textFieldId: String = UUID().uuidString
    @EnvironmentObject var addservice: AddService
    @EnvironmentObject var info : Info
    @State var alertTitle = ""
    @State var showAlert = false
    @State var pulse = false
    @State var pulse2 = false
    
    var body: some View {
        
        
       
        ZStack{
            
            
            VStack{
                
                
                HStack {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(bill.SideColor)
                            .frame(width:40  , height: 40)
                    }

                    Spacer()
                    
                    Text(bill.LogoName)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .offset(x:4)
                        .foregroundColor(bill.SideColor)
                    
                    Spacer()
                    Button {
                        if setPrice == "0.00"{
                            
                            ShowAlert(title: "Please enter the cost of your \(bill.LogoName) bill 👍🏾")
                            
                        }
                        else{
                            let center = UNUserNotificationCenter.current()
                            let setPriceInt = (setPrice as NSString).integerValue
                            addservice.add.append(Add(imageNames: bill.ImageName, serviceName: bill.LogoName, finalPrice: Double(setPriceInt), PayDay: Nextbill.formatted(date: .abbreviated, time: .omitted), from: "Bills" , color2: bill.MainColor ))
                            info.swit = 1
                            
                            let content = UNMutableNotificationContent()
                               content.title = ("\(bill.LogoName) Bill")
                               content.subtitle = ("Your next bill is the \(Nextbill.formatted(date: .abbreviated, time: .omitted))")
                               content.sound = UNNotificationSound.default
                               
                               
                               let dateComponates =  Calendar.current.dateComponents([.day], from: Nextbill)
                               
                               
                                                                    
                               let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponates, repeats: false)
                               
                               let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            center.add(request)
                            dismiss()
                        }
                        
                     
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(bill.MainColor)
                            .background(RoundedRectangle(cornerRadius: 4).foregroundColor(bill.SideColor).frame(width: 60, height: 20))
                            
                        
                    }
                    

                    
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                
                Spacer()
                
                
                
                
            }
            
            VStack{
                
                Image(bill.SecondImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
            

                
            
                
                  
                ZStack{
                    HStack{
                        
                            
                        if bill.MainColor == Color.black {
                            
                            if set3{
                                
                                TextField("$\(setPrice)", text: $price)
                                    .keyboardType(.decimalPad)
                                    .font(.title)
                                    .offset(x:140)
                                    .colorInvert()
                                    .colorMultiply(.white)
                                    .padding()
                                    .id(textFieldId)
                                .onTapGesture {
                                    withAnimation (Animation.easeInOut(duration: 0.6)) {
                                        self.set.toggle()
                                    }
                                }
                            }
                        }
                        else{
                            if set3{
                                
                                TextField("$\(setPrice)", text: $price)
                                    .keyboardType(.decimalPad)
                                    .font(.title)
                                    .offset(x:140)
                                    .colorInvert()
                                    .colorMultiply(Color.black)
                                    .padding()
                                    .id(textFieldId)
                                .onTapGesture {
                                    withAnimation (Animation.easeInOut(duration: 0.6)) {
                                        self.set.toggle()
                                    }
                                }
                            }
                        }
                        
                        if set{
                            
                                Button {
                                    setPrice = price
                                    self.set2.toggle()
                                    self.set3.toggle()
                                    self.set.toggle()
                                    textFieldId = UUID().uuidString
                                   
                                    
                                } label: {
                                    Text("Done")
                                        .background(Capsule(style: .circular).stroke(bill.SideColor, lineWidth: 2).frame(width: 60 , height: 30))
                                        .foregroundColor(bill.SideColor)
                                        
                                }
                                .offset(x:-28)
                            
                        }

                    }
                    
                    if set2{
                        Button {
                            price = ""
                            self.set3.toggle()
                            self.set2.toggle()
                        } label: {
                            Text("$\(setPrice)")
                                .padding()
                                .font(.title)
                                .foregroundColor(bill.SideColor)
                        }

      
                    }
                    
                }
                   
                   
                
                HStack{
                    
                    Text("Name")
                        .foregroundColor(bill.SideColor)
                    
                    Spacer()
                    
                    Text(bill.LogoName)
                        .foregroundColor(bill.SideColor)
                }
                Divider()
                .background(Color.white)
                .font(.title)
                HStack{
                    
                    Text("Catagory")
                        .foregroundColor(bill.SideColor)
                    
                    Spacer()
                    
                    Button {
                        self.pulse.toggle()
                        if info.catagoryName == ""{
                        info.catagoryName = bill.Catagory
                        }
                    } label: {
                        if info.catagoryName == ""{
                            
                            Text(bill.Catagory)
                                .foregroundColor(bill.SideColor)
                        }
                        else{
                            
                            Text(info.catagoryName)
                                .foregroundColor(bill.SideColor)
                        }
                       
            
                        
                    }
                    .sheet(isPresented: $pulse) {
                        CatagoryView(cheak: bill.SideColor)
                    }

                }
                Divider().background(Color.white)
                // do reminder button
                HStack{
                    
                    Text("Reminder")
                        .foregroundColor(bill.SideColor)
                    
                    Spacer()
                    
                    Button {
                        self.pulse2.toggle()
                        if info.intervalName == ""{
                        info.intervalName = bill.int
                        }
                    } label: {
                        if info.intervalName == ""{
                            
                            Text(bill.int)
                                .foregroundColor(bill.SideColor)
                        }
                        else{
                            
                            Text(info.intervalName)
                                .foregroundColor(bill.SideColor)
                        }
                    }
                    .sheet(isPresented: $pulse2) {
                        IntervalView(cheak: bill.SideColor)
                    }

                }
                Divider().background(Color.white)
                // fix the date button later
                HStack{
                    
                    DatePicker("Next Bill", selection: $Nextbill, in: Date()... , displayedComponents: .date)
                        .colorInvert()
                        .colorMultiply(bill.SideColor)
                               
                        
                        
                        
                }
                
                
                
                
                
            }
            .offset(y:-90)
          
            
            
            
           
        }
        .background(bill.MainColor)
        .ignoresSafeArea(.all)
        .alert(isPresented: $showAlert, content:{
            
            return Alert(title: Text(alertTitle))
        })
        
       
        
           
        
        
    }
    func ShowAlert(title: String){
        alertTitle = title
        showAlert.toggle()
    }
}




struct BillsDetails_Previews: PreviewProvider {
    static var previews: some View {
        BillsDetails(bill: BillList.icons_info.first!)
            .environmentObject(Info())
            .environmentObject(AddService())
    }
}


