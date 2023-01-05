//
//  pokemonViewModel.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/3/23.
//

import Foundation


protocol PokemonViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getPokemons()
}

protocol PokemonViewModelAttributes {
    var count: Int { get }
    func pokemonName(for index: Int) -> String?
    //func pokemonImage(for index: Int, completion: @escaping (Data?) -> Void)
}

typealias PokemonViewModelType = PokemonViewModelCore & PokemonViewModelAttributes

class PokemonViewModel {
    
    private var pokemons: [Pokemon] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    private var networkManager: NetworkService
    private var pageCount = 1
   // private let cache: ImageCache
    
    private var updateHandler: (() -> Void)?
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
       // self.cache = cache
    }

}

extension PokemonViewModel: PokemonViewModelCore {
    
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    
    func getPokemons() {
        if self.pageCount == 1 {
            self.pokemons = []
        }
        
        self.networkManager.getModel(url: NetworkParams.pokemons.url) { (result: Result<Pokemonapi, NetworkError>) in
            switch result {
            case .success(let page):
                self.pageCount += 1
                print("Test: 4")
                print(page.results)
                self.pokemons.append(contentsOf: page.results)
                for pokemonResource in page.results {
                   // myGroup.enter()
                    guard let url = URL(string: pokemonResource.url) else { return }
                    self.networkManager.getModel(url: url) { (pokeResult: Result<Pokemon, NetworkError>) in
                        switch pokeResult {
                            case .success(let pokemon):
                            print("POKEMONS \(pokemon)")
                                self.pokemons.append(pokemon)
                              
                               // myGroup.leave()

                            case .failure(let error):
                                print("OOPS! We screwed up.")
                                print(error)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension PokemonViewModel: PokemonViewModelAttributes {
    
    var count: Int {
        return self.pokemons.count
    }
    
    func pokemonName(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.pokemons[index].name
    }
    

    
}

