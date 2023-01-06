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
            hexStringToUIColor(hex: "#OE4537E").cgColor
        ]
        gradient.locations = [0.5, 0.5]
        return gradient
    }()
    
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
        txtPassword.layer.borderColor = UIColor.black.cgColor
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
        btnSignUp.setTitleColor(.black, for: .normal)
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
        view.backgroundColor = .white
       
        self.setUpUI()
    }
    
    init(vm: PokemonViewModelType) {
        self.pokemonVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 600)
        setUpUI()
   }
    
    private func setUpUI(){

        self.errorLabel.alpha = 0
        
//        gradient.frame = view.bounds
//        view.layer.addSublayer(gradient)
//
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 15
        vStackView.axis = .vertical
        vStackView.distribution = .fill
           
        vStackView.addArrangedSubview(imageView)
        vStackView.addArrangedSubview(txtUser)
        vStackView.addArrangedSubview(txtPassword)
        vStackView.addArrangedSubview(errorLabel)
        vStackView.addArrangedSubview(btnLogIn)
        vStackView.addArrangedSubview(btnSignUp)
         
        view.addSubview(vStackView)
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: txtUser.topAnchor, constant: -20).isActive = true
        txtUser.heightAnchor.constraint(equalToConstant: 52).isActive = true
        txtPassword.heightAnchor.constraint(equalToConstant: 52).isActive = true
        btnLogIn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
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
                self.txtUser.text = ""
                self.txtPassword.text = ""
                
                let vc = ListPokemonViewController(vm: self.pokemonVM)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @objc func btnSignUpOpc(){
        let vc = SignUpViewController(vm: self.pokemonVM)
        vc.title = "Create Account"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
