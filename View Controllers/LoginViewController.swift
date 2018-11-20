//
//  LoginViewController.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/16/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import UIKit

struct MyColors {
    static var darkColor = UIColor(displayP3Red: 0.13, green: 0.42, blue: 0.36, alpha: 1.0)
    static var mediumColor = UIColor(displayP3Red: 0.98, green: 0.72, blue: 0.64, alpha: 1.0)
    static var lightColor = UIColor(displayP3Red: 0.97, green: 0.94, blue: 0.92, alpha: 1.0)
    static var xLightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

class LoginViewController: UIViewController {
    
    @IBOutlet var logo: UILabel!
    @IBOutlet var signIn: UIButton!
    @IBOutlet var signUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //text colors
        logo.textColor = MyColors.darkColor
        signIn.titleLabel?.textColor = MyColors.xLightColor
        signUp.titleLabel?.textColor = MyColors.xLightColor
        
        
        //background colors
        self.view.backgroundColor = MyColors.lightColor
        signIn.backgroundColor = MyColors.mediumColor
        signUp.backgroundColor = MyColors.mediumColor
        
        //frame set up
        signIn.layer.cornerRadius = 25
        signUp.layer.cornerRadius = 25
        signIn.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signUp.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signIn.center.x = self.view.center.x
        signUp.center.x = signIn.center.x
        signIn.center.y = self.view.center.y + 100
        signUp.center.y = signIn.center.y + 100
        logo.center.x = self.view.center.x
        

        
        //make navigation bar clear colored
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// IB-Actions
extension LoginViewController {
    @IBAction func logOut(_ segue: UIStoryboardSegue) {
        
    }
}
