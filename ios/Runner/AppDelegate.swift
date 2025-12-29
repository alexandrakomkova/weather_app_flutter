import Flutter
import UIKit
import workmanager_apple
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "dev.alexandrakomkova.weather_app.updateWeatherData", frequency: NSNumber(value: 20 * 60))
    
      if let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") {
          if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
              do {
                  let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
                  if let dict = plistData as? [String: Any] {
                      // Access Plist data here
                      
                      if let googleMapApiKey = dict["GoogleApiKey"] as? String {
                          GMSServices.provideAPIKey(googleMapApiKey)
                      }
                  }
              } catch {
                  print("Error reading Plist: \(error)")
              }
          }
      }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
