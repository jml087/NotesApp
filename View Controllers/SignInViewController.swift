//
//  SignInViewController.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/18/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signIn: UIButton!
    var validLogin: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signIn.titleLabel?.textColor = MyColors.xLightColor
    
        //background colors
        self.view.backgroundColor = MyColors.lightColor
        signIn.backgroundColor = MyColors.mediumColor
        userNameField.backgroundColor = UIColor.clear
        passwordField.backgroundColor = UIColor.clear
        
        let userBorder = UIView(frame: CGRect(x: 60, y: 202, width: 255, height: 10))
        let passwordBorder = UIView(frame: CGRect(x: 60, y: 293, width: 255, height: 10))
        userBorder.backgroundColor = MyColors.darkColor
        passwordBorder.backgroundColor = MyColors.darkColor
        userBorder.layer.borderColor = UIColor.clear.cgColor
        passwordBorder.layer.borderColor = UIColor.clear.cgColor

        
        signIn.layer.cornerRadius = 25
        signIn.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signIn.center.x = self.view.center.x
        signIn.center.y = self.view.center.y + 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.validLogin
    }

}
//IB-Actions
extension SignInViewController {
    
    @IBAction func signIn(_ sender: Any) {
        handleSignIn()
    }
}
//Action Handlers
extension SignInViewController {
    
    func handleSignIn() {
        guard let username = userNameField.text else {return}
        guard let password = passwordField.text else {return}
        
        Auth.auth().signIn(withEmail: username, password: password) {user, error in
            if error == nil && user != nil {
                print("Signed in!")
                self.validLogin = true
                self.performSegue(withIdentifier: "signin", sender: Any?.self)

            } else {
                let alert = UIAlertController(title: "Error!", message: "\(error!.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.validLogin = false
                
            }
        }
    }
}
