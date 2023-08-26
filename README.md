# flutter-note-app
flutter note app with firebase 

Firebase configuration
Tip: You only need to do one of the following configurations if you intend only to use iOS or Android. We offer instructions for both here for completeness’ sake.
In order to use Firebase with Flutter, you need to follow a process to configure the Flutter project to utilise the FlutterFire libraries correctly:
•	Add the FlutterFire dependencies to your project
•	Register the desired platform on the Firebase project
•	Download the platform-specific configuration file, and add it to the code.
Important: You need to register all the platforms you want to use within the same Firebase project.
In the top-level directory of your Flutter app, there are subdirectories called android, ios,  macos and web. These directories hold the platform-specific configuration files for iOS and Android, respectively.
Configure dependencies
You need to add the FlutterFire libraries for the two Firebase products you are utilizing in this app - Firebase Auth and Cloud Firestore. Run the following three commands to add the dependencies.
$ flutter pub add firebase_core
Resolving dependencies...
+ firebase_core 1.10.5
+ firebase_core_platform_interface 4.2.2
+ firebase_core_web 1.5.2
+ flutter_web_plugins 0.0.0 from sdk flutter
+ js 0.6.3
  test_api 0.4.3 (0.4.8 available)
Changed 5 dependencies!

The [firebase_core](<https://pub.dev/packages/firebase_core>) is the common code required for all Firebase Flutter plugins.
$ flutter pub add firebase_auth
Resolving dependencies...
+ firebase_auth 3.3.3
+ firebase_auth_platform_interface 6.1.8
+ firebase_auth_web 3.3.4
+ intl 0.17.0
  test_api 0.4.3 (0.4.8 available)
Changed 4 dependencies!

The [firebase_auth](<https://pub.dev/packages/firebase_auth>) enables integration with Firebase's Authentication capability.
$ flutter pub add cloud_firestore
Resolving dependencies...
+ cloud_firestore 3.1.4
+ cloud_firestore_platform_interface 5.4.9
+ cloud_firestore_web 2.6.4
  test_api 0.4.3 (0.4.8 available)
Changed 3 dependencies!

The [cloud_firestore](<https://pub.dev/packages/cloud_firestore>) enables access to Cloud Firestore data storage.
$ flutter pub add provider
Resolving dependencies...
+ nested 1.0.0
+ provider 6.0.1
  test_api 0.4.3 (0.4.8 available)
Changed 2 dependencies!

While you have added the required packages, you also need to configure the iOS, Android, macOS and Web runner projects to appropriately utilise Firebase. You are also using the [provider](<https://pub.dev/packages/provider>) package that will enable separation of business logic from display logic.
Installing flutterfire
The FlutterFire CLI depends on the underlying Firebase CLI. If you haven't done so already, ensure the Firebase CLI is installed on your machine.
Next, install the FlutterFire CLI by running the following command:
$ dart pub global activate flutterfire_cli

Once installed, the flutterfire command will be globally available.
https://firebase.google.com/docs/cli#install-cli-windows go to this link
 
•	Run the exe file 
Using node js
Install node js from the given link 
https://nodejs.org/en/download/
•	Run the below commands in cmd to check the successful installation of node js and npm. 
 
•	In your flutter terminal execute the following command
o	npm install -g firebase-tools
•	once done with firebase tools follow further steps given below
Configuring your apps
The CLI extracts information from your Firebase project and selected project applications to generate all the configurations for a specific platform.
In the root of your application, run the configure command:
$ flutterfire configure

The configuration command will guide you through a number of processes:
1.	Selecting a Firebase project (based on the .firebaserc file or from the Firebase Console).
2.	Prompt what platforms (e.g. Android, iOS, macOS & web) you would like configuration for.
3.	Identify which Firebase applications for the chosen platforms should be used to extract configuration for. By default, the CLI will attempt to automatically match Firebase apps based on your current project configuration.
4.	Generate a firebase_options.dart file in your project.
Configure macOS
Flutter on macOS builds fully sandboxed applications. As this application is integrating using the network to communicate with the Firebase servers, you will need to configure your application with network client privileges.
macos/Runner/DebugProfile.entitlements
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "<http://www.apple.com/DTDs/PropertyList-1.0.dtd>">
<plist version="1.0">
<dict>
        <key>com.apple.security.app-sandbox</key>
        <true/>
        <key>com.apple.security.cs.allow-jit</key>
        <true/>
        <key>com.apple.security.network.server</key>
        <true/>
  <!-- Add the following two lines -->
        <key>com.apple.security.network.client</key>
        <true/>
</dict>
</plist>

macos/Runner/Release.entitlements
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "<http://www.apple.com/DTDs/PropertyList-1.0.dtd>">
<plist version="1.0">
<dict>
        <key>com.apple.security.app-sandbox</key>
        <true/>
  <!-- Add the following two lines -->
        <key>com.apple.security.network.client</key>
        <true/>
</dict>
</plist>

See Entitlements and the App Sandbox for more detail.

