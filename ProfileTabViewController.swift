// ProfileTabViewController.swift

import UIKit

class ProfileTabViewController: UIViewController {
    
    private let profileHeaderView = UIView()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = UIColor.systemBlue
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel = createInfoLabel()
    private lazy var ageLabel = createInfoLabel()
    private lazy var locationLabel = createInfoLabel()
    private lazy var primaryDiagnosisLabel = createInfoLabel()
    private lazy var hobbiesLabel = createInfoLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        
        setupProfileHeaderView()
        setupProfileDetails()
        displayUserProfile()
    }
    
    private func setupProfileHeaderView() {
        profileHeaderView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileHeaderView)
        
        profileHeaderView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 180),
            
            profileImageView.centerXAnchor.constraint(equalTo: profileHeaderView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: profileHeaderView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupProfileDetails() {
        let detailsStackView = UIStackView(arrangedSubviews: [
            createField(labelText: "Name", valueLabel: nameLabel),
            createField(labelText: "Age", valueLabel: ageLabel),
            createField(labelText: "Location", valueLabel: locationLabel),
            createField(labelText: "Primary Diagnosis", valueLabel: primaryDiagnosisLabel),
            createField(labelText: "Hobbies", valueLabel: hobbiesLabel)
        ])
        
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 15
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 20),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func createField(labelText: String, valueLabel: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = labelText
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.addSubview(valueLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            valueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, containerView])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
    
    private func createInfoLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func displayUserProfile() {
        guard let user = UserManager.shared.user else { return }
        
        nameLabel.text = user.name
        ageLabel.text = "\(user.age)"
        locationLabel.text = user.location
        primaryDiagnosisLabel.text = user.primaryDiagnosis
        hobbiesLabel.text = user.hobbies.joined(separator: ", ")
    }
}
