//
//  VideoCallViewController.swift
//  VideoCall
//
//  Created by Larry Bulen on 4/17/17.
//  Copyright © 2017 LBulenApps. All rights reserved.
//

import UIKit
import OpenTok // importing TokBok's OpenTok API

// *** Variables for using OpenTok; includes values from my TokBox project info  ***
// ***            https://tokbox.com/account/#/                  ***
// Replace with your OpenTok API key
let kApiKey = "45822522"
// Replace with your generated session ID
let kSessionId = "2_MX40NTgyMjUyMn5-MTQ5MjQ2NTU2MDY0MX5kSG1IQmxOeU9FdkdRbEo0Um95c0xPazZ-fg"
// Replace with your generated token
let kToken = "T1==cGFydG5lcl9pZD00NTgyMjUyMiZzaWc9YzgwYjVlZDNhNzAyNThiOWVlY2M4Mjk2N2Y4ZWFlMmM4NGQ1Zjc4YzpzZXNzaW9uX2lkPTJfTVg0ME5UZ3lNalV5TW41LU1UUTVNalEyTlRVMk1EWTBNWDVrU0cxSVFteE9lVTlGZGtkUmJFbzBVbTk1YzB4UGF6Wi1mZyZjcmVhdGVfdGltZT0xNDkyNDcxMjUwJm5vbmNlPTAuOTA4NDU2NTE0NTQ3MDQxOCZyb2xlPXB1Ymxpc2hlciZleHBpcmVfdGltZT0xNDkzMDc2MDUw"



// CLASS VIDEOCALLVIEWCONTROLLER: UIVIEWCONTROLLER
// This is the main class used in the app.

class VideoCallViewController: UIViewController {

    @IBOutlet var publisherView: UIView!                    // used to hold the frame/constraints from storyboard
    @IBOutlet var subscriberView: UIView!                   // used to hold the frame/constraints from storyboard
    
    @IBOutlet weak var cameraButton: UIButton!              // used to toggle from front/back facing camera
    @IBOutlet weak var callButton: UIButton!                // used to call/hangup video session

    
    // FUNC CAMERABUTTONCLICKED(_ sender: ANY)
    // method used toggle the camera from front to back
    //----------
    // The body of this method was copied from the sample app
    @IBAction func cameraButtonClicked(_ sender: Any) {
        if publisher.cameraPosition == .front {
            publisher.cameraPosition = .back
        } else {
            publisher.cameraPosition = .front
        }
    }
    
    
    // FUNC CALLBUTTONCLICKED(_ sender: UIBUTTON)
    // method used to call/hangup depending on the status of call session
    @IBAction func callButtonClicked(_ sender: UIButton) {
        switch session.sessionConnectionStatus {
        case .connected, .connecting:
            
            // When disconnecting; change callButton to show "Call" lable
            disconnectCall()
            callButton.setTitle("Call", for: .normal)

            // Added this as an after thought; show the user a visible message that the call is ending
            let controller = UIAlertController(title: "Hangup call", message: "You have selected to end the call.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(controller, animated: true, completion: nil)

        default:
            // When connecting; change callButton to show "Hangup" lable
            connectCall()
            callButton.setTitle("Hangup", for: .normal)
        }
    }
    
    // FUNC VIEWDIDLOAD()
    // method required to draw the view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscriberView.layer.cornerRadius = self.subscriberView.frame.width/2
        self.subscriberView.clipsToBounds = true
        // Do any additional setup after loading the view
    }
    
    // FUNC DIDRECEIVEMEMORYWARNING()
    // method used if the app enters a low memory state
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Code copied from Sample TokBox app
    // 99% of the code below is copied from the sample app
    // --------------------------
    // renamed original method: doConnect to connectCall
    // added method: disconnectCall
    // added 1 line to remove 'publisher.view' from superview; to hide the camera view when disconnected

    lazy var session: OTSession = {
        return OTSession(apiKey: kApiKey, sessionId: kSessionId, delegate: self)!
    }()
    
