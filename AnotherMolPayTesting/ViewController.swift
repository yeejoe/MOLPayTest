//
//  ViewController.swift
//  MolPayTesting
//
//  Created by Alex Leong on 22/04/2016.
//  Copyright © 2016 vyrox. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MOLPayLibDelegate{
    
    let MOL_USERNAME = "api_vyroxinternational"
    let MOL_PASSWORD = "api_vYr1231rOX#"
    let MOL_MERC_ID = "vyroxinternational"
    let MOL_VER_KEY = "9e68a249c1ae1691845517f4c68f9842"
    let MOL_APP_NAME = "GoGoMission"
    
    @IBOutlet weak var responseText: UILabel!
    
    var mp : MOLPayLib?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButton(sender: AnyObject) {
        molPayPayment(10.0, orderId: "orderId123", billName: "Joe", billEmail: "Email@email.com", billMobile: "028147123897", billDesc: "Testing Message", paymentType: "cc")
    }
    
    func molPayPayment(payAmount : Float, orderId : NSString, billName : NSString, billEmail : NSString, billMobile : NSString , billDesc : NSString , paymentType : NSString){
        var channelToPick = "credit"
        
        if(paymentType != "cc"){
            channelToPick = paymentType as String
        }
        let paymentRequestDict = [
//            "mp_amount": NSString(format:"%.2f", payAmount), // Mandatory
//            "mp_username": "\"\(MOL_USERNAME)\"", // Mandatory
//            "mp_password": "\"\(MOL_PASSWORD)\"", // Mandatory
//            "mp_merchant_ID": "\"\(MOL_MERC_ID)\"", // Mandatory
//            "mp_app_name": "\"\(MOL_APP_NAME)\"", // Mandatory
//            "mp_order_ID": "\"\(orderId)\"", // Mandatory
//            "mp_currency": "\"MYR\"", // Mandatory
//            "mp_country": "\"MY\"", // Mandatory
//            "mp_verification_key": "\"\(MOL_VER_KEY)\"", // Mandatory
//            "mp_channel": "\"\(channelToPick)\"", // Optional
//            "mp_bill_description": "\"\(billDesc)\"", // Optional
//            "mp_bill_name": "\"\(billName)\"", // Optional
//            "mp_bill_email": "\"\(billEmail)\"", // Optional
//            "mp_bill_mobile": "\"\(billMobile)\"", // Optional
//            "mp_channel_editing": NSNumber(bool:false), // Optional
//            "mp_editing_enabled": NSNumber(bool:false), // Optional
//            "mp_transaction_id": "", // Optional for transactionRequest
//            "mp_request_type": "" // Optional for transactionRequest. Use anything other than "Receipt".
            
            "mp_amount": NSString(format:"%.2f", payAmount), // Mandatory
            "mp_username": MOL_USERNAME, // Mandatory
            "mp_password": MOL_PASSWORD, // Mandatory
            "mp_merchant_ID": MOL_MERC_ID, // Mandatory
            "mp_app_name": MOL_APP_NAME, // Mandatory
            "mp_order_ID": orderId, // Mandatory
            "mp_currency": "MYR", // Mandatory
            "mp_country": "MY", // Mandatory
            "mp_verification_key": MOL_VER_KEY, // Mandatory
            "mp_channel": channelToPick, // Optional
            "mp_bill_description": billDesc, // Optional
            "mp_bill_name":billName, // Optional
            "mp_bill_email": billEmail, // Optional
            "mp_bill_mobile": billMobile, // Optional
            "mp_channel_editing": NSNumber(bool:false), // Optional
            "mp_editing_enabled": NSNumber(bool:false), // Optional
            "mp_transaction_id": "", // Optional for transactionRequest
            "mp_request_type": "" // Optional for transactionRequest. Use anything other than "Receipt".
        ]
        
        
        print(paymentRequestDict)
        
        mp = MOLPayLib(delegate: self, andPaymentDetails:paymentRequestDict)
        
        //[self presentViewController:mp animated:NO completion:nil];
        //[mp transactionRequest];
        let nc = UINavigationController(rootViewController: mp!)
        mp!.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",style: UIBarButtonItemStyle.Plain,target: self, action: #selector(ViewController.closedMolPay))
        
        self.presentViewController(nc, animated: false, completion: nil)
    }
    
    
    func closedMolPay() {
        mp!.closemolpay()
    }
    
    func transactionResult(result: [NSObject : AnyObject]!) {
        print("transactionResult result = %s",result)
        responseText.text = "transactionResult result = \(result)"
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
}

