//
//  Homescreen.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2021-12-29.
//

import SwiftUI

struct Homescreen: View {
    
    var body: some View {
      MoneyView(bill: BillList.icons_info.first!)
    }
}

struct MoneyView: View {
    
    @State var onboardingState : Int = 0
    
    var bill: Bill
    @State var analysis = false
    @State var account = false
    @State var money = 0.0
    @State var newBill = false
    @State var Name = ""
    @EnvironmentObject var info : Info
    @EnvironmentObject var addservice: AddService
    @AppStorage("Notification") var UserNotification: Bool = true
    
    var body: some View {
        
        
            
            ZStack{
                
                Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1))
        
                    
                    // upper part
                
                    VStack{
                        
                        HStack{
                            Text("Bill")
                                .font(.title)
                            Text("Calculator")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            
                            Button {
                                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in

                                            if success{
                                                UserNotification = true
                                                print("All good!")
                                            }
                                            else if let error = error {
                                                print(error.localizedDescription)
                                            }
                                        }
                                    

                                
                            } label: {
                                Image(systemName: "bell.badge.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            

                            
                        }
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .padding()
                        
                        Spacer()
                        
                        Text("$\(money , specifier: "%.2f")")
                            .font(.title)
                            .offset(y:-650)
                            .foregroundColor(.white)
                        Text("Total monthly average")
                            .offset(y:-640)
                            .foregroundColor(Color.white.opacity(0.8))
                            
                       
                    }
                    .edgesIgnoringSafeArea(.top)
                    
                   
                   
                        //white area
                            Spacer()

                
                    VStack(alignment: .center){
                        if addservice.add.isEmpty == true {
                            VStack{
                                Spacer()
                                VStack{
                                    
                                    VStack(alignment: .center)
                                    {
                                        Text("No bills found")
                                            .font(.headline)
                                            .offset(x: 7, y: 200)
                                            
                                        
                                        Text("Press the plus button to add bills ")
                                            .foregroundColor(Color.gray.opacity(0.8))
                                            .offset(x: 7, y: 200)
                                        
                                    }
                                    
                                        HStack(spacing: 40.0){
                                            
                                            Button {
                                                self.analysis.toggle()
                                            } label: {
                                                Image(systemName:"square.fill.on.square.fill")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.gray.opacity(0.5))
                                            }.sheet(isPresented: $analysis) {
                                                AnalysisView()
                                             }
                                            
                                            
                                            Button {
                                                self.newBill.toggle()
                                            } label: {
                                                Image(systemName: "plus.circle.fill")
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .foregroundColor( Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)))
                                                    
                                            }.sheet(isPresented: $newBill) {
                                               Bills_()
                                            }
                                            
                                          
                                            Button {
                                                self.account.toggle()
                                            } label: {

                                                Image(systemName:"person.fill")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.gray.opacity(0.5))

                                            }
                                            .sheet(isPresented: $account) {
                                               AccountView()
                                            }
                                            

                                        }
                                        .offset(x: 7, y: 440)
                                    
                                }
                                
                            }
                            .frame(width: 358, height: 100)
                            .padding(.bottom)
                            .padding(.bottom, 500)
                            .padding()
                            .background(.white)
                            .cornerRadius(30)
                            .offset(y:120)
                            
                        }
                        else{
                                
                                ZStack{
                                    
                                    VStack{
                                        
                                    }
                                    .frame(width: 358, height: 100)
                                    .padding(.bottom)
                                    .padding(.bottom, 500)
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(30)
                                    .offset(y:120)
                                    
                                    Text("Bills & Subscriptions")
                                        .fontWeight(.semibold)
                                        .offset(x: -90, y: -170)
                                    
                                    VStack{
                                        
                                       
                                        
                                        List(self.addservice.add){service in

                                            
                                                
                                                HStack{

                                                    if service.from == "Bills"{
                                                        Image(service.imageNames)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                    }
                                                    else{
                                                        Image(systemName: service.imageNames)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(service.color2)
                                                    }

                                                    VStack(alignment: .leading, spacing: 5.0){

                                                        Text(service.serviceName)
                                                            .fontWeight(.semibold)
                                                            .lineLimit(2)


                                                        Text("$\(service.finalPrice , specifier: "%.2f")")
                                                            .font(.subheadline)
                                                            .foregroundColor(.secondary)


                                                    }

                                                    Spacer()

                                                    Button {
                                                        //something
                                                    } label: {
                                                        Text(service.PayDay)
                                                            .foregroundColor(.white)
                                                            .background(Capsule().foregroundColor(  Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1))).frame(width: 120 , height: 20))
                                                    }


                                                }
                                                .onAppear {
                                                    money += Double(service.finalPrice)
                                                }
                                                
                                            



                                        }
                                        .listStyle(.plain)
                                        
                                        
                                        .offset(y:275)
                                        
                                        HStack(spacing: 40.0){
                                            
                                            Button {
                                                self.analysis.toggle()
                                            } label: {
                                                Image(systemName:"square.fill.on.square.fill")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.gray.opacity(0.5))
                                            }.sheet(isPresented: $analysis) {
                                                AnalysisView()
                                             }
                                            
                                            
                                            Button {
                                           
                                                self.newBill.toggle()
                                            } label: {
                                                Image(systemName: "plus.circle.fill")
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .foregroundColor( Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)))
                                                    
                                            }.sheet(isPresented: $newBill) {
                                               Bills_()
                                            }
                                            
                                            
                                            Button {
                                                self.account.toggle()
                                            } label: {
                                                Image(systemName:"person.fill")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.gray.opacity(0.5))
                                            
                                            }
                                            .sheet(isPresented: $account) {
                                               AccountView()
                                            }
                                            


                                        }
                                        .offset(x: 7, y: -48)
                                        



                                    }
                                
                                    
                                }
                            
                            
                                
                                
                            
                            
                            
                        }
                       
                            

                }
                    
                    
               
                          
                
                        
                        
        

                    
                
            }
            .ignoresSafeArea(.all)
            
        
        
        
       
        
    }
    
   
}


struct Accountview : View{
    
    var body: some View{
        
        AccountView()
    }
}
struct Homescreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen()
            .environmentObject(Info())
            .environmentObject(AddService())
    }
}
