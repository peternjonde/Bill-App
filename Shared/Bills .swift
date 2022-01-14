//
//  Bills .swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-01.
//

import SwiftUI

struct Bills_: View {
    
    var bills : [Bill] = BillList.icons_info
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var info : Info
    
    @State var cheak = false
    @State var cheak2 = false
    
    var body: some View {
       
        
            
                VStack{
                   
                    HStack{

                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .frame(width:30  , height: 30)
                        }



                        Spacer()

                        Text("Choose a service")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .offset(x:14)

                        Spacer()
                        Button {
                            self.cheak2.toggle()
                        } label: {
                            Text("New Bill")
                                .foregroundColor(.white)
                                .background(Capsule().foregroundColor(Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1))).frame(width: 70, height: 20))
                                .offset(x:-20)

                        }
                        .sheet(isPresented: $cheak2) {
                            NewBills()
                        }



                    }
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding()
                    .offset(y:-30)

                    
                        
                    List{
                        ForEach(bills , id: \.id){ item in
                        
                            Button {
                                
                                self.cheak.toggle()
                            } label: {
                                HStack{
                                         
                                            Image(item.ImageName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 70, height: 70)
                                        
                                            VStack(alignment: .leading, spacing: 5.0){
                                        
                                                Text(item.LogoName)
                                                    .fontWeight(.semibold)
                                                    .lineLimit(2)
                                        
                                        
                                                Text(item.Catagory)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
            
                                        }
                                
                                .onAppear{
                                    
                                    info.intervalName = ""
                                    info.catagoryName = ""
                                
                                
                                }
                            }
                            .sheet(isPresented: $cheak) {
                                BillsDetails(bill: item)
                            }

                            

                                    
                                
                            }
                    }
                    .listStyle(.plain)
                    
                    
                    Spacer()
                    Spacer()

                }
                .offset(y:20)
            
    
            
        
        
       
            
    }
    
        
    }


struct Bills__Previews: PreviewProvider {
    static var previews: some View {
        Bills_()
            .environmentObject(Info())
    }
}

