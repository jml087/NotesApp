//
//  SignUpViewController.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/18/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet var userNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signUp: UIButton!
    var validSignUp: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MyColors.lightColor
        signUp.backgroundColor = MyColors.mediumColor
        userNameField.backgroundColor = UIColor.clear
        emailField.backgroundColor = UIColor.clear
        passwordField.backgroundColor = UIColor.clear
        
        let userBorder = UIView(frame: CGRect(x: 60, y: 191, width: 255, height: 2))
        let emailBorder = UIView(frame: CGRect(x: 60, y: 282, width: 255, height: 2))
        let passwordBorder = UIView(frame: CGRect(x: 60, y: 373, width: 255, height: 2))
        userBorder.backgroundColor = MyColors.darkColor
        emailBorder.backgroundColor = MyColors.darkColor
        passwordBorder.backgroundColor = MyColors.darkColor
        
        userBorder.layer.borderColor = UIColor.clear.cgColor
        emailBorder.layer.borderColor = UIColor.clear.cgColor
        passwordBorder.layer.borderColor = UIColor.clear.cgColor

        signUp.layer.cornerRadius = 25
        signUp.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signUp.center.x = self.view.center.x
        signUp.center.y = self.view.center.y + 120
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.validSignUp
    }
    
}
//IB-Actions
extension SignUpViewController {
    
    @IBAction func signUp(_ sender: Any) {
        handleSignUp()
    }
}


// Function handlers
extension SignUpViewController {
    func handleSignUp() {
        print("handlingSignUP")
        guard let username = userNameField.text else {return}
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        
        
        Auth.auth().createUser(withEmail: email, password: password) {user, error in
            if error == nil && user != nil {
                print("User created!")
            
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error == nil {
                       print("User display name changed!")
                    }
                }
                
                let ref = Database.database().reference()
                let uid = Auth.auth().currentUser?.uid
                ref.child("\(uid!)").setValue("")
                print(uid)
            
                self.validSignUp = true
                
            } else {
                let alert = UIAlertController(title: "Error!", message: "\(error!.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.validSignUp = false
            }
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


