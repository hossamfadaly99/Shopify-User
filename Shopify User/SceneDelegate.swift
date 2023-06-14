//
//  SceneDelegate.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let homeStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let rootHomeVC = homeStoryboard.instantiateInitialViewController()
        
        let signupStoryboard = UIStoryboard(name: "Signup_SB", bundle: nil)
        let rootSignupVC = signupStoryboard.instantiateInitialViewController()
        
        let isLoggedIn = checkLoginState()
        
        let rootNC = isLoggedIn ? rootHomeVC : rootSignupVC
        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func checkLoginState() -> Bool {
        let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_FIRSTNAME)
        if let customer_id = customer_id, customer_id.isEmpty {
            return false
        }else{
            return true
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

