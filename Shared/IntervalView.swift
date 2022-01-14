//
//  IntervalView.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-06.
//

import SwiftUI

struct IntervalView: View {
    @Environment(\.dismiss) var dismiss
    var inter: [interval] = IntervalList.intervalInfo
    var cheak : Color
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
                
                Text("Choose Interval")
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
            
            List(inter , id: \.id){ item in
                
                HStack{
                    Button {
                        info.intervalName = item.inters
                        dismiss()
                    } label: {
                        if info.intervalName == item.inters {
                            
                            HStack{
                                
                                Image(systemName: "bell")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                                
                                Text(item.inters)
                                    .fontWeight(.semibold)
                                
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
                                
                                Image(systemName: "bell")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                                
                                Text(item.inters)
                                    .fontWeight(.semibold)
                                
                                
                            }
                        }
                    }

                }
                .frame(height: 50)
                
            }
            .listStyle(.plain)
        }
        .offset(y:-50)
    }
}

struct IntervalView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalView(cheak: Color.red)
            .environmentObject(Info())
    }
}
