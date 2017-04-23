# Tip Calculator App README

Enter your readme notes here.

The app "TipCalculator" calculates a total bill using selected tip percentage (%) and original bill amount.
From this new total, I can determine each person's share by dividing by the number of people in the party.

Also, I didn't format the amounts with '$' or provide a mechanism to choose a currency symbol.  I figure anytime I traveled I thought in terms of local currency and didn't need the app showing the wrong symbol.



Resources I used to complete this demo app:
URL: https://cocoapods.org/pods/Amplitude-iOS
URL: https://amplitude.com
URL: http://stackoverflow.com/questions/41605297/cllocationmanager-delegate-not-called-in-ios-10-swift-3-simulator
URL: http://stackoverflow.com/questions/39127689/converting-double-to-nsnumber-in-swift-loses-accuracy



App organization
   Logical structure - I used a modified Model-View-Controller (MVC) design pattern.  In this case, there's no MODEL.  So, in the project you'll only see VIEW and CONTROLLER groups.  If I had local storage for the app to track tips, I would have added MODEL and put my 'store' there.'

    Design structure - I used the following:
        Cocoapods = to add a 3rd party framework to the app, instead of using the legacy method to drag and drop the framework into the app.
        Storyboard = to layout the simple view, since the structure was fairly static...no dynamic cells, or changing content, like a Facebook feed



What did I struggle with?  Amplitude's API was easy to setup and start sending data to their server.  It was really easy to establish the dev account, get the api key, and connect to their servers.  But, I struggled with getting the appropriate data to their servers'

    The API calls that I used are:
        1) Amplitude.instance().initializeApiKey("89897cb80b046b127084d7d90f8965a2")
            The API key I used was provided by Amplitude after signing into their site as a developer.

        2) Amplitude.instance().enableLocationListening()
            Added enable/disableLocationListening to help track user location, like San Mateo
        3) Amplitude.instance().disableLocationListening()

        4) Amplitude.instance().logEvent("UserTapped")
            Added this log event for user taps, like changing SLIDER control, and the used FINISHED EDITING TEXT for either text field (Bill Amount and Party Size)

        5) Amplitude.instance().logRevenue("tip percentage", quantity: 1, price: Int(percentAmt * 100) as NSNumber, receipt: nil)
            Added this log Revenue to capture the user percentage.  The percentage in the app is Double, but the log expects NSNUMBER (INT), so I multiplied the DOUBLE value by 100.


To install the app, do the following:
1) use git clone to copy repo to local machine
2) assumes you have cocoapods installed, use: pod install
3) open TipCalculator.xcworkspace/
