//
//  NewCatagoryView.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-09.
//

import SwiftUI

struct NewCatagoryView: View {
    
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
                        info.NewImage = item.image
                        info.pageColor = item.color
                        info.NewCatagoryName = item.Name
                        dismiss()
                    } label: {
                        if info.NewCatagoryName == item.Name {
                            
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

struct NewCatagoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCatagoryView(cheak: Color(#colorLiteral(red: 0.45328882336616516, green: 0.9041666388511658, blue: 0.24111109972000122, alpha: 1)))
            .environmentObject(Info())
    }
}
