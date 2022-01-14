//
//  AccountView.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2021-12-31.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct AccountView: View {
    let transition : AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    @EnvironmentObject var info : Info
    var body: some View {
       
        MainAcountView()
        
      

    }
    

}
            
        
struct MainAcountView : View {
    @State var notification = true
    @EnvironmentObject var info : Info
    @ObservedObject var name = ViewModel()
    @AppStorage("Firstname") var currentUserFirstName :String?
    @AppStorage("Lastname") var currentUserLastName :String?
    var body : some View {
        
        NavigationView{
            
            ZStack{
                
                Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1))
                
                VStack(spacing: 30){
                    Spacer()
                    Spacer()
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 90)
                    
                    Text("\(currentUserFirstName ?? "Your") \(currentUserLastName ?? "Name")")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack(spacing: 30){
                        
                        NavigationLink {
                            ChnagePassView()
                        } label: {
                            Text("Change passwrod")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)))
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 10 , x: 0, y: 5)
                            
                        }

                        Button{
                            //something
                        } label:{
                            Text("Settings")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)))
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 10 , x: 0, y: 5)
                        }
                        
                        Button{
                            try! Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        } label:{
                            
                            Text("Log Out")
                                .font(.headline)
                                .foregroundColor(Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)))
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 10 , x: 0, y: 5)
                        }
                    }
                    .padding(10)
                        
                    Spacer()
                    Spacer()
                }
        
                
                
            }
            .ignoresSafeArea(.all)
        }
        

        
    }
}

struct ChnagePassView : View {
    @State var email = ""
    @State var alertTitle = ""
    @State var alert = false
    @State var error = ""
    @State var showAlert = false
    @EnvironmentObject var info : Info
    var body : some View {
        
        ZStack{
            
            Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1))
            
            Spacer()
            
            VStack{
                Spacer()
                VStack{
                   

                    Image("bubbles")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    Text("Please enter your email to recive an link to change your password")
                } .frame(width: 350, height: 450)
                    .multilineTextAlignment(.center)
                    .background(Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(20))
                    .onAppear {
                        info.views = true
                    }
                
                Spacer()
                
                VStack(spacing: 40){
                    TextField("Enter Email", text: $email)
                        .offset(x:20)
                        .background(RoundedRectangle(cornerRadius: 20).frame(width: 380, height: 50).foregroundColor(.white))
                    
                    Button {
                        if self.email == ""{
                            ShowAlert(title: "Please Enter your Email ✉️")
                        }
                        else{
                                Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                                    
                                    if err != nil{
                                        
                                        self.error = err!.localizedDescription
                                        self.alert.toggle()
                                        return
                                        
                                    }
                                    
                                    self.error = "RESET"
                                    self.alert.toggle()
                                }
                            
                        }
                    } label: {
                        Text("Done")
                    }

                }
                
                Spacer()
                   
            }
            .onTapGesture {
                self.dissmissKeyboard()
            }
            
            if self.alert{
                LoginErrors(alert: self.$alert, error: self.$error)
            }
            
        }
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(Info())
    }
}
