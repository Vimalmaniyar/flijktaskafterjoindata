//
//  phoneViewController.swift
//  Login
//
//  Created by Sandeep on 4/30/20.
//  Copyright © 2020 vimal. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class phoneViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var resend: UIButton!
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var otp: UITextField!
    
    var verification_id: String? = nil
    func err(){
        errorMessage.isHidden = false
        errorMessage.textColor = UIColor.red
        return
    }
    var haserror = false
    func validateotp(){
        if (otp.text?.isEmpty == true) {
            errorMessage.isHidden = false
         //   haserror = true
            err()
            errorMessage.text = "otp is Empty"
            
            // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
            return
        }
        else if(otp.text?.isValidOtp == false){
            errorMessage.isHidden = false
          //  haserror = true
            err()
            errorMessage.text = "Invalid otp"
            
            // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
            return
        }
    }
    func validatephone(){
    
     if(phone.text?.isValidPhone == false){
      errorMessage.isHidden = false
        haserror = true
      errorMessage.text = "Enter valid Phone"
      //  DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
     return
    }
}
   
    @IBAction func submit(_ sender: Any) {
        if (otp.isHidden){
           
            haserror = false
            if (!phone.text!.isEmpty){
               validatephone()
                if (haserror == false){
        //        mobile = phone.text!
               // Auth.auth().settings?.isAppVerificationDisabledFortesting = true
                PhoneAuthProvider.provider().verifyPhoneNumber(phone.text!, uiDelegate: nil, completion: {verificationID,error in
                    if(error != nil){
                        self.err()
                        self.errorMessage.text = "Error in Authentication or Invalid otp"
                        print(error.debugDescription)
                    }
                    else{
                      
                        self.verification_id = verificationID
                        self.otp.isHidden = false
                    }
                })
                }
            }else{
               err()
                errorMessage.text = "PLEASE ENTER YOUR MOBILE NUMBER"
                
            }
            
        }else{
            if verification_id != nil{
                validateotp()
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_id!, verificationCode: otp.text!)
                Auth.auth().signIn(with: credential, completion: {authData,error in
                    if (error != nil)
                    {   self.err()
                       // self.resend.isHidden = false
                        self.errorMessage.text = "Error in Authentication or Invalid otp"
                        print(error.debugDescription)
                    }else{
                       print("AUTHENTICATION SUCCESSFUL WITH" + authData.unsafelyUnwrapped.phoneNumber!)
                        
                        print(authData?.uid)
                        print(authData?.phoneNumber)
                        self.viewWillAppear(true)
                    //  self.performSegue(withIdentifier: "Home", sender: self)
                    }
                    
                })
            }else{
                
                err()
                errorMessage.text = "ERROR IN GETING VERIFICATION ID"
            }
            
        }
        
    
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phone.layer.borderColor = UIColor.red.cgColor
        otp.layer.borderColor = UIColor.red.cgColor
        errorMessage .isHidden = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
          errorMessage .isHidden = true
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        otp.isHidden = true
        errorMessage.isHidden = true
        phone.delegate = self
        otp.delegate = self
       // resend.isHidden = true
        phone.text = "+917878787878"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
