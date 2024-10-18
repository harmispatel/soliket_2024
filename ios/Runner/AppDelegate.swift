//import Flutter
//import UIKit
//
//@main
//@objc class AppDelegate: FlutterAppDelegate {
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//    GMSServices.provideAPIKey("AIzaSyBuZVlcMCQy7Y8rRfhYEXSODG0_Ryx14R8")
//    GeneratedPluginRegistrant.register(with: self)
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//  }
//}


import Flutter
import UIKit
import GoogleMaps  // Import Google Maps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBuZVlcMCQy7Y8rRfhYEXSODG0_Ryx14R8")  // Use your actual API key
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
