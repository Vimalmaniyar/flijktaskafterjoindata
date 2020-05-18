//
//  MyProfileVC.swift
//  AKSwiftSlideMenu
//
//  Created by Sandeep on 4/4/20.
//  Copyright © 2020 Kode. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
   var isValidPhone: Bool {
    let regularExpressionForPhone = "^[+91]+\\d{10}||^\\d{3}+\\d{3}+\\d{4}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    var isValidMobile: Bool {
        let regularExpressionForPhone = "^[+91]+\\d{10}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    var isValidName: Bool{
        let RegEx = "\\w{3,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with:self)
    }
    var isValidOtp: Bool{
        let RegEx = "\\d{6}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with:self)
    }
}
class MyProfileVC:BaseViewController,UITextFieldDelegate{
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var circulerImage: UIImageView!
    
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var otp: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        circulerImage.layer.cornerRadius = circulerImage.frame.size.width/2
        circulerImage.clipsToBounds = true
        errorMessage.isHidden = true
       
        if(emailID != nil)
        {
            email.text = emailID
        }
        else if(mobileid != nil){
            mobile.text = mobileid
        }
        name.text = "vimal"
        email.text = "a@gmail.com"
    }
  
    var verification_id: String? = nil
   
    func validate(){
        if (name.text?.isEmpty == true && email.text?.isEmpty == true && mobile.text?.isEmpty==true) {
            errorMessage.isHidden = false
            errorMessage.text = "Name,email and mobile is Empty"
            name.layer.borderColor = UIColor.red.cgColor
            email.layer.borderColor = UIColor.red.cgColor
            //  DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
            return
            
        }else if (name.text?.isEmpty == true) {
            errorMessage.isHidden = false
            errorMessage.text = "Name is Empty"
            name.layer.borderColor = UIColor.red.cgColor
            //   DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
               return
            
        }
        else if (email.text?.isEmpty == true) {
            errorMessage.isHidden = false
            errorMessage.text = "Email is Empty"
            email.layer.borderColor = UIColor.red.cgColor
            // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
              return
        }
        else if (mobile.text?.isEmpty == true) {
            errorMessage.isHidden = false
            errorMessage.text = "mobile is Empty"
            email.layer.borderColor = UIColor.red.cgColor
            // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
            return
        }
        else if(name.text?.isValidName == false){
            errorMessage.isHidden = false
            errorMessage.text = "Enter valid Name"
            name.layer.borderColor = UIColor.red.cgColor
            //  DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
             return
        }
        else if(email.text?.isValidEmail == false){
            errorMessage.isHidden = false
            errorMessage.text = "Enter valid Email"
            email.layer.borderColor = UIColor.red.cgColor
            // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
             return
        }
        else if (mobile.text?.isValidPhone == false) {
            errorMessage.isHidden = false
            errorMessage.text = "Enter valid Mobile Number"
            email.layer.borderColor = UIColor.red.cgColor
            // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){self.validate()}
            return
        }
        else{
            
            ref.child("users").child(userID!).child("name").setValue(name.text)
            ref.child("users").child(userID!).child("email").setValue(email.text)
            ref.child("users").child(userID!).child("mobile").setValue(mobile.text)
            let alertController = UIAlertController(title: "Updated Sucessfully", message: nil, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Home", style: .default) { (_) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeVC
                self.navigationController?.pushViewController(nextViewController, animated: true)
               }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
           }
    }
    let ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    let emailID = Auth.auth().currentUser?.email
    let mobileid = Auth.auth().currentUser?.phoneNumber
 
    @IBAction func Save(_ sender: UIButton) {
        validate()
       }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        name.layer.borderColor = UIColor.red.cgColor
        email.layer.borderColor = UIColor.red.cgColor
        errorMessage.isHidden = true
    }
    
}
