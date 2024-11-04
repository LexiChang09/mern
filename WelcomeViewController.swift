// WelcomeViewController.swift

import UIKit

class WelcomeViewController: UIViewController, UserInfoViewControllerDelegate {
    
    private let welcomeLabel = UILabel()
    private let createProfileButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConstants.backgroundColor
        setupUI()
    }
    
    private func setupUI() {
        // Configure welcome label
        welcomeLabel.text = "Welcome to SyncAid!"
        welcomeLabel.font = UIConstants.titleFont
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = UIConstants.primaryColor
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        // Configure create profile button
        createProfileButton.setTitle("Create Profile", for: .normal)
        createProfileButton.backgroundColor = UIConstants.primaryColor
        createProfileButton.setTitleColor(.white, for: .normal)
        createProfileButton.titleLabel?.font = UIConstants.bodyFont
        createProfileButton.layer.cornerRadius = 10
        createProfileButton.addTarget(self, action: #selector(createProfileTapped), for: .touchUpInside)
        createProfileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createProfileButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            createProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createProfileButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            createProfileButton.widthAnchor.constraint(equalToConstant: 200),
            createProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func createProfileTapped() {
        let userInfoVC = UserInfoViewController()
        userInfoVC.delegate = self // Set WelcomeViewController as the delegate
        navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    // MARK: - UserInfoViewControllerDelegate
    
    func didCompleteProfileSetup(user: User) {
        // Assign the user data to UserManager
        UserManager.shared.user = user
        
        // Proceed to the main app screen
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true, completion: nil)
    }
}
