//
//  SignUpViewController.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/3/23.
//

import UIKit

class SignUpViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var txtUser: UITextField = {
        let txtUser = UITextField()
        txtUser.autocapitalizationType = .none
        txtUser.autocorrectionType = .no
        txtUser.returnKeyType = .continue
        txtUser.layer.cornerRadius = 12
        txtUser.layer.borderWidth = 1
        txtUser.layer.borderColor = UIColor.black.cgColor
        txtUser.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#5C98DB")]
        )
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        txtUser.leftViewMode = .always
       // txtUser.backgroundColor = .secondarySystemBackground
        return txtUser
          
      }()
    lazy var txtUserConfirm: UITextField = {
        let txtUser = UITextField()
        txtUser.autocapitalizationType = .none
        txtUser.autocorrectionType = .no
        txtUser.returnKeyType = .continue
        txtUser.layer.cornerRadius = 12
        txtUser.layer.borderWidth = 1
        txtUser.layer.borderColor = UIColor.black.cgColor
        txtUser.attributedPlaceholder = NSAttributedString(
            string: "Confirm email",
            attributes: [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#5C98DB")]
        )
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        txtUser.leftViewMode = .always
       // txtUser.backgroundColor = .secondarySystemBackground
        return txtUser
          
      }()
    
    lazy var txtPassword: UITextField = {
        let txtPassword = UITextField()
        txtPassword.autocapitalizationType = .none
        txtPassword.autocorrectionType = .no
        txtPassword.returnKeyType = .done
        txtPassword.layer.cornerRadius = 12
        txtPassword.layer.borderWidth = 1
        txtPassword.layer.borderColor = UIColor.black.cgColor
        txtPassword.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#5C98DB")]
        )
        txtPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        txtPassword.leftViewMode = .always
       // txtPassword.backgroundColor = .secondarySystemBackground
        txtPassword.isSecureTextEntry = true
          
        return txtPassword
      }()
    
    lazy var btnSignUp: UIButton = {
        let btnSignUp = UIButton()
        btnSignUp.setTitle("Sign Up", for: .normal)
        btnSignUp.backgroundColor =  hexStringToUIColor(hex: "#F9C623")
        btnSignUp.setTitleColor(.white, for: .normal)
        btnSignUp.layer.cornerRadius = 12
        btnSignUp.layer.masksToBounds = true
        btnSignUp.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        btnSignUp.addTarget(self, action: #selector(btnRegisterUser), for: .touchUpInside)

        return btnSignUp
       }()
    
 
    
    lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "Error"
        label.textColor = .systemRed
          
          return label
      }()
    
    let pokemonVM: PokemonViewModelType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
       // self.setupTopView()
        self.setUpUI()
        self.setUpElements()
    }
    
    init(vm: PokemonViewModelType) {
        self.pokemonVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpElements(){
        self.errorLabel.alpha = 0
    }

    private func setUpUI(){

        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 15
        vStackView.axis = .vertical
        vStackView.distribution = .fill
           
        vStackView.addArrangedSubview(imageView)
        vStackView.addArrangedSubview(txtUser)
        vStackView.addArrangedSubview(txtUserConfirm)
        vStackView.addArrangedSubview(txtPassword)
        vStackView.addArrangedSubview(errorLabel)
        vStackView.addArrangedSubview(btnSignUp)
         
        view.addSubview(vStackView)
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        txtUser.heightAnchor.constraint(equalToConstant: 52).isActive = true
        txtUserConfirm.heightAnchor.constraint(equalToConstant: 52).isActive = true
        txtPassword.heightAnchor.constraint(equalToConstant: 52).isActive = true
        btnSignUp.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
       // vStackView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        
    }
    
    func validateFields() -> result?{
        var data: result?
        
        if txtUser.text?.trimmingCharacters(in: .whitespacesAndNewlines) != txtUserConfirm.text?.trimmingCharacters(in: .whitespacesAndNewlines){
         
            data = result(msg: "email doest'n match", status: false)
        }
        
        let cleanedPassword = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
         
            data = result(msg: "Please make sure your password is at least 8 characters, contains a special character and number", status: false)
        }
        
        return data
    }
  
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func showLogIn(){
        let vc = LogInViewController(vm: pokemonVM)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnRegisterUser(){
        let signupMaganer = DatabaseManager()
        
        let error = validateFields()

        txtUser.resignFirstResponder()
        txtPassword.resignFirstResponder()
        guard (error?.status) != false else {
            self.showError(error?.message ?? "")
              return
        }

        let email = txtUser.text ?? "", password = txtPassword.text ?? ""

        signupMaganer.createUser(with: email, password: password){[weak self] (success) in
            guard let self = self else {return}
            var message: String = ""
            
            message = success ? "User was sucessfully created" : "There was an error"
           
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
            
            if success {
                self.txtUser.text = ""
                self.txtUserConfirm.text = ""
                self.txtPassword.text = ""
                self.navigationController?.popViewController(animated: true)
//                let vc = LogInViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
                //self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
