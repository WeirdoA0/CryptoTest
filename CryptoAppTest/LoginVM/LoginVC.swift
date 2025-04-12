//
//  LoginVC.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private let viewModel = LoginVM()
    
    //MARK: Subviews
    
    private lazy var loginField: UITextField = {
       let field = UITextField()
        
        field.delegate = self
        field.placeholder = "Username"
        field.text = "1234"
        field.font = UIFont.systemFont(ofSize: 30)
        field.textColor = .black
        return field
    }()
    
    private lazy var passwordField: UITextField = {
       let field = UITextField()
        
        field.delegate = self
        field.placeholder = "Password"
        field.text = "1234"
        field.font = UIFont.systemFont(ofSize: 30)
        field.textColor = .black
        field.isSecureTextEntry = true
        return field
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(loginField)
        stackView.addArrangedSubview(passwordField)
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.addAction(
            UIAction { [weak  self] _ in
                self?.loginButtonAction()
        },
            for: .touchUpInside)
        return btn
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        tuneView()
    }
    
    //MARK: View Setup
    
    private func layout() {
        
        [stackView,loginButton].forEach{
            view.addSubview($0)
        }
        
        let height = 80
        
        
        let widthInset = -40
        
        loginButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width).offset(widthInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.height.equalTo(height)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(loginButton.snp.width)
            make.bottom.equalTo(loginButton.snp.top).offset(-40)
            make.height.equalTo(height * 2 + 20)
        }
    }
    
    private func tuneView() {
        view.backgroundColor = .systemGray4
        stackView.arrangedSubviews.forEach {
            $0.backgroundColor = .white
        }
        loginButton.backgroundColor = .black
        loginButton.tintColor = .white
        
        [loginField, passwordField, loginButton].forEach {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 20
    }
    
    //MARK: Actions
    
    private func loginButtonAction() {
        if viewModel.checkPassword(
            userName: loginField.text ?? "",
            password: passwordField.text ?? ""
        ) {
            navigationController?.setViewControllers([MainVC()], animated: true)
        } else {
            let alert = UIAlertController()

            alert.title = "Введены неправильный логин или пароль"
            let repeatAction = UIAlertAction(title: "Повторить", style: .default)
            
            let canceltAction = UIAlertAction(title: "Отменить", style: .cancel) { [weak self] _ in
                self?.loginField.text?.removeAll()
                self?.passwordField.text?.removeAll()
            }
            
            [repeatAction,canceltAction].forEach {
                alert.addAction($0)
            }
            
            present(alert, animated: true)
        }
    }
}

//MARK: TextFieldDelegate

// Делегат UITextFieldDelegate, иначе кнопка return на клавиатуре не сработает
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
}
