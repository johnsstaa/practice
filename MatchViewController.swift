//
//  File.swift
//  UserLoginAndRegistration
//
//  Created by Jake Babcock on 4/12/17.
//  Copyright © 2017 T.J. Flis. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class MatchViewController: UIViewController {
    
    var matchUserID = ""
    var matchBadCourse = ""
    var matchBCA = ""
    var matchBCN = ""
    var matchGoodCourse = ""
    var matchGCA = ""
    var matchGCN = ""
    var didfirstrun = "NO"
    
    @IBOutlet weak var matchSuccessField: UILabel!
    
    let URL_USER_REGISTER = "http://cgi.soic.indiana.edu/~team2/queryMatch6.php"
    let URL_USER_REGISTER2 = "http://cgi.soic.indiana.edu/~team2/inputMatchedUser.php"
    //let URL_USER_REGISTER3 = "http://cgi.soic.indiana.edu/~team2/practice2.php"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func matchButtonTapped(_ sender: Any) {
        
        //let userEmailStored = UserDefaults.standard.string(forKey:"userEmail");
        //let userPasswordStored = UserDefaults.standard.string(forKey:"userPassword");
        
        
        
        // if(userEmailStored == userEmail)
        // {
        //     if(userPasswordStored == userPassword)
        //    {
        // The login is successful
        //   self.dismiss(animated:true, completion:nil);
        
        let parameters: Parameters=[
            "userID": UserDefaults.standard.value(forKey: "userID")!
        ]
        //let parameters2: Parameters=[
        //    "userID": UserDefaults.standard.value(forKey: "userID")!
        //]
        
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //print(response)
                
                //getting the json value from the server
                if let result = response.result.value
                {
                    if let result = response.result.value as? [[String:Any]]{
                        
                        var newArray = [String]()
                        
                        var matchUserIDArray = result.flatMap { $0["userId"] as? String }
                        let matchBadCourseArray = result.flatMap { $0["BadCourse"] as? String }
                        let matchBCAArray = result.flatMap { $0["bca"] as? String }
                        let matchBCNArray = result.flatMap { $0["bcn"] as? String }
                        let matchGoodCourseArray = result.flatMap { $0["GoodCourse"] as? String }
                        let matchGCAArray = result.flatMap { $0["gca"] as? String }
                        let matchGCNArray = result.flatMap { $0["gcn"] as? String }
                        
                      //  print (guserIDArray)
                        
                        //display1 = idArray[0]+" "+firstnameArray[0]+" "+lastnameArray[0]+" "+emailArray[0]
                        //self.searchResult.text = display1
                        
                        //let jsonData = result as! NSDictionary
                        
                        //displaying the message in label
                        //self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                        if matchUserIDArray != []{
                            self.matchUserID = matchUserIDArray[0]
                        
                            self.matchBadCourse = matchBadCourseArray[0]
                        
                            self.matchBCA = matchBCAArray[0]
                        
                            self.matchBCN = matchBCNArray[0]
                        
                            self.matchGoodCourse = matchGoodCourseArray[0]
                        
                            self.matchGCA = matchGCAArray[0]
                            
                            self.matchGCN = matchGCNArray[0]
                        
                            print (self.matchUserID)
                            print (self.matchGCN)
                        
                            self.didfirstrun = "GO"
                            
                            let defaults = UserDefaults.standard
                        
                            defaults.set(self.matchUserID, forKey: "matchUserID")
                            defaults.set(self.matchBadCourse, forKey: "matchBadCourse")
                            defaults.set(self.matchBCA, forKey: "matchBCA")
                            defaults.set(self.matchBCN, forKey: "matchBCN")
                            defaults.set(self.matchGoodCourse, forKey: "matchGoodCourse")
                            defaults.set(self.matchGCA, forKey: "matchGCA")
                            defaults.set(self.matchGCN, forKey: "matchGCN")
                            UserDefaults.standard.synchronize();
            
                        
                            self.matchSuccessField.text = "We have a match for you! Click the button below"
                        }
                        else{
                            self.displayMyAlertMessage(UserMessage: "You do not have sufficient information for a match. Please add more classes.");
                            
                        }
                        //Add any other things you need from the database here
                    }
                }
                
        }
        
    }
        
    @IBAction func tutorProfileTapped(_ sender: Any) {
    
//        if self.didfirstrun == "GO"{
        self.performSegue(withIdentifier: "otherUser", sender: self);
        let parameters2: Parameters=[
            "matchUserID": UserDefaults.standard.value(forKey: "matchUserID")!,
            "userID": UserDefaults.standard.value(forKey: "userID")!
        ]
            
        Alamofire.request(URL_USER_REGISTER2, method: .post, parameters: parameters2).responseJSON
            {
                response in
                print(response)
                    
        }
//        }
//        else{
//            self.displayMyAlertMessage(UserMessage: "You do not have sufficient information for a match. Please add more classes.");
//            return;
//        }
        
    }
    
    func displayMyAlertMessage(UserMessage:String)
        
        
    {
        
        let myAlert = UIAlertController(title:"Alert", message:
            UserMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:
            UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
}



