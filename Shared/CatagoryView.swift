//
//  CatagoryView.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-03.
//

import SwiftUI

struct CatagoryView: View {
    @Environment(\.dismiss) var dismiss
    var cheak : Color
    var catag : [catagory] = CatagoryList.catagoryInfo
    @EnvironmentObject var info : Info
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .frame(width:30  , height: 30)
                        .font(.title3)
                    
                        
                }

                Spacer()
                
                Text("Choose a Category")
                    .font(.title3)
                    .offset(x:-10)
                
                Spacer()
                Button {
                    // action
                } label: {
                    Text("")
                        
                }
                

                
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding()
            
            Spacer()
            
            
            List(catag , id: \.id){ item in
                
                HStack{
                    
                    Button {
                        // leaves and updates the category
                        info.catagoryName = item.Name
                        dismiss()
                    } label: {
                        if info.catagoryName == item.Name {
                            
                            HStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(item.color)
                                Text(item.Name)
                                    .font(.title3)
                                
                                if cheak == Color.white {
                                    
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.blue)
                                }
                                else{
                                    
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(cheak)
                                }
                            }
                           
                        }
                        
                        else{
                            
                            HStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(item.color)
                                Text(item.Name)
                                    .font(.title3)
                                
                                
                                
                            }
                            
                        }
                    }

                }
                .frame(height:50)
            }
            .listStyle(.plain)
        }
        .offset(y:-20)

    }
}

struct CatagoryView_Previews: PreviewProvider {
    static var previews: some View {
        CatagoryView(cheak: Color.red)
            .environmentObject(Info())
    }
}
