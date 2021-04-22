//
//  HomeViewController.swift
//  RegisterProfile2
//
//  Created by amit sharma on 21/04/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeInLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard

        Service.getUserInfo(onSuccess: { [self] in
            self.welcomeInLabel.text = "Welcome in : \(defaults.string(forKey: "userNameKey")!)"
            self.emailLabel.text = "Email id : \(defaults.string(forKey: "userEmailKey")!)"
            self.genderLabel.text = "Gender : \(defaults.string(forKey: "userGenderKey")!)"
            self.dobLabel.text = "Date of Birth : \(defaults.string(forKey: "userDobKey")!)"
            self.cityLabel.text = "City : \(defaults.string(forKey: "userCityKey")!)"
            
            
        }) { (error) in
            self.present(Service.createAleartController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }

    }
    @IBAction func logOutButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError {
            self.present(Service.createAleartController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
        }
        
    }
    
}
