//
//  GetNames.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2022-01-01.
//

import Foundation
import Firebase
import FirebaseFirestore

class ViewModel: ObservableObject{
    
    @Published var list = [Name]()
    
    func getData(){
        
        let db = Firestore.firestore()
        
        db.collection("Names").getDocuments { (snap, err) in
            
            if err != nil {
                
                // fix error
            }
            
            DispatchQueue.main.async {
                self.list = snap!.documents.map({ i in
                    
                    return Name(id: i.documentID, First: i["Firstname"] as? String ?? "po", Last: i["Lastname"] as? String ?? "")
                })
            }
            
            
        }
    }
}

