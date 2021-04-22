//
//  SignInViewController.swift
//  RegisterProfile2
//
//  Created by amit sharma on 21/04/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
   
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    @IBAction func signInButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        let defaults = UserDefaults.standard
        
        auth.signIn(withEmail: emailField.text!, password: passwordField.text!) { (authResult, error) in
            if error != nil {
                self.present(Service.createAleartController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
                return
            }
            
            defaults.set(true, forKey: "isUserSignedIn")
            self.performSegue(withIdentifier: "userSignedInSegue", sender: nil)
        }
        
      
    }
    
    
}
