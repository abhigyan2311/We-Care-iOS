//
//  Config.swift
//  We Care
//
//  Created by Abhigyan Singh on 29/02/16.
//  Copyright © 2016. All rights reserved.
//

import Foundation
import Firebase

struct Config {
    static var firebase = Firebase(url: "https://aalekh.firebaseio.com")
    
    static var loginCheck: Int = 0
    
    static var fname = ""
    static var lname = ""
    static var email = ""
    static var password = ""
    static var mobile = ""
    static var gender = ""
    static var dob = ""
    
}