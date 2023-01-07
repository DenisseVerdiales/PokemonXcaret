//
//  ListPokemonViewController.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/4/23.
//

import UIKit

class ListPokemonViewController: UIViewController {

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
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .none
        cv.layer.cornerRadius = 12
        cv.register(ListPokemonViewCell.self, forCellWithReuseIdentifier: ListPokemonViewCell.reusedId)
        return cv
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var lblCards: UILabel = {
        let lblCards = UILabel()
        lblCards.text = "Cards"
        lblCards.textColor = .white
        lblCards.textAlignment = .center
        lblCards.translatesAutoresizingMaskIntoConstraints = false
        lblCards.font = .systemFont(ofSize: 18, weight: .semibold)
         return lblCards
    }()
    
    lazy var lblUltPok: UILabel = {
        let lblUltPok = UILabel()
        lblUltPok.text = "Ultra Pokemons"
        lblUltPok.textColor = .white
        lblUltPok.textAlignment = .center
        lblUltPok.translatesAutoresizingMaskIntoConstraints = false
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
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapLogOut))
        self.navigationController?.view.tintColor = UIColor.white
        
        
        setupUI()
        self.pokemonVM.bind {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        self.pokemonVM.getPokemons()
        
    }
    
    override func viewDidLayoutSubviews() {
        setupScrollView()
        gradient.frame = view.bounds
    }
    
    @objc func didTapLogOut() {
        let dbManager = DatabaseManager()
        
        dbManager.signOut{[weak self] (success) in
            guard let self = self else {return}
            
            if success {
                let vc = LogInViewController(vm: self.pokemonVM)
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
    func setupScrollView(){
        scrollView.clipsToBounds = true
        scrollView.frame = view.bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 600)
   }
    
    func setupUI() {
        view.layer.addSublayer(gradient)
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(lblCards)
        scrollView.addSubview(lblUltPok)
        scrollView.addSubview(collectionView)
//
//        let vStackView = UIStackView()
//        vStackView.translatesAutoresizingMaskIntoConstraints = false
//        vStackView.spacing = 8
//        vStackView.axis = .vertical
//        vStackView.distribution = .fill
//
//        vStackView.addArrangedSubview(imageView)
//        vStackView.addArrangedSubview(lblCards)
//        vStackView.addArrangedSubview(lblUltPok)
//        vStackView.addArrangedSubview(collectionView)
        //contentView.addSubview(vStackView)
        //view.addSubview(vStackView)
        
//        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
//        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 270).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 60).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true
        
        lblCards.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        lblCards.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        lblCards.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true
        
        lblUltPok.topAnchor.constraint(equalTo: lblCards.bottomAnchor, constant: 8).isActive = true
        lblUltPok.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        lblUltPok.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: lblUltPok.bottomAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 60).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: 350).isActive = true
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
        return self.pokemonVM.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListPokemonViewCell.reusedId, for: indexPath) as! ListPokemonViewCell
    
        cell.configure(pokemonVM: self.pokemonVM, index: indexPath.row)
        return cell
    }

}

extension ListPokemonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = PokemonDetailCViewCell()
        detailVC.configure(pokemonVM: self.pokemonVM, index: indexPath.row)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    
       }
}

