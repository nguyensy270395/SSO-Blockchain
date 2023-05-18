import UIKit
import IQKeyboardManager
import UserNotifications
import RxSwift
import RxCocoa
import RxRelay
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appNavigator: AppNavigatorType?
    var appViewModel: AppViewModel?
    let gcmMessageIDKey = "gcm.Message_ID"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupAppearance()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        window = UIWindow()
        appNavigator = AppNavigator(window: window)
        appViewModel = AppViewModel()
        appNavigator?.loadFirstView()
        //        appNavigator?.switchToMain()

        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()

        //TODO: Message Delegate
        Messaging.messaging().delegate = self


        return true
    }

    private func setupAppearance() {
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
            tabBarAppearance.configureWithOpaqueBackground()
            //            tabBarAppearance.inlineLayoutAppearance.normal.iconColor = R.color.color_D1D1D1()
            //            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = R.color.color_D1D1D1()
            //            tabBarAppearance.compactInlineLayoutAppearance.normal.iconColor = R.color.color_D1D1D1()
            //
            //            tabBarAppearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: R.color.color_D1D1D1()]
            //            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: R.color.color_D1D1D1()]
            //            tabBarAppearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: R.color.color_D1D1D1()]
            //
            //            tabBarAppearance.inlineLayoutAppearance.selected.iconColor = R.color.color_EA3442()
            //            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = R.color.color_EA3442()
            //            tabBarAppearance.compactInlineLayoutAppearance.selected.iconColor = R.color.color_EA3442()
            //
            //            tabBarAppearance.inlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: R.color.color_EA3442()]
            //            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: R.color.color_EA3442()]
            //            tabBarAppearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: R.color.color_EA3442()]
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
    
    func registerForPushNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
        }
        
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // ...

        // Print full message.
        print(userInfo)

        // Change this to your preferred presentation option
        return [[.alert, .sound]]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        // ...

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print full message.
        print(userInfo)
    }

    

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
    -> UIBackgroundFetchResult {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        return UIBackgroundFetchResult.newData
    }

}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        UserDefaults.standard.set(fcmToken, forKey: "fcmKey")
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}
