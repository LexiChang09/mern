// UserInfoViewController.swift

import UIKit

// Define the delegate protocol
protocol UserInfoViewControllerDelegate: AnyObject {
    func didCompleteProfileSetup(user: User)
}

class UserInfoViewController: UIViewController {
    
    weak var delegate: UserInfoViewControllerDelegate?
    
    private let nameTextField = createTextField(placeholder: "Enter your name")
    private let ageTextField = createTextField(placeholder: "Enter your age", keyboardType: .numberPad)
    private let locationTextField = createTextField(placeholder: "Enter your location")
    private let primaryDiagnosisTextField = createTextField(placeholder: "Enter your primary diagnosis")
    private let hobbiesTextField = createTextField(placeholder: "Enter your hobbies (comma separated)")
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = UIConstants.primaryColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIConstants.bodyFont
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.view.backgroundColor = UIConstants.backgroundColor
        setupUI()
    }
    
    private func setupUI() {
        [nameTextField, ageTextField, locationTextField, primaryDiagnosisTextField, hobbiesTextField, continueButton].forEach {
            view.addSubview($0)
        }
        
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameTextField.widthAnchor.constraint(equalToConstant: 280),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageTextField.widthAnchor.constraint(equalToConstant: 280),
            ageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            locationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            locationTextField.widthAnchor.constraint(equalToConstant: 280),
            locationTextField.heightAnchor.constraint(equalToConstant: 40),
            
            primaryDiagnosisTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryDiagnosisTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 20),
            primaryDiagnosisTextField.widthAnchor.constraint(equalToConstant: 280),
            primaryDiagnosisTextField.heightAnchor.constraint(equalToConstant: 40),
            
            hobbiesTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hobbiesTextField.topAnchor.constraint(equalTo: primaryDiagnosisTextField.bottomAnchor, constant: 20),
            hobbiesTextField.widthAnchor.constraint(equalToConstant: 280),
            hobbiesTextField.heightAnchor.constraint(equalToConstant: 40),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: hobbiesTextField.bottomAnchor, constant: 30),
            continueButton.widthAnchor.constraint(equalToConstant: 200),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func continueTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let age = ageTextField.text, !age.isEmpty,
              let location = locationTextField.text, !location.isEmpty,
              let primaryDiagnosis = primaryDiagnosisTextField.text, !primaryDiagnosis.isEmpty,
              let hobbiesText = hobbiesTextField.text, !hobbiesText.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "Please fill in all fields to continue.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let hobbies = hobbiesText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let user = User(name: name, age: age, location: location, primaryDiagnosis: primaryDiagnosis, hobbies: hobbies)
        
        // Notify the delegate that the profile setup is complete
        delegate?.didCompleteProfileSetup(user: user)
        
        // Optionally, dismiss or navigate to the next screen
    }
    
    private static func createTextField(placeholder: String, keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIConstants.secondaryColor
        textField.font = UIConstants.bodyFont
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
