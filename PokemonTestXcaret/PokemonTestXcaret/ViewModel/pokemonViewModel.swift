//
//  pokemonViewModel.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/3/23.
//

import Foundation
import CoreData

protocol PokemonViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getPokemons()
    func getEffect(url: String)
}

protocol PokemonViewModelAttributes {
    var count: Int { get }
    func pokemonName(for index: Int) -> String?
    func pokemonType(for index: Int) -> String?
    func pokemonStats(for index: Int) -> [Stats]?
    func pokemonAbilities(for index: Int) -> [Abilities]?
    func pokemonEffect(for index: Int) -> String?
    func pokemonImage(for index: Int, completion: @escaping (Data?) -> Void)
}

typealias PokemonViewModelType = PokemonViewModelCore & PokemonViewModelAttributes

class PokemonViewModel {
    var manager: CoreDataManager
    
    private var pokemons: [PokemonDetail] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    private var pokemonsCoreData: [Pokemons]? = [] {
        didSet {
            self.updateHandlerCoreData?()
        }
    }
    private var pokemonsEffect: [EffectLink] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    var pokemonUrl: Pokemonapi?
    private var networkManager: NetworkService
    private var pageCount = 1
    private let cache: ImageCache
    
    private var updateHandler: (() -> Void)?
    private var updateHandlerCoreData: (() -> Void)?
    
    init(networkManager: NetworkService, cache: ImageCache = ImageCache(), manager: CoreDataManager = CoreDataManager(cache: ImageCache())) {
        self.networkManager = networkManager
        self.cache = cache
        self.manager = manager
    }

}

extension PokemonViewModel: PokemonViewModelCore {
    
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
    
    func getPokemonsCD() -> [Pokemons] {
        let result = self.manager.getPokemons()
        return result
    }
    
    func getPokemons() {
        if self.pageCount == 1 {
            self.pokemons = []
        }
        
        self.networkManager.getModel(url: NetworkParams.pokemons.url) { (result: Result<Pokemonapi, NetworkError>) in
            switch result {
            case .success(let page):
                self.pokemonUrl = page
                for pokemonResource in page.results {
                    guard let url = URL(string: pokemonResource.url) else { return }
                    self.networkManager.getModel(url: url) { (pokeResult: Result<PokemonDetail, NetworkError>) in
                        switch pokeResult {
                            case .success(let pokemon):
                            self.pokemons.append(pokemon)
                            self.manager.savePokemonsDetail(pok: pokemon)

                        case .failure(let error):
                                print(error)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getEffect(url: String) {
        guard let url = URL(string: url) else {return}
        
        self.networkManager.getModel(url: url) { (result: Result<EffectLink, NetworkError>) in
            switch result {
            case .success(let page):
                self.pokemonsEffect.append(page)
                self.manager.savePokemonsEffect(effect: page)
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

    func pokemonType(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.pokemons[index].types[0].type.name
    }
    
    func pokemonStats(for index: Int) -> [Stats]? {
        guard index < self.count else { return nil }
        return self.pokemons[index].stats
    }
    
    func pokemonAbilities(for index: Int) -> [Abilities]? {
        guard index < self.count else { return nil }
        return self.pokemons[index].abilities
    }
    
    func pokemonEffect(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.pokemonsEffect[index].effectEntries[0].effect
    }
    func getPokemonsCoreData() {
        self.pokemonsCoreData = self.manager.fetchPokemons()
    }
    
    func pokemonImage(for index: Int, completion: @escaping (Data?) -> Void) {
        
        guard index < self.count else {
            completion(nil)
            return
        }
 
        // Check ImageCache
        if let imageData = self.cache.getImageData(key: String(self.pokemons[index].id)) {
            completion(imageData)
            return
        }
        
        // Else call network
        self.networkManager.getRawData(url: NetworkParams.pokemonImage(String(self.pokemons[index].id)).url) { result in
            switch result {
            case .success(let imageData):
                self.cache.setImageData(data: imageData, key: String(self.pokemons[index].id))
                self.manager.savePokemonsImg(pok: String(self.pokemons[index].id))
                completion(imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

