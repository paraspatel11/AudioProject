//
//  LoginViewController.swift
//  AudioProject
//
//  Created by Xcode User on 2019-03-14.
//  Copyright © 2019 Xcode User. All rights reserved.
//  Author: Paras Patel
// Modified By: Anil Anil

import UIKit
import Auth0

class LoginViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(sender:UIButton){
        
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://dev-k6oie8nx.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    print("Credentials: \(credentials)")
                    self.performSegue(withIdentifier: "goToApp", sender: nil)
                }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindToHomeVC(sender : UIStoryboardSegue){
        
        
        
    }

}
