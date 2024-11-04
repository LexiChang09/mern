// ProfileViewController.swift

import UIKit

class ProfileViewController: UIViewController {
    private let profile: Profile
    private let matchCriteria: String
    
    private let criteriaLabel = UILabel()
    private let profileDetailsLabel = UILabel()
    
    // Initialize with Profile and criteria
    init(profile: Profile, criteria: String) {
        self.profile = profile
        self.matchCriteria = criteria
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupUI()
    }
    
    private func setupUI() {
        // Criteria Label
        criteriaLabel.text = "Criteria: \(matchCriteria)"
        criteriaLabel.font = UIFont.boldSystemFont(ofSize: 18)
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(criteriaLabel)
        
        // Profile Details Label
        profileDetailsLabel.text = """
        Name: \(profile.name)
        Age: \(profile.age)
        Primary Diagnosis: \(profile.primaryDiagnosis)
        Hobbies: \(profile.hobbies.joined(separator: ", "))
        Location: \(profile.location)
        """
        profileDetailsLabel.numberOfLines = 0
        profileDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileDetailsLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            criteriaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            criteriaLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            profileDetailsLabel.topAnchor.constraint(equalTo: criteriaLabel.bottomAnchor, constant: 20),
            profileDetailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileDetailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
