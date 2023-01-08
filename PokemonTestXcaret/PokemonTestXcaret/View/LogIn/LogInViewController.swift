//
//  LogInViewController.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/3/23.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            hexStringToUIColor(hex: "#5C98DB").cgColor,
            hexStringToUIColor(hex: "#0E437E").cgColor
        ]
        gradient.locations = [0.0, 1.0]
        return gradient
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    lazy var txtUser: UITextField = {
        let txtUser = UITextField()
        txtUser.autocapitalizationType = .none
        txtUser.autocorrectionType = .no
        txtUser.returnKeyType = .continue
        txtUser.layer.cornerRadius = 12
        txtUser.layer.borderWidth = 1
        txtUser.translatesAutoresizingMaskIntoConstraints = false
        txtUser.layer.borderColor = hexStringToUIColor(hex: "#064376").cgColor
        txtUser.backgroundColor = .white
        txtUser.attributedPlaceholder = NSAttributedString(
            string: "UserName",
            attributes: [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#5C98DB")]
        )
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        txtUser.leftViewMode = .always
        return txtUser
          
      }()
    
    lazy var txtPassword: UITextField = {
        let txtPassword = UITextField()
        txtPassword.autocapitalizationType = .none
        txtPassword.autocorrectionType = .no
        txtPassword.returnKeyType = .done
        txtPassword.layer.cornerRadius = 12
        txtPassword.layer.borderWidth = 1
        txtPassword.translatesAutoresizingMaskIntoConstraints = false
        txtPassword.layer.borderColor = hexStringToUIColor(hex: "#064376").cgColor
        txtPassword.backgroundColor = .white
        txtPassword.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#5C98DB")]
        )
        txtPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        txtPassword.leftViewMode = .always
        txtPassword.isSecureTextEntry = true
          
        return txtPassword
      }()
    
    lazy var btnLogIn: UIButton = {
        let btnLogIn = UIButton()
        btnLogIn.translatesAutoresizingMaskIntoConstraints = false
        btnLogIn.setTitle("Sign In", for: .normal)
        btnLogIn.backgroundColor =  hexStringToUIColor(hex: "#F9C623")
        btnLogIn.setTitleColor(.white, for: .normal)
        btnLogIn.layer.cornerRadius = 12
        btnLogIn.layer.masksToBounds = true
        btnLogIn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btnLogIn.addTarget(self, action: #selector(btnLoginOpc), for: .touchUpInside)

        return btnLogIn
       }()
    
    lazy var btnSignUp: UIButton = {
        let btnSignUp = UIButton(frame: .zero)
        btnSignUp.translatesAutoresizingMaskIntoConstraints = false
        btnSignUp.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnSignUp.setTitle("Sign Up", for: .normal)
        btnSignUp.setTitleColor(.white, for: .normal)
        btnSignUp.layer.cornerRadius = 3
        btnSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btnSignUp.addTarget(self, action: #selector(btnSignUpOpc), for: .touchUpInside)

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
         self.setUpUI()

        guard UserDefaults.standard.value(forKey: "email") != nil else {return}
        if UserDefaults.standard.value(forKey: "email") as! String != ""{
            let vc = ListPokemonViewController(vm: self.pokemonVM)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        setupScrollView()
        gradient.frame = view.bounds
    }
    
    init(vm: PokemonViewModelType) {
        self.pokemonVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView(){
        scrollView.clipsToBounds = true
        scrollView.frame = view.bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 600)
   }
    
    private func setUpUI(){

        self.errorLabel.alpha = 0
    
        view.layer.addSublayer(gradient)
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(txtUser)
        scrollView.addSubview(txtPassword)
        scrollView.addSubview(errorLabel)
        scrollView.addSubview(btnLogIn)
        scrollView.addSubview(btnSignUp)
        
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 270).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 60).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true
        
        txtUser.heightAnchor.constraint(equalToConstant: 52).isActive = true
        txtUser.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60).isActive = true
        txtUser.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 55).isActive = true
        txtUser.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true

        txtPassword.heightAnchor.constraint(equalToConstant: 52).isActive = true
        txtPassword.topAnchor.constraint(equalTo: txtUser.bottomAnchor, constant: 8).isActive = true
        txtPassword.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 55).isActive = true
        txtPassword.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 8).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 55).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true

        btnLogIn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        btnLogIn.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 60).isActive = true
        btnLogIn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 55).isActive = true
        btnLogIn.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true

        btnSignUp.topAnchor.constraint(equalTo: btnLogIn.bottomAnchor, constant: 8).isActive = true
        btnSignUp.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 55).isActive = true
        btnSignUp.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true
    }
    
    func validateFields() -> result?{
        var data: result?
        
        if txtUser.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            data = result(msg: "Please fill in all fields", status: false)
        }
       
        return data
    }

    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @objc func btnLoginOpc(){
  
        let error = validateFields()
        let dbManager = DatabaseManager()

        txtUser.resignFirstResponder()
        txtPassword.resignFirstResponder()
        guard (error?.status) != false else {
            self.showError(error?.message ?? "")
              return
        }

        let user = txtUser.text ?? "", password = txtPassword.text ?? ""
        
        dbManager.signIn(email: user, password: password) {[weak self] (success) in
            guard let self = self else {return}
            
            if success {
                UserDefaults.standard.set(self.txtUser.text, forKey: "email")
                self.txtUser.text = ""
                self.txtPassword.text = ""
                
                let vc = ListPokemonViewController(vm: self.pokemonVM)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showError("The password is invalid or the user does not have a password.")
            }
        }
        
    }
    
    @objc func btnSignUpOpc(){
        let vc = SignUpViewController(vm: self.pokemonVM)
        vc.title = "Create Account"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
