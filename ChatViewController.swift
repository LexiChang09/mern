// ChatViewController.swift

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var currentChatProfile: Profile?
    private var messages: [String] = []
    
    private let tableView = UITableView()
    private let messageInputContainerView = UIView()
    private let messageTextField = UITextField()
    private let sendButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupInputComponents()
        setupTableView()
    }
    
    func initiateChat(with profile: Profile) {
        currentChatProfile = profile
        title = "Chat with \(profile.name)"
        
        messages = ["Hello, \(profile.name)!", "How are you doing today?"]
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
        
        view.addSubview(tableView) // Ensure tableView is added to the main view before constraints
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor) // Link bottom of table to top of input container
        ])
    }
    
    private func setupInputComponents() {
        // Ensure input container is added before setting constraints
        messageInputContainerView.backgroundColor = UIColor.systemGray6
        messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageInputContainerView)
        
        messageTextField.placeholder = "Type a message..."
        messageTextField.borderStyle = .roundedRect
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageInputContainerView.addSubview(messageTextField)
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        messageInputContainerView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            messageTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 10),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputContainerView.centerYAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 35),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            
            sendButton.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -10),
            sendButton.centerYAnchor.constraint(equalTo: messageInputContainerView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func handleSend() {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        
        messages.append(text)
        tableView.reloadData()
        
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        messageTextField.text = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.messages.append("Reply from \(self.currentChatProfile?.name ?? "User")")
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .systemGray5
        } else {
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .blue
            cell.backgroundColor = .systemGray6
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
