// MatchViewController.swift

import UIKit

class MatchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ready to Match?"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose criteria to be matched with:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pickerView = UIPickerView()
    private let findMatchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Match", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let criteriaOptions = ["Select from options", "Age", "Hobbies", "Primary Diagnosis", "Location"]
    private var selectedCriteria: String?
    private let user: User
    private var sampleProfiles: [Profile] = []
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        
        // Updated sample profiles to match your specified list
        sampleProfiles = [
            Profile(name: "Joseph Johnson", age: 48, primaryDiagnosis: "Colorectal Cancer", hobbies: ["Cooking", "Reading", "Board Games"], location: "Columbus, OH"),
            Profile(name: "Manuel Sanchez", age: 52, primaryDiagnosis: "Colorectal Cancer", hobbies: ["Baking", "Knitting", "Reading"], location: "Columbus, OH"),
            Profile(name: "Demetrius Jones", age: 50, primaryDiagnosis: "Type 2 Diabetes", hobbies: ["Cooking", "Painting", "Reading"], location: "Columbus, OH"),
            Profile(name: "Diego Lopez", age: 35, primaryDiagnosis: "Type 2 Diabetes", hobbies: ["Biking", "Outdoor Running", "Swimming"], location: "Miami, FL"),
            Profile(name: "Elizabeth Rowe", age: 29, primaryDiagnosis: "Traumatic Brain Injury", hobbies: ["Walking", "Birdwatching", "Photography"], location: "Columbus, OH")
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        // Add title and instruction labels
        view.addSubview(titleLabel)
        view.addSubview(instructionLabel)
        
        // Configure picker view
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        // Configure find match button
        view.addSubview(findMatchButton)
        findMatchButton.addTarget(self, action: #selector(findMatches), for: .touchUpInside)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            instructionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            pickerView.widthAnchor.constraint(equalToConstant: 250),
            pickerView.heightAnchor.constraint(equalToConstant: 150),
            
            findMatchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findMatchButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 30),
            findMatchButton.widthAnchor.constraint(equalToConstant: 200),
            findMatchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Picker View Data Source and Delegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return criteriaOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return criteriaOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCriteria = criteriaOptions[row]
    }
    
    // MARK: - Matching Logic
    
    @objc private func findMatches() {
        guard let criteria = selectedCriteria, criteria != "Select from options" else {
            let alert = UIAlertController(title: "Please select a criteria", message: "Choose a matching criteria from the list.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let matchedProfiles = findMatchingProfiles(for: criteria)
        
        if matchedProfiles.isEmpty {
            let alert = UIAlertController(title: "No Matches Found", message: "No profiles matched the selected criteria.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        } else {
            let matchesVC = MatchesViewController(profiles: matchedProfiles, criteria: criteria)
            navigationController?.pushViewController(matchesVC, animated: true)
        }
    }
    
    private func findMatchingProfiles(for criteria: String) -> [Profile] {
        switch criteria {
        case "Age":
            return sampleProfiles.filter { $0.age == Int(user.age) }
        case "Hobbies":
            let userHobbies = Set(user.hobbies)
            return sampleProfiles.filter { !userHobbies.isDisjoint(with: Set($0.hobbies)) }
        case "Primary Diagnosis":
            return sampleProfiles.filter { $0.primaryDiagnosis == user.primaryDiagnosis }
        case "Location":
            return sampleProfiles.filter { $0.location == user.location }
        default:
            return []
        }
    }
}
