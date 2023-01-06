//
//  DetailViewController.swift
//  PokemonTestXcaret
//
//  Created by Consultant on 1/5/23.
//

import UIKit

class DetailViewController: UIViewController {

    
    lazy var pokemonDetailTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        //table.dataSource = self
      //  table.delegate = self
        table.register(PokemonDetailCViewCell.self, forCellReuseIdentifier: PokemonDetailCViewCell.reusedId)
        return table
        
    }()
    lazy var movesButtonView: UIButton = {
        let btnStart = UIButton(frame: .zero)
        btnStart.translatesAutoresizingMaskIntoConstraints = false
        btnStart.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnStart.backgroundColor = .white
        btnStart.setTitle("Moves", for: .normal)
        btnStart.setTitleColor(.black, for: .normal)
        btnStart.layer.cornerRadius = 5
        btnStart.addTarget(self, action: #selector(movesButtonPressed), for: .touchUpInside)
        
        return btnStart
    }()
    
    
    var pokemonVM: PokemonViewModelType
    
    init(vm: PokemonViewModelType) {
        self.pokemonVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
//    func configure(with pokDetail: PokemonViewModelType) {
//        self.pokemonVM = pokDetail
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
    }
    
    func setTableView(){
        self.view.addSubview(self.pokemonDetailTable)
        self.view.addSubview(self.movesButtonView)
        self.movesButtonView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.movesButtonView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.movesButtonView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.movesButtonView.topAnchor.constraint(equalTo: pokemonDetailTable.bottomAnchor, constant: -8).isActive = true
        self.movesButtonView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        self.pokemonDetailTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.pokemonDetailTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.pokemonDetailTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.pokemonDetailTable.bottomAnchor.constraint(equalTo: movesButtonView.topAnchor, constant: -8).isActive = true
        //self.pokemonDetailTable.bindToSuperViewDetail()
    }
    
    @objc
      func movesButtonPressed() {
   
         // self.presentMovesAlert(moves: self.pokemonDetail[0])
      }
     
    func presentMovesAlert(moves: PokemonDetail?) {
         
        // guard let moves = moves else { return }
            
//        let movePokemon = moves.moves.compactMap{$0.move.name}.reduce(""){partialResult, movePok in
//             return partialResult + movePok + "\n"
//         }
        
//        let detailView = MovesViewController(pokemonMoves: moves)
//        self.navigationController?.pushViewController(detailView, animated: true)
        

            
     }
}


//extension DetailViewController : UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//  //  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailCViewCell.reusedId, for: indexPath) as? PokemonDetailCViewCell else {return UITableViewCell()}
////        //self.view.backgroundColor = color(pokemonDetail: self.pokemonDetail[indexPath.row])
////        cell.configure(pokemonVM: self.pokemonVM, index: indexPath.row)
////
////        return cell
//   // }
//
//
//}
