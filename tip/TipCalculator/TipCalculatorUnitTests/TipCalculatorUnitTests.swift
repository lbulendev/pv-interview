//
//  TipCalculatorUnitTests.swift
//  TipCalculatorUnitTests
//
//  Created by Larry Bulen on 4/20/17.
//  Copyright © 2017 LarryBulen. All rights reserved.
//

import UIKit
import XCTest
@testable import TipCalculator

class TipCalculatorUnitTests: XCTestCase {
    var tipVC: TipCalculatorViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        tipVC = storyboard.instantiateInitialViewController() as! TipCalculatorViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTipCalculation() {
        let _ = tipVC.view
        tipVC.initialAmountValue = 100
        tipVC.billAmountTextField.text = "100"
        tipVC.percentAmt = 0.05
        tipVC.numberOfPeopleTextField.text = "1"
        tipVC.calculateTip()
        XCTAssert(tipVC.billTotalAmountLabel.text == "105.00", "billTotalAmountLabel doesn't show the right text")
        XCTAssert(tipVC.tipAmountLabel.text == "5.00", "tipAmountLabel doesn't show the right text")
        XCTAssert(tipVC.amountPerPersonLabel.text == "105.00", "amountPerPersonLabel doesn't show the right text")
    }
    
    func testNegativeTipCalculation() {
        let _ = tipVC.view
        tipVC.initialAmountValue = -100
        tipVC.billAmountTextField.text = "-100"
        tipVC.percentAmt = 0.05
        tipVC.numberOfPeopleTextField.text = "1"
        tipVC.calculateTip()
        XCTAssert(tipVC.billTotalAmountLabel.text == "-105.00", "billTotalAmountLabel doesn't show the right text")
        XCTAssert(tipVC.tipAmountLabel.text == "-5.00", "tipAmountLabel doesn't show the right text")
        XCTAssert(tipVC.amountPerPersonLabel.text == "-105.00", "amountPerPersonLabel doesn't show the right text")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
