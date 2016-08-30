
//  ViewController.swift
//  LoginPage
//
//  Created by Ishan Mahajan on 26/08/16.
//  Copyright © 2016 Ishan Mahajan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

    
    
    @IBOutlet weak var TextField1: UITextField!
    @IBOutlet weak var TextField2: UITextField!
  
    
    // On Sign up call
    @IBAction func onClick(sender: AnyObject) {
 
       let result = check()
        if result{
            performSegueWithIdentifier("view2", sender: nil)
        }else{
            
            performSegueWithIdentifier("view3", sender: nil)
        }
    }

   
    func check()-> Bool  {
        
        let value1 = String(TextField1.text!)
        let value2 = String(TextField2.text!)
      
        if value1.isEmpty || value2.isEmpty
            {
                print("Id or Password is Incorrect")
                return false
            }
        else
            {
                postDataToURL()
                print("Hii")
                return true
            }
    }
    
    // Post Method
    
    func postDataToURL() {
        // Setup the session to make Rest Post call
        let postEndpoint: String = "http://reqres.in/api/users"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams : [String: AnyObject] = ["name": "morpheus", "job": "leader" ]
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content- type")
        
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(postParams)
        } catch{
            print("bad things happened")
        }
        
        // Make the Post call and Handle it in a compiler handler
        session.dataTaskWithRequest(request, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 201 else {
                    print ("Not a 200 response")
                    return
            }
            
            // Read the JSON
            if let postString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("POST: " + postString)
               
            }
            
        }).resume()
    }
    

}

