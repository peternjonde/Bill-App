//
//  ContentView.swift
//  Shared
//
//  Created by Peter Njonde on 2021-12-26.
//

import SwiftUI
import Firebase
import FirebaseFirestore

extension View{
    func dissmissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct ContentView: View {
    
    var body: some View {
        Home()
        
    }
}


struct Home: View {
   @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
        NavigationView{
            
            VStack{
                
                if self.status{
                    
                    HomeScreen()
                }
                else{

                    ZStack {
                        
                        NavigationLink(destination: SignUp(show:self.$show),isActive: self.$show) {
                           
                            Text("")
                            
                        }
                        .hidden()
                        
                        
                        Login(show:self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {

                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil , queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
            
           
        }
       
    }
}

struct HomeScreen : View{
    
    var body: some View {
        
        Homescreen()
        
      
    }
}


struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State var color = Color.white
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    @State var Firstname = ""
    var body: some View {
        
        ZStack{
            ZStack{
                LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.4525867998600006, green: 0.7613823413848877, blue: 0.8291666507720947, alpha: 0)), location: 1)]),
                            startPoint: UnitPoint(x: 0.5000000298023228, y: 1.3124511699658115e-8),
                            endPoint: UnitPoint(x: 0.1395701942538844, y: 1.0000000257516954)).ignoresSafeArea()
                
                
                VStack(spacing: 40){
                        Spacer()
                        
                        Image(systemName:"person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 60)
                            .foregroundColor(.white)
                            .font(.system(size: 10,weight: .thin))
                       
                        
                        Text("Log in to your acount")
                            .font(.title)
                            .foregroundColor(Color.white)
                            
                        Spacer()
                    
                    TextField("Email", text: self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.red) : self.color, lineWidth: 2))
                        
                        
                        .shadow(radius: 10 , x: 0, y: 5)
                        .frame(width:358)
                    
                        HStack(spacing: 15){
                            VStack{
                               
                                if self.visible {
                                    TextField("Password", text: self.$password)
                                        .autocapitalization(.none)
                                        
                                       
                                }
                                else{
                                    SecureField("Password", text: self.$password)
                                        .autocapitalization(.none)
                                        
                                }
                            }
                            
                            Button {
                                self.visible.toggle()
                            } label: {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.black.opacity(0.7))
                                    
                            }

                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.red) : self.color, lineWidth: 2))
                        
                        .shadow(radius: 10 , x: 0, y: 5)
                        .frame(width:358)
                        
                        Button {
                            self.verify()
                            
                        } label: {
                            Text("Log In")
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.white).frame(width:UIScreen.main.bounds.width - 50))
                                .shadow(radius: 10 , x: 0, y: 5)
                                
                        }
                    Button {
                        self.reset()
                    } label: {
                        Text("Forgot password")
                            .foregroundColor(Color.black.opacity(0.7))
                            
                    }
                    .offset(x:110)

                    
                        Spacer()
                    Button {
                        self.show.toggle()
                    } label: {
                        Text("Create an acount")
                    }
                    .offset(y:-60)
                    
                }
            }
            .onTapGesture {
                self.dissmissKeyboard()
            }
            
            if self.alert{
                LoginErrors(alert: self.$alert, error: self.$error)
            }
            
        }
    }
    func verify() {
        if self.email != "" && self.password != ""{

            Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, err) in
                
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("Success")
                UserDefaults.standard.set(true, forKey: "status")
                
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else{
            self.error = "Please fill out the spaces proprely"
            self.alert.toggle()
        }
    }
    
   
    
    func reset(){
        
        if self.email != ""{
            
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
        else{
            self.error = "Email section is empty"
            self.alert.toggle()
            
        }
    }
    
}
          

