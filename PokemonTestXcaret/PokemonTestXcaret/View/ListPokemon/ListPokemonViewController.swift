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
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ListPokemonViewCell.self, forCellWithReuseIdentifier: ListPokemonViewCell.reusedId)
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
        //setupUI()
        self.pokemonVM.bind {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        self.pokemonVM.getPokemons()
        
    }
    
    override func viewDidLayoutSubviews() {
        setupScrollView()
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
        setupUI()
   }
    
    func setupUI() {
        
        contentView.addSubview(imageView)
//        contentView.addSubview(lblCards)
//        contentView.addSubview(lblUltPok)
//
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 15
        vStackView.axis = .vertical
        vStackView.distribution = .fill
           
//        vStackView.addArrangedSubview(imageView)
//        vStackView.addArrangedSubview(lblCards)
//        vStackView.addArrangedSubview(lblUltPok)
//        vStackView.addArrangedSubview(collectionView)
//        contentView.addSubview(vStackView)
        //view.addSubview(vStackView)
        
//        vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
//        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
//        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        
//        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
//        collectionView.delegate = self
//        collectionView.dataSource = self
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
       // cell.backgroundColor = .blue
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

