//
//  LoginViewController.swift
//  We Care
//
//  Created by Abhigyan Singh on 29/02/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var passTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    
    @IBAction func loginBTN(sender: AnyObject) {
        
        Config.firebase.authUser(emailTF.text, password: passTF.text) {
            error, authData in
            if error != nil {
                print("Error : \(error)")
            } else {
                print("Success")
                var usersRef = Config.firebase.childByAppendingPath("userType/" + authData.uid)
                usersRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    if snapshot.value is NSNull {
                        print("Error")
                    }
                    else {
                        var category = snapshot.value["category"] as! String
                        if(category == "patient"){
                            let storyboard = UIStoryboard(name: "PatientHome", bundle: nil)
                            let vc = storyboard.instantiateViewControllerWithIdentifier("PatientHomeViewController") as UIViewController
                            self.presentViewController(vc, animated: true, completion: nil)
                        }
                        else if(category == "doctor"){
                            print("Doctor")
                        }
                        else if(category == "pharma"){
                            print("Pharma")
                        }
                    }
                })
            
                
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
