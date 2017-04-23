//
//  VideoCallUnitTests.swift
//  VideoCallUnitTests
//
//  Created by Larry Bulen on 4/20/17.
//  Copyright © 2017 LBulenApps. All rights reserved.
//

import UIKit
import OpenTok
import XCTest
@testable import VideoCall

class VideoCallUnitTests: XCTestCase {
    var videoVC: VideoCallViewController!
 
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        videoVC = storyboard.instantiateInitialViewController() as! VideoCallViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func tesConnection() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var error: OTError?

        let _ = videoVC.view
        videoVC.session = OTSession(apiKey: kApiKey, sessionId: kSessionId, delegate: videoVC)!
        videoVC.session.connect(withToken: kToken, error: &error)

        XCTAssert((videoVC.subscriber == nil), "subscriber not connected")
//        XCTAssert(videoVC.publisher, "publisher not connected")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
