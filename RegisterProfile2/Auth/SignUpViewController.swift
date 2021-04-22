//
//  SignUpViewController.swift
//  RegisterProfile2
//
//  Created by amit sharma on 21/04/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton_Tapped(_ sender: Any) {
        Service.signUpUser(email: emailField.text!, password: passwordField.text!, name: nameField.text!, gender: genderField.text!, dob: dobField.text!, city: cityField.text!, onSuccess: {
            
            self.performSegue(withIdentifier: "userSignedUpSegue", sender: nil)
        }){ (error) in
        self.present(Service.createAleartController(title: "Error", message: error!.localizedDescription), animated: true , completion: nil)

        }
}
}
