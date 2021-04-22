//
//  Service.swift
//  RegisterProfile2
//
//  Created by amit sharma on 22/04/21.
//

import UIKit
import Firebase

class Service {
    
    static func signUpUser(email: String, password: String, name: String, gender: String, dob: String, city: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!)

            }
            
            uploToDatabase(email: email, name: name, gender: gender, dob: dob, city: city, onSuccess: onSuccess)
        }
    }
    
    static func uploToDatabase(email: String, name: String, gender: String, dob: String, city: String, onSuccess: @escaping() -> Void){
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).setValue(["email": email, "name": name, "gender": gender, "dob": dob, "city": city])
        onSuccess()
    }
    
    static func getUserInfo(onSuccess: @escaping() -> Void, onError: @escaping(_ error: Error?) -> Void) {
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        guard let uid = Auth.auth().currentUser?.uid else {
            print("user not found")
            return
        }
        
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String :  Any] {
                let email = dictionary["email"] as! String
                let name = dictionary["name"] as! String
                let gender = dictionary["gender"] as! String
                let dob = dictionary["dob"] as! String
                let city = dictionary["city"] as! String
                
                defaults.set(email, forKey: "userEmailKey")
                defaults.set(name, forKey: "userNameKey")
                defaults.set(gender, forKey: "userGenderKey")
                defaults.set(dob, forKey: "userDobKey")
                defaults.set(city, forKey: "userCityKey")
                
                onSuccess()
            }
        }) { (error) in
            onError(error)
        }
}
    static func createAleartController(title: String, message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        return alert
    }
}
