//
//  ViewController.swift
//  MVVM+R&D
//
//  Created by SAHIL AMRUT AGASHE on 12/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var loginVM = LoginViewModel()
    
    private lazy var usernameTextField: UITextField = {
        let usernameTextField = BindingTextField()
        usernameTextField.placeholder = "Enter Username"
        usernameTextField.backgroundColor = .lightGray
        usernameTextField.borderStyle = .roundedRect
        // for view to viewModel binding
        usernameTextField.bind { [weak self] text in
            self?.loginVM.username.value = text
        }
        return usernameTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = BindingTextField()
        //passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.backgroundColor = .gray
        passwordTextField.borderStyle = .roundedRect
        // for view to viewModel binding
        passwordTextField.bind { [weak self] text in
            self?.loginVM.password.value = text
        }
        return passwordTextField
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for viewModel to view binding
        loginVM.username.bind {[weak self] text in
            self?.usernameTextField.text = text
        }
        
        // for viewModel to view binding
        loginVM.password.bind { [weak self] text in
            self?.passwordTextField.text = text
        }
        
        setupUI()
    }
    
    // MARK: - Selectors
    @objc private func login() {
        print("DEBUG \(#function) called...")
        print("loginVM.username.value ==> \(loginVM.username.value), loginVM.password.value ==> \(loginVM.password.value)")
    }
    
    @objc private func fetchLoginInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.loginVM.username.value = "Roman Reings"
            self?.loginVM.password.value = "1234567890"
        }
    }
    
    // MARK: - Helpers
    private func setupUI() {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        let fetchLoginInfoButton = UIButton()
        fetchLoginInfoButton.setTitle("Fetch Login Info", for: .normal)
        fetchLoginInfoButton.backgroundColor = .blue
        fetchLoginInfoButton.addTarget(self, action: #selector(fetchLoginInfo), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, fetchLoginInfoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}

