//
//  loginVC.swift
//  Flik Task
//
//  Created by Sandeep on 4/25/20.
//  Copyright © 2020 vimal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

//import GoogleSignIn
class loginVC: UIViewController {
    var logflag = false
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
        if error != nil{
            return
        }
       /* else{
          if let user = user {
           
            let uid = user.uid
            let email = user.email
            let name = user.displayName
            print(uid  +  name!)
            print(email)
            }*/
       
            
        
            performSegue(withIdentifier: "login", sender: self)
        
        
    }
    func users(){
        let users = Auth.auth().currentUser
        print(users?.uid)
    }
    @IBAction func emailclick(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else{
            return
        }
        authUI?.delegate = self as? FUIAuthDelegate
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        users()
        if(Auth.auth().currentUser != nil){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! MyProfileVC
                self.navigationController?.pushViewController(nextViewController, animated: true)}
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
