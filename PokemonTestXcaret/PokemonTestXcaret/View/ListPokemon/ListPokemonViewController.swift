//
//  ListPokemonViewController.swift
//  PokemonTestXcaret
//
//  Created by Consultant on 1/4/23.
//

import UIKit

class ListPokemonViewController: UIViewController {

    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ListPokemonViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var lblCards: UILabel = {
        let lblCards = UILabel()
        lblCards.text = "Cards"
        lblCards.textColor = .white
        lblCards.font = .systemFont(ofSize: 18, weight: .semibold)
         return lblCards
    }()
    
    lazy var lblUltPok: UILabel = {
        let lblUltPok = UILabel()
        lblUltPok.text = "Ultra Pokemons"
        lblUltPok.textColor = .white
        lblUltPok.font = .systemFont(ofSize: 24, weight: .semibold)
         return lblUltPok
    }()
    
    let pokemonVM: PokemonViewModelType
    
    init(vm: PokemonViewModelType) {
        self.pokemonVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupUI()
        self.pokemonVM.bind {
            print("Test: 2")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.pokemonVM.getPokemons()
    }
    
    func setupUI() {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 15
        vStackView.axis = .vertical
        vStackView.distribution = .fill
           
        vStackView.addArrangedSubview(imageView)
        vStackView.addArrangedSubview(lblCards)
        vStackView.addArrangedSubview(lblUltPok)
        vStackView.addArrangedSubview(collectionView)
        
        view.addSubview(vStackView)
        
        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
//        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
//        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}

extension ListPokemonViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListPokemonViewCell
        cell.backgroundColor = .blue
        return cell
    }

}

extension ListPokemonViewController: UICollectionViewDelegate {
 
}

//extension ListPokemonViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width / 4, height: view.frame.width / 4)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//}

