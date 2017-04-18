# Video Call App README

Enter your readme notes here.

The app "VideoCall" allow a user to simulate a video (looped back to themselves).

Open the app, and you're presented with 2 buttons:
- camera - to toggle from front/back camera (during call)'
- call - to place a call or hangup a current call

Tap the CALL button to connect to the TOKBOX server



Resources I used to complete this demo app:
URL: https://cocoapods.org/pods/OpenTok
URL: https://tokbox.com



App organization
Logical structure - I used a modified Model-View-Controller (MVC) design pattern.  In this case, there's no MODEL.  So, in the project you'll only see VIEW and CONTROLLER groups.  If I had local storage for the app to track tips, I would have added MODEL and put my 'store' there.'

Design structure - I used the following:
Cocoapods = to add a 3rd party framework to the app, instead of using the legacy method to drag and drop the framework into the app.
Storyboard = to layout the simple view, since the structure was fairly static...no dynamic cells, or changing content, like a Facebook feed



What did I struggle with?  Nothing really.  Just laid out a view in the storyboard; and tested functionality.


The API used values generated on the TokBox web portal:
A) Create a PROJECT...by assigning a name, such as: VideoCall
B) Create a SESSION ID
C) Create a TOKEN ID 

Here's the values that were generated (I've pasted partial values here.  The code has the full value.)
1) ApiKey = "45822522"
2) kSessionId = "2_MX40...U9FdkdRbEo0Um95c0xPazZ-fg"
3) kToken = "T1==cGFy....GltZT0xNDkzMDc2MDUw"



To install the app, do the following:
1) use git clone to copy repo to local machine
2) assumes you have cocoapods installed, use: pod install
3) open VideoCall.xcworkspace/


### Short Answer Questions

1. Describe the tools and technology you would use to deliver the Video Call App to stakeholders such as the PM team or the QA team

The notes below apply to both Q#1 and Q#2

To publish an app that has never been published before, do the following:
- connect to ITunes Connect: https://itunesconnect.apple.com
- login as an administrator
- click '+' icon to add a new app
- click NEW APP
- fill out the form:
       - check IOS
       - enter a NAME for the app, such as VideoCall
       - select PRIMARY LANGUAGE, such as ENGLISH (U.S.)
       - leave BUNDLE ID blank...it will be filled in on 1st build submitted
       - enter a BUNDLE ID SUFFIX ...must match the BUNDLE info in the app's Info.plist
       - enter a SKU = a unique id that's not visible in the appstore
       - click CREATE button
NOTE: If the app's name already appears in the store, you might see a warning about 'Name is already being used'. Could change before hitting CREATE button again.

Now, you reach an APP INFO page. Here you can set various items, like:
- PRIVACY POLICY URL 
- CATEGORY (Primary and Secondary), might chose HEALTH & FITNESS and FOOD & DRINK
- LICENSE AGREEMENT = if not using Apple's standard agreement

Click SAVE button

Now you can do the following:
- set PRICING, like USD 0 (if fee), or any of the available pricing tiers

Under 1.0 PREPARE FOR SUBMISSION, you could set the following:
- drag/drop app preview and screenshots
- post a DESCRIPTION of the app
- add KEYWORDS related to the app and target userbase
- add SUPPORT and MARKETING URLs for the app
- could add supporting images for APPLE WATCH and IMESSAGE APP
- SKIP this step for QA and PM testing...
      submit an inital build from Xcode
- add APP ICON
- add a COPYRIGHT
- add a TRADE REP CONTACT info (for my local dev account, it's my info)
- provide APP REVIEW INFO, like userid and password, plus local contact info if review needs to talk with someone
- set a RELEASE date = automatic, or pick a target date


You could also add FEATURES (in-app purchase items, subscription (auto-renew or not), consumable or such)


Before submitting to APP REVIEW, you could 'Test Flight' your app with some trusted beta-users.



2. Describe the entire submission process for the Video Call App going from source code to the official Apple Store. Please include all steps one would encounter when interacting with Apple

Most of the steps above would apply, but instead of SKIPPING submit build for APP REVIEW, you have to do this.
And, you'd skip the TEST FLIGHT app submission.


During APP REVIEW, they could kick back the app for a variety of reasons: app crash, or wanting more info, such as proof of licensing for copyrighted materials (songs for games, or celebrity images/names)

The APP REVIEW process could take 7 days or longer.  So, at Epocrates we would not approve automatic releases.  We would schdule a targeted date.


At Epocrates/Athenahealth, we had multiple targets for our (DEBUG, RELEASE).  In our code, we'd have forks to use DEBUG for dev builds and RELEASE for builds going to APPLE.
- So, we could use PRODUCTION servers for RELEASE builds and DEV servers for DEBUG builds
- Also, DEBUG could have 4 or more environments so we could have multiple teams on different sprint cycles.

Items the people pushing to APPLE needs are:
- new APP description content, like bugs fixed
- new point of contact for app review
- new release signed build (certificate used on release build should be on 1 box; not all developer boxes)



