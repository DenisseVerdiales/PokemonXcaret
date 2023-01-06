//
//  ListPokemonViewCell.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/4/23.
//

import UIKit

protocol PokemonCellErrorDelegate: AnyObject {
    func initiateErrorMsg(err: NetworkError)
}
class ListPokemonViewCell: UICollectionViewCell {
    static let reusedId = "\(ListPokemonViewCell.self)"
    
    var delegate: PokemonCellErrorDelegate?
    
    let network = NetworkManager()
    
    lazy var PokeImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "pok")
        imageView.layer.cornerRadius = 12
        imageView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    lazy var pokename: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "Pokemon Name"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    var pokemons: PokemonDetail?

    override init(frame: CGRect) {
       super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        setupUI()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fill
           
        vStackView.addArrangedSubview(PokeImage)
        vStackView.addArrangedSubview(pokename)
        
        self.contentView.addSubview(vStackView)
        vStackView.bindToSuperView()
    }
    
    func configure(pokemonVM: PokemonViewModelType, index: Int) {

        guard let name = pokemonVM.pokemonName(for: index) else {return}
       
        self.pokename.text = name
        guard let type = pokemonVM.pokemonType(for: index) else {return}
        self.PokeImage.backgroundColor = color(pokemonDetail: type)
        self.PokeImage.layer.borderColor = colorBorder(pokemonDetail: type)
        guard let abil = pokemonVM.pokemonAbilities(for: index) else {return}
      
        DispatchQueue.main.async {
            pokemonVM.getEffect(url: abil[0].ability.url)
        }
        
        pokemonVM.pokemonImage(for: index) { imageData in
            guard let imageData = imageData else { return }
            
            DispatchQueue.main.async {
                switch (name) {
                    case "bulbasaur":
                    self.PokeImage.image = UIImage(named: "bulbasaur")
                    case "charizard":
                    self.PokeImage.image = UIImage(named: "charizard")
                    case "squirtle":
                    self.PokeImage.image = UIImage(named: "squirtle")
                    case "pikachu":
                    self.PokeImage.image = UIImage(named: "pikachu")
                    default:
                    self.PokeImage.image = UIImage(data: imageData)
                }
            }
        }
    }
}
