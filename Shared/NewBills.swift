//
//  NewBills.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-08.
//

import SwiftUI

struct NewBills: View {
    @EnvironmentObject var addservice: AddService
    @State var peace = false
    @State var peace2 = false
    @State var Nextbill = Date()
    @EnvironmentObject var info : Info
    @Environment(\.dismiss) var dismiss
    @State var setPrice = "0.00"
    @State var price = ""
    @State var set = false
    @State var set2 = false
    @State var set3 = true
    @State private var textFieldId: String = UUID().uuidString
    @State var alertTitle = ""
    @State var showAlert = false
    
    
    var body: some View {
        ZStack{
            
            
            VStack{
                
                HStack{
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width:40  , height: 40)
                           
                    }
                    Spacer()
                    
                    if info.billName == ""{
            
                        Text("Bill Name")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    else{
                        
                        Text(info.billName)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    
                    Spacer()
                    Button {
                        
                    
                        if info.billName == ""{
                            
                            info.billName = "Bill Name"
                        }
                        if setPrice == "0.00"{
                            
                            ShowAlert(title: "Please enter the cost for this bill 👍🏾")
                        }
                        else{
                            let setPriceInt = (setPrice as NSString).integerValue
                            addservice.add.append(Add(imageNames: info.NewImage, serviceName: info.billName, finalPrice: Double(setPriceInt), PayDay: Nextbill.formatted(date: .abbreviated, time: .omitted), from: "NewBills" , color2: info.pageColor))
                            
                            let center = UNUserNotificationCenter.current()
                            let content = UNMutableNotificationContent()
                            content.title = ("\(info.billName) Bill")
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
                            .background(Capsule().foregroundColor(.white).frame(width: 60, height: 20))
                    }
                    .offset(x:-20)


                }
                .offset(y:60)
                
                Spacer()
                
                VStack(spacing: 30){
                    
                    Image(systemName: info.NewImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                        .foregroundColor(.white)
                        .offset(y:30)
                    
                    ZStack{
                        
                        HStack{
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
                            
                            if set{
                                
                                    Button {
                                        setPrice = price
                                        self.set2.toggle()
                                        self.set3.toggle()
                                        self.set.toggle()
                                        textFieldId = UUID().uuidString
                                       
                                        
                                    } label: {
                                        Text("Done")
                                            .background(Capsule(style: .circular).stroke(.white, lineWidth: 2).frame(width: 60 , height: 30))
                                            .foregroundColor(.white)
                                            
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
                                    .foregroundColor(.white)
                            }

          
                        }
                    }
                }
                .offset(y:-360)
                
                
                VStack{
                    
                    HStack{
                        
                        Text("Name")
                        
                        Spacer()
                        
                        TextField("Bill Name", text: $info.billName)
                            .offset(x:260)
                            
                    }
                    .foregroundColor(.white)
                    
                    Divider()
                        .background(Color.white)
                    
                    HStack{
                        
                        Text("Catagory")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            self.peace.toggle()
                        } label: {
                            Text(info.NewCatagoryName)
                                .foregroundColor(.secondary)
                        }
                        .sheet(isPresented: $peace) {
                            NewCatagoryView(cheak: info.pageColor)
                        }

                    }
                   
                    
                    Divider()
                        .background(Color.white)
                    
                    HStack{
                        
                        Text("Reminder")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            self.peace2.toggle()
                        } label: {
                            Text(info.NewintervalName)
                                .foregroundColor(.secondary)
                        }
                        .sheet(isPresented: $peace2) {
                            NewIntervalView(cheak: info.pageColor)
                        }

                    }
                    
                    
                    Divider()
                        .background(Color.white)
                    
                    HStack{
                        
                        DatePicker("Next Bill", selection: $Nextbill, in: Date()... , displayedComponents: .date)
                    }
                    .foregroundColor(.white)
                    
                }
                .offset(y:-340)
            }
            
            
        }
        .background(info.pageColor)
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

struct NewBills_Previews: PreviewProvider {
    static var previews: some View {
        NewBills()
            .environmentObject(Info())
            .environmentObject(AddService())
    }
}