struct SignUp: View {
    @State private var email = ""
    @State private var password = ""
    @State private var Firstname = ""
    @State private var Lastname = ""
    @AppStorage("Firstname") var currentUserFirstName :String?
    @AppStorage("Lastname") var currentUserLastName :String?
    @EnvironmentObject var info : Info
    @State var repassword = ""
    @State var color = Color.white
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    var body: some View {
       
        ZStack{
            ZStack(alignment:.topLeading){
                    LinearGradient(
                                gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 0.23354166746139526, green: 0.8210375905036926, blue: 0.949999988079071, alpha: 1)), location: 0),
                            .init(color: Color(#colorLiteral(red: 0.4525867998600006, green: 0.7613823413848877, blue: 0.8291666507720947, alpha: 0)), location: 1)]),
                                startPoint: UnitPoint(x: 0.5000000298023228, y: 1.3124511699658115e-8),
                                endPoint: UnitPoint(x: 0.1395701942538844, y: 1.0000000257516954)).ignoresSafeArea()
                    
                    
                    GeometryReader{ _ in
                        VStack(spacing: 40){
                                
                                Spacer()
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 60)
                                    .foregroundColor(.white)
                                    .font(.system(size: 10,weight: .thin))
                                    .offset(y:-40)
                                
                                Text("Create Your Account")
                                    .font(.title)
                                    .foregroundColor(Color.white)
                                    .offset(y:-40)
                                    
                                Spacer()
                            
                            TextField("Name", text: self.$Firstname)
                                .autocapitalization(.none)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.Firstname != "" ? Color(.red) : self.color, lineWidth: 2))
                                .shadow(radius: 10 , x: 0, y: 5)
                                .frame(width:358)
                                .offset(y:-80)
                            
                            TextField("Last Name", text: self.$Lastname)
                                .autocapitalization(.none)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.Lastname != "" ? Color(.red) : self.color, lineWidth: 2))
                                .shadow(radius: 10 , x: 0, y: 5)
                                .frame(width:358)
                                .offset(y:-80)
                            
                            
                            TextField("Email", text: self.$email)
                                .autocapitalization(.none)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.red) : self.color, lineWidth: 2))
                                .shadow(radius: 10 , x: 0, y: 5)
                                .frame(width:358)
                                .offset(y:-80)
                            
                                HStack{
                                    Spacer()
                                    VStack{
                                       
                                        if self.visible {
                                            TextField("Password", text: self.$password)
                                                .autocapitalization(.none)
                                                
                                               
                                        }
                                        else{
                                            SecureField("Password", text: self.$password)
                                                .autocapitalization(.none)
                                                
                                        }
                                    }
                                    
                                    
                                    Button {
                                        self.visible.toggle()
                                    } label: {
                                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(.black.opacity(0.7))
                                            
                                    }
                                    

                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.red) : self.color, lineWidth: 2))
                                .shadow(radius: 10 , x: 0, y: 5)
                                .frame(width:358)
                                .offset(y:-80)
                                
                            HStack(spacing: 15){
                                VStack{
                                   
                                    if self.revisible {
                                        TextField("Re-Enter", text: self.$repassword)
                                            .autocapitalization(.none)
                                            
                                           
                                    }
                                    else{
                                        SecureField("Re-Enter", text: self.$repassword)
                                            .autocapitalization(.none)
                                            
                                    }
                                }
                                
                                
                                Button {
                                    self.revisible.toggle()
                                } label: {
                                    Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.black.opacity(0.7))
                                        
                                }

                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.red) : self.color, lineWidth: 2))
                            .shadow(radius: 10 , x: 0, y: 5)
                            .frame(width:358)
                            .offset(y:-80)
                            
                            
                                Button {
                                    self.Register()
                                    currentUserFirstName = Firstname
                                    currentUserLastName = Lastname
                                } label: {
                                    Text("Register")
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.white).frame(width:UIScreen.main.bounds.width - 50))
                                        .shadow(radius: 10 , x: 0, y: 5)
                                        
                                }
                                .offset(y:-80)
                               
                               
                                
                            
                                
                            
                        }
                        Spacer()
                        
                    }
                    .padding(.horizontal, 15)
                    
                    Button {
                        self.show.toggle()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                    }
                    .padding()

                }
            
            if self.alert{
                
                LoginErrors(alert: self.$alert, error: self.$error)
            }
        }
            .offset(y: -60)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                self.dissmissKeyboard()
            }
            
        
    }
    func Register(){
        if self.email != "" && self.Firstname != "" && self.Lastname != ""{
            if self.password == self.repassword{
                Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err) in
                    
                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    print("success")
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                self.error = "Password Mismatch"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Please fill put all the sections properly"
            self.alert.toggle()
        }
        
        let db = Firestore.firestore()
        db.collection("Names").document().setData(["Firstname": Firstname , "LastName": Lastname])
    }
}

struct LoginErrors: View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error: String
    
    var body: some View {
        GeometryReader{_ in
            
            VStack {
                HStack{
                    Text(self.error == "RESET" ? "Message": "Error")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(self.color)
                
                Spacer()
            }
            .padding(.horizontal, 25)
            
                Text(self.error == "RESET" ? "Password reset link has been sent" : self.error)
                .foregroundColor(self.color)
                .padding(.top)
                .padding(.horizontal, 25)
            
            Button {
                self.alert.toggle()
            } label: {
                Text(self.error == "RESET" ? "Ok" : "Cancel")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    
            }
            .background(.teal)
            .cornerRadius(10)
            .padding(.top , 25)
                
            }
            .padding(.vertical , 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
            .offset(x: 33, y: 285)

        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Info())
    }
}