    lazy var publisher: OTPublisher = {
        let settings = OTPublisherSettings()
        settings.name = UIDevice.current.name
        return OTPublisher(delegate: self, settings: settings)!
    }()
    
    var subscriber: OTSubscriber?
    
    // Change to `false` to subscribe to streams other than your own.
    var subscribeToSelf = true

    // FUNC CONNECTCALL() - was originally called 'doConnect' in the sample code
    // Connects video session, if there's no error
    func connectCall() {
        var error: OTError?
        defer {
            processError(error)
        }

        session.connect(withToken: kToken, error: &error)
    }
    
    // FUNC DISCONNECTCALL()
    // Disconnect video session
    func disconnectCall() {
        var error: OTError?
        
        session.disconnect(&error)
    }

    /**
     * Sets up an instance of OTPublisher to use with this session. OTPubilsher
     * binds to the device camera and microphone, and will provide A/V streams
     * to the OpenTok session.
     */
    fileprivate func doPublish() {
        var error: OTError?
        defer {
            processError(error)
        }
        
        session.publish(publisher, error: &error)

        if let pubView = publisher.view {
            pubView.frame = publisherView.frame
            view.addSubview(pubView)
        }
    }
    
    /**
     * Instantiates a subscriber for the given stream and asynchronously begins the
     * process to begin receiving A/V content for this stream. Unlike doPublish,
     * this method does not add the subscriber to the view hierarchy. Instead, we
     * add the subscriber only after it has connected and begins receiving data.
     */
    fileprivate func doSubscribe(_ stream: OTStream) {
        var error: OTError?
        defer {
            processError(error)
        }
        subscriber = OTSubscriber(stream: stream, delegate: self)
        
        session.subscribe(subscriber!, error: &error)
    }
    
    fileprivate func cleanupSubscriber() {
        subscriber?.view?.removeFromSuperview()
        subscriber = nil
        publisher.view?.removeFromSuperview()  // Here I remove the 'publisher.view' to hide the camera view
    }
    
    fileprivate func processError(_ error: OTError?) {
        if let err = error {
            showAlert(errorStr: err.localizedDescription)
        }
    }
    
    fileprivate func showAlert(errorStr err: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: "Error", message: err, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }

}

// MARK: - OTSession delegate callbacks
extension VideoCallViewController: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
        print("Session connected")
        doPublish()
    }
    
    func sessionDidDisconnect(_ session: OTSession) {
        print("Session disconnected")
    }
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {
        print("Session streamCreated: \(stream.streamId)")
        if subscriber == nil && !subscribeToSelf {
            doSubscribe(stream)
        }
    }
    
    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
        print("Session streamDestroyed: \(stream.streamId)")
        if let subStream = subscriber?.stream, subStream.streamId == stream.streamId {
            cleanupSubscriber()
        }
    }
    
    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("session Failed to connect: \(error.localizedDescription)")
    }
    
}

// MARK: - OTPublisher delegate callbacks
extension VideoCallViewController: OTPublisherDelegate {
    func publisher(_ publisher: OTPublisherKit, streamCreated stream: OTStream) {
        if subscriber == nil && subscribeToSelf {
            doSubscribe(stream)
        }
    }
    
    func publisher(_ publisher: OTPublisherKit, streamDestroyed stream: OTStream) {
        if let subStream = subscriber?.stream, subStream.streamId == stream.streamId {
            cleanupSubscriber()
        }
    }
    
    func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
        print("Publisher failed: \(error.localizedDescription)")
    }
    
}

// MARK: - OTSubscriber delegate callbacks
extension VideoCallViewController: OTSubscriberDelegate {
    func subscriberDidConnect(toStream subscriberKit: OTSubscriberKit) {
        if let subsView = subscriber?.view {
            subsView.frame = subscriberView.frame
            view.addSubview(subsView)
        }
    }
    
    func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
        print("Subscriber failed: \(error.localizedDescription)")
    }
    
    func subscriberVideoDataReceived(_ subscriber: OTSubscriber) {
    }
}

// --------------------------


