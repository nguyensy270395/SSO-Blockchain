import UIKit
import IQKeyboardManager
import UserNotifications
import RxSwift
import RxCocoa
import RxRelay
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appNavigator: AppNavigatorType?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupAppearance()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        window = UIWindow()
        appNavigator = AppNavigator(window: window)
//        appNavigator?.start()
        appNavigator?.switchTo(viewController: MainTabbarViewController(viewModel: .init()))
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
