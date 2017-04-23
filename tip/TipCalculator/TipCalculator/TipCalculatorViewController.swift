//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by Larry Bulen on 4/15/17.
//  Copyright © 2017 LarryBulen. All rights reserved.
//

import UIKit
import Amplitude_iOS // importing Amplitude's Analytic API
import CoreLocation  // required for using CoreLocationManager

// CLASS TIPCALCULATORVIEWCONTROLLER: UIVIEWCONTROLLER, CLLOCATIONMANAGERDELEGATE
// This is the main class used in the app.  It is a UIViewController that conforms to the CLLOCATIONMANAGERDELEGATE

class TipCalculatorViewController: UIViewController, CLLocationManagerDelegate  {

    @IBOutlet weak var billAmountTextField: UITextField!                // where user enter's bill amount
    
    @IBOutlet weak var tipPercentageSlider: UISlider!
    
    @IBOutlet weak var tipAmountLabel: UILabel!                         // label to display calculated tip amount
    @IBOutlet weak var billTotalAmountLabel: UILabel!                   // label to show bill total (bill amount + tip amount)
    @IBOutlet weak var numberOfPeopleTextField: UITextField!            // textfield to allow user to select party size
    @IBOutlet weak var amountPerPersonLabel: UILabel!                   // label to show amount each person in party should contribute to bill
    
    // setter used to store bill amount; on change calculates new tip
    var initialAmountValue: Double? = 0 {
        didSet {
            calculateTip()
        }
    }
    
    var percentAmt : Double? = 0.25 {
        didSet {
            calculateTip()
        }
    }

    var locationManager: CLLocationManager = CLLocationManager.init()  // Required to find users' location (lat/long)
        
    // used to store party size; on change calculates new tip
    var initialPartySize: Int? = 1 {
        didSet {
            calculateTip()
        }
    }
    
    // FUNC VIEWDIDLOAD()
    // method required to draw the view; also starts the location manager, if authorized
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // The idea for the CLLOCATIONMANGER code below came from:
        // URL: http://stackoverflow.com/questions/41605297/cllocationmanager-delegate-not-called-in-ios-10-swift-3-simulator
        // setup the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        if CLLocationManager.locationServicesEnabled() {
            
            // Using a flag to help catch approval/disapproval for using location manager
            var locationManagerFlag = true
            
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse: break
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                locationManagerFlag = false
            }
            
            if locationManagerFlag {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    // FUNC VIEWDIDDISAPPEAR()
    // method required the view is no longer in view; stops the location manager
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    // FUNC DIDRECEIVEMEMORYWARNING()
    // method used if the app enters a low memory state
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // FUNC AMOUNTCHANGED(_ sender: UITEXTFIELD)
    // method used when the bill amount is changed; determines if the bill is > 0; else default to 0
    @IBAction func amountChanged(_ sender: UITextField) {
        if let text = sender.text,
           let value = Double(text) {
            initialAmountValue = value
        } else {
            initialAmountValue = 0  // default bill amount = 0
        }
    }
    
    // FUNC PERCENTAGECHANGED(_ SENDER: UISLIDER)
    // method used the % control is changed; calcualte tip with new percent
    @IBAction func percentageChanged(_ sender: UISlider) {
        percentAmt = Double(String(format: "%.2f", sender.value))!
        Amplitude.instance().logEvent("UserTapped")
    }
    
    // FUNC NUMBEROFPEOPLECHANGED(_ sender: UITEXTFIELD)
    // method used when the size of the party is changed; determines if the size is > 0; else default to 1
    @IBAction func numberOfPeopleChanged(_ sender: UITextField) {
        if let text = sender.text,
            let value = Int(text), value > 0 {
            initialPartySize = value
        } else {
            initialPartySize = 1  // default party size = 1
        }
    }
    
    // FUNC FINISHEDEDITINGTEXT(_ SENDER: ANY)
    // method used by both BILLAMOUNT and PARTY SIZE text fields, when user finished editing, it would log the event
    @IBAction func finishedEditingText(_ sender: Any) {
        Amplitude.instance().logEvent("UserTapped")
    }
    
    // FUNC DISMISSKEYBOARD(SENDER: ANYOBJECT)
    // Used to hide the keyboard; if user taps the app background
    @IBAction func dismissKeyboard(sender: AnyObject) {
        billAmountTextField.resignFirstResponder()
        numberOfPeopleTextField.resignFirstResponder()
    }

    // FUNC CALCULATETIP()
    // This method does the 'work' calculating the tip amount, bill total, and amount each person should contribute
    func calculateTip() {
        
        // Calcuate tip amount = initialAmt * percent
        tipAmountLabel.text = String(format: "%.2f", initialAmountValue! * percentAmt!)
        
        // Calculate total bill = initalAmt + tipAmt
        billTotalAmountLabel.text = String(format: "%.2f", Double(tipAmountLabel.text!)! + initialAmountValue!)
        
        // Calculate each person's share = billAmt / number of people (in party)
        amountPerPersonLabel.text = String(format: "%.2f", Double(billTotalAmountLabel.text!)! / Double(initialPartySize!))
        
        // Used this URL: http://stackoverflow.com/questions/39127689/converting-double-to-nsnumber-in-swift-loses-accuracy
        // Wasn't sure how to convert double to NSNumber, and site recommended to convert to INT.  So, I am multiplying DOUBLE by 100
        Amplitude.instance().logRevenue("tip percentage", quantity: 1, price: Int(percentAmt! * 100) as NSNumber, receipt: nil)
    }
    
}
