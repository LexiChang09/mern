// MainTabBarController.swift

import UIKit

class MainTabBarController: UITabBarController {
    
    private let chatVC = ChatViewController() // Ensure this is accessible

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up view controllers
        let profileTabVC = ProfileTabViewController()
        profileTabVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 0)
        
        let matchVC = MatchViewController(user: UserManager.shared.user!)
        matchVC.tabBarItem = UITabBarItem(title: "Matching", image: UIImage(systemName: "heart.circle"), tag: 1)
        
        chatVC.tabBarItem = UITabBarItem(title: "Chatting", image: UIImage(systemName: "message.circle"), tag: 2)
        
        let profileNav = UINavigationController(rootViewController: profileTabVC)
        let matchNav = UINavigationController(rootViewController: matchVC)
        let chatNav = UINavigationController(rootViewController: chatVC)
        
        viewControllers = [profileNav, matchNav, chatNav]
        
        tabBar.tintColor = UIColor.systemBlue
        tabBar.backgroundColor = UIColor.systemGray6
    }
    
    // Method to switch to chat tab with a matched profile
    func switchToChatTab(with profile: Profile) {
        selectedIndex = 2 // Switch to the chat tab
        chatVC.initiateChat(with: profile) // Initialize the chat with the selected profile
    }
}
