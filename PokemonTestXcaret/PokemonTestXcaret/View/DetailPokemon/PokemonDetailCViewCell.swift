//
//  PokemonDetailCViewCell.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/5/23.
//

import UIKit

class PokemonDetailCViewCell: UIViewController {
    
    static let reusedId = "\(PokemonDetailCViewCell.self)"
    //let pokemonVM: PokemonViewModelType
    let NetManager = NetworkManager()
    
    lazy var progImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "pok")
        
        return imageView
    }()
    
    lazy var progTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Pokemon Name"
        
        return label
    }()
    
    lazy var progAbilitieLabel0: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = ""
        label.backgroundColor = .white
        label.layer.borderWidth = 2.0
        
        return label
    }()
    
    lazy var progAbilitieLabel1: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = ""
        label.backgroundColor = .white
        label.layer.borderWidth = 2.0
        
        return label
    }()
    
    
    lazy var progBottomLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.text = "Pokemon info info info"
        
        return label
    }()
    lazy var progressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Progress 1"
        
        return label
    }()
    lazy var progressLabel2: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 2"
        
        return label
    }()
    lazy var progressLabel3: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 3"
        
        return label
    }()
    lazy var progressLabel4: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 4"
        
        return label
    }()
    lazy var progressLabel5: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 5"
        
        return label
    }()
    lazy var progressLabel6: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "Progress 6"
        
        return label
    }()
    lazy var lblEffect: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .max
        label.textAlignment = NSTextAlignment.justified
        label.font = label.font.withSize(14)
        label.text = "effect"
        
        return label
    }()
    lazy var progProgress: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress2: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress3: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress4: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress5: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    
    lazy var progProgress6: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progress.progressTintColor = .systemCyan
        progress.progress = 0.5
        progress.progressViewStyle = .bar
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 5
        
        return progress
    }()
    

    override func viewDidLoad() {
        setUpUI()
        view.backgroundColor = .white
    }
    
    func configure(pokemonVM: PokemonViewModelType, index: Int) {
      
        guard let name = pokemonVM.pokemonName(for: index) else {return}
        
        pokemonVM.pokemonImage(for: index) { imageData in
            guard let imageData = imageData else { return }
            
            DispatchQueue.main.async {
                switch (name) {
                    case "bulbasaur":
                    self.progImageView.image = UIImage(named: "bulbasaur")
                    case "charizard":
                    self.progImageView.image = UIImage(named: "charizard")
                    case "squirtle":
                    self.progImageView.image = UIImage(named: "squirtle")
                    case "pikachu":
                    self.progImageView.image = UIImage(named: "pikachu")
                    default:
                    self.progImageView.image = UIImage(data: imageData)
                }
                
                self.progTopLabel.text = name
                
                guard let stats = pokemonVM.pokemonStats(for: index) else {return}
             
                guard let hp = stats[0].stat?.name else {return}
                guard let hpValue = stats[0].baseStat else {return}
                self.progressLabel.text = "\(hp) \(hpValue)".uppercased()
                self.progressLabel.textColor = color(pokemonDetail: name)
               
                guard let effect = pokemonVM.pokemonEffect(for: index) else {return}
               
                self.lblEffect.text = effect
                guard let attack = stats[1].stat?.name, let attackValue = stats[1].baseStat else {return}
                self.progressLabel2.text = "\(attack) : \(attackValue)"
                guard let defense = stats[2].stat?.name, let defenseValue = stats[2].baseStat else {return}
                self.progressLabel3.text = "\(defense) : \(defenseValue)"
                guard let special = stats[3].stat?.name, let specialValue = stats[3].baseStat else {return}
                self.progressLabel4.text = "\(special) : \(specialValue)"
                guard let specialD = stats[4].stat?.name, let specialDValue = stats[4].baseStat else {return}
                self.progressLabel5.text = "\(specialD) : \(specialDValue)"
                guard let speed = stats[5].stat?.name, let speedValue = stats[5].baseStat else {return}
                self.progressLabel6.text = "\(speed) : \(speedValue)"

               
                self.progProgress2.progress = Float((stats[1].baseStat ?? Int(0.0))) * 0.01
                self.progProgress3.progress = Float((stats[2].baseStat ?? Int(0.0))) * 0.01
                self.progProgress4.progress = Float((stats[3].baseStat ?? Int(0.0))) * 0.01
                self.progProgress5.progress = Float((stats[4].baseStat ?? Int(0.0))) * 0.01
                self.progProgress6.progress = Float((stats[5].baseStat ?? Int(0.0))) * 0.01

            }
        }
    
    }
    
    
    private func setUpUI(){
     
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical

        vStackView.addArrangedSubview(self.progImageView)
        vStackView.addArrangedSubview(self.progTopLabel)
        vStackView.addArrangedSubview(progressLabel)
        
        let vProgStackView = UIStackView(frame: .zero)
        vProgStackView.translatesAutoresizingMaskIntoConstraints = false
        vProgStackView.spacing = 0
        vProgStackView.alignment = .center
        vProgStackView.distribution = .equalCentering
        vProgStackView.axis = .vertical
        
        vProgStackView.addArrangedSubview(self.progProgress2)
        vProgStackView.addArrangedSubview(self.progProgress3)
        vProgStackView.addArrangedSubview(self.progProgress4)
        vProgStackView.addArrangedSubview(self.progProgress5)
        vProgStackView.addArrangedSubview(self.progProgress6)
        
        
        let vProgLblStackView = UIStackView(frame: .zero)
        vProgLblStackView.translatesAutoresizingMaskIntoConstraints = false
        vProgLblStackView.spacing = 0
        vProgLblStackView.distribution = .equalCentering
        vProgLblStackView.axis = .vertical
        
        vProgLblStackView.addArrangedSubview(self.progressLabel2)
        vProgLblStackView.addArrangedSubview(self.progressLabel3)
        vProgLblStackView.addArrangedSubview(self.progressLabel4)
        vProgLblStackView.addArrangedSubview(self.progressLabel5)
        vProgLblStackView.addArrangedSubview(self.progressLabel6)
        
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.spacing = 0
        hStackView.axis = .horizontal
        hStackView.backgroundColor = .cyan
        hStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        hStackView.addArrangedSubview(vProgStackView)
        hStackView.addArrangedSubview(vProgLblStackView)
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(lblEffect)
        
        self.progImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true

        self.progTopLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.progTopLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true

        self.progressLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.progressLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.progProgress2.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.progProgress2.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress3.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.progProgress3.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress4.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.progProgress4.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress5.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.progProgress5.widthAnchor.constraint(equalToConstant: 110).isActive = true

        self.progProgress6.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.progProgress6.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        self.lblEffect.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(vStackView)
        vStackView.bindToSuperView()
      }
}
