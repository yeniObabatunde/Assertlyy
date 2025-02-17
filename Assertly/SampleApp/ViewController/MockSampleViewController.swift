//
//  MockSampleViewController.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2024.
//

import UIKit
import NetworkHandling
import Assertly

class MockSampleViewController: UIViewController {
    
    //MARK: UI ELEMENT
    lazy var nameLabel = UILabel()
    lazy var idLabel = UILabel()
    var presentedAlert: UIAlertController?
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 12
        button.setTitle("Perform any action", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var mockViewModel: MockViewModel
    private let networkHandler: NetworkHandler = NetworkHandler()
    private var viewModel: AssertlySampleUseViewModel?
    var fetchUserCalled: Bool = false
    
    init(mockViewModel: MockViewModel) {
        self.mockViewModel = mockViewModel
        self.viewModel = AssertlySampleUseViewModel(networkHandler: networkHandler)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        onCompletion()
    }
    
    private func setupUI() {
        title = "Mock Sample"
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        view.addSubview(actionButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func onCompletion() {
        fetchUser()
        viewModel?.onError = { [weak self] error in
            self?.handle(error: error)
        }
        viewModel?.userList = { [weak self] item in
            guard let item = item?.data else {return}
            self?.updateUI(with: item[0])
        }
        
    }
    
    func fetchUser() {
        fetchUserCalled = true
        viewModel?.getUser()
    }
    
    func updateUI(with user: UserListDatum) {
        nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        idLabel.text = "ID: \(user.id ?? 0)"
    }
    
    func handle(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presentedAlert = alert
        present(alert, animated: true, completion: nil)
    }
}
