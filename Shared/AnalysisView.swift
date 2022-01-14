//
//  AnalysisView.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-10.
//

import SwiftUI

struct AnalysisView: View {
    @EnvironmentObject var addservice: AddService
    @State var moneys = 0.0
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1))
            
            if self.addservice.add.isEmpty == true{
                VStack{
                Text("Analytics")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .offset(y:-300)
                Text("No Bills Added")
                        .font(.headline)
                        .foregroundColor(.white)
                Text("Please add bills to see analytics ")
            
                }
                
            }
            else{
                VStack{
                    
                    Text("Analytics")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .offset(y:-200)
                    
                    HStack(spacing: 30){
                        ForEach(self.addservice.add) { item in

                            
                            BarView(value: CGFloat(item.finalPrice * 2) , name: item.imageNames)
                               
                        }
                       
                    }
                    
                   
                }

            }
        }
        .ignoresSafeArea(.all)
        
        
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
            .environmentObject(AddService())
    }
}

struct BarView: View{
    var value : CGFloat = 0
    var name: String = "name"
    var body: some View{
        
        HStack(spacing: 30){

            VStack{

                Text(name)
                ZStack(alignment: .bottom){

                    Capsule().frame(width:30 , height: 200)
                        .foregroundColor(.teal)
                    Capsule().frame(width:30 , height: value)
                        .foregroundColor(.white)
                }



            }
        

        }
    }
    
  
    
}



