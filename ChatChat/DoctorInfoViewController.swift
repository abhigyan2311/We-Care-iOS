//
//  DoctorInfoViewController.swift
//  We Care
//
//  Created by Abhigyan Singh on 02/03/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Firebase

class DoctorInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var infopickerTF: UITextField!
    @IBOutlet var qualificationTF: UITextField!
    @IBOutlet var workExTF: UITextField!
    
    let PracticeOptions = ["General Medicine","Anaesthesiologist","General Surgery","Paediatrics","Obstetrics - Gynecology","Neurology","Dermatology","Ophthalmology","ENT / Ear Nose Throat Specialist","Psychiatry","Pathology","Venereology","Physiology","Anatomy","Plastic Surgery","Nephrology","Urology","Endocrinology","Hematology"]
    var pickerOptions = []
    
    var uid = ""
    
    
    @IBAction func signUpBTN(sender: AnyObject) {
        
        let qualifications = qualificationTF.text
        let workEx = workExTF.text
        let practice = infopickerTF.text
        
        Config.firebase.createUser(Config.email, password: Config.password,
            withValueCompletionBlock: { error, result in
                
                if error != nil {
                    print("Error :  \(error)")
                } else {
                    self.uid = (result["uid"] as? String)!
                    print("Successfully created user account with uid: \(self.uid)")
                    
                    let newDoctor = [
                        "email" : Config.email as String,
                        "firstName" : Config.fname as String,
                        "lastName" : Config.lname as String,
                        "mobile" : Config.mobile as String,
                        "gender" : Config.gender as String,
                        "dob" : Config.dob as String,
                        "qualifications" : qualifications! as String,
                        "workex" : workEx! as String,
                        "practice" : practice! as String
                    ];
                    
                    Config.firebase.childByAppendingPath("users/doctors/\(self.uid)").setValue(newDoctor, withCompletionBlock: {
                        (error:NSError?, ref:Firebase!) in
                        if (error != nil) {
                            print("Data could not be saved.")
                        } else {
                            print("Data saved successfully!")
                        }
                    })
                    
                    let userType = ["category" : "doctor"]
                    Config.firebase.childByAppendingPath("userType/\(self.uid)").setValue(userType, withCompletionBlock: {
                        (error:NSError?, ref:Firebase!) in
                        if (error != nil) {
                            print("Data could not be saved.")
                        } else {
                            print("Data saved successfully!")
                        }
                    })
                    let storyboard = UIStoryboard(name: "DoctorHome", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("DoctorHomeViewController") as UIViewController
                    self.presentViewController(vc, animated: true, completion: nil)        
                 }
            })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerOptions = PracticeOptions.sort { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
        var pickerView = UIPickerView()
        pickerView.delegate = self
        infopickerTF.inputView = pickerView
        
        
    }

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        infopickerTF.text = pickerOptions[row] as! String
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
