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
    func bindCoreData(updateHandler: @escaping () -> Void)
    func getPokemons()
    func getEffect(url: String)
    func getPokemonsCD()
}

protocol PokemonViewModelAttributes {
    var count: Int { get }
    var countCoreData: Int { get }
    func pokemonName(for index: Int) -> String?
    func pokemonType(for index: Int) -> String?
    func pokemonStats(for index: Int) -> [Stats]?
    func pokemonAbilities(for index: Int) -> [Abilities]?
    func pokemonEffect(for index: Int) -> String?
    func pokemonImage(for index: Int, completion: @escaping (Data?) -> Void)
    func pokemonNameCD(for index: Int) -> String?
    func pokemonTypeCD(for index: Int) -> String?
    func pokemonStatsHpCD(for index: Int) -> Int?
    func pokemonStatsAttackCD(for index: Int) -> Int?
    func pokemonStatsDefenseCD(for index: Int) -> Int?
    func pokemonStatsSpecDefenseCD(for index: Int) -> Int?
    func pokemonStatsSpecAttackCD(for index: Int) -> Int?
    func pokemonStatsSpeedCD(for index: Int) -> Int?
    func pokemonEffectCD(for index: Int) -> String?
    func pokemonImgCD(for index: Int) -> Data?
}

typealias PokemonViewModelType = PokemonViewModelCore & PokemonViewModelAttributes

class PokemonViewModel {
    var manager: CoreDataManager
    
    private var pokemons: [PokemonDetail] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    private var pokemonsCoreData: [Pokemons] = [] {
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
    
    func bindCoreData(updateHandler: @escaping () -> Void) {
        self.updateHandlerCoreData = updateHandler
    }
    
    func getPokemonsCD() {
        let values = self.manager.getPokemons()
        self.pokemonsCoreData.append(contentsOf: values )
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
                            let url =  String(pokemon.id)
                            let imageData = self.cache.getImageData(key: url)
                            if imageData == nil {
                                
                                let values =  self.manager.getPokemons()
                                self.networkManager.getRawData(url: NetworkParams.pokemonImage(url).url) { result in
                                    switch result {
                                    case .success(let image):
                                        self.cache.setImageData(data: image, key: url)
                                        if values.count >= 0 || values.count < 20 {
                                            self.manager.savePokemonsDetail(pok: pokemon, img: image, effect: pokemon.abilities[0].ability.name)
                                        }
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
    
    var countCoreData: Int {
        return self.pokemonsCoreData.count
    }
    
    func pokemonName(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.pokemons[index].name
    }
    
    func pokemonNameCD(for index: Int) -> String? {
        guard index < self.countCoreData else { return nil }
        return self.pokemonsCoreData[index].name
    }

    func pokemonType(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.pokemons[index].types[0].type.name
    }
    
    func pokemonTypeCD(for index: Int) -> String? {
        guard index < self.countCoreData else { return nil }
        return self.pokemonsCoreData[index].type
    }
    
    func pokemonStats(for index: Int) -> [Stats]? {
        guard index < self.count else { return nil }
        return self.pokemons[index].stats
    }
    
    func pokemonStatsHpCD(for index: Int) -> Int? {
        guard index < self.countCoreData else { return nil }
        return Int(self.pokemonsCoreData[index].hp)
    }
    
    func pokemonStatsAttackCD(for index: Int) -> Int? {
        guard index < self.countCoreData else { return nil }
        return Int(self.pokemonsCoreData[index].attack)
    }
    
    func pokemonStatsDefenseCD(for index: Int) -> Int? {
        guard index < self.countCoreData else { return nil }
        return Int(self.pokemonsCoreData[index].defense)
    }
    
    func pokemonStatsSpecDefenseCD(for index: Int) -> Int? {
        guard index < self.countCoreData else { return nil }
        return Int(self.pokemonsCoreData[index].specialDefense)
    }
    
    func pokemonStatsSpecAttackCD(for index: Int) -> Int? {
        guard index < self.countCoreData else { return nil }
        return Int(self.pokemonsCoreData[index].specialAttack)
    }
    
    func pokemonStatsSpeedCD(for index: Int) -> Int? {
        guard index < self.countCoreData else { return nil }
        return Int(self.pokemonsCoreData[index].speed)
    }
    
    func pokemonEffectCD(for index: Int) -> String? {
        guard index < self.countCoreData else { return nil }
        return self.pokemonsCoreData[index].effect
    }
    
    func pokemonImgCD(for index: Int) -> Data? {
        guard index < self.countCoreData else { return nil }
        return self.pokemonsCoreData[index].img
    }
    
    func pokemonAbilities(for index: Int) -> [Abilities]? {
        guard index < self.count else { return nil }
        return self.pokemons[index].abilities
    }
    
    func pokemonEffect(for index: Int) -> String? {
        guard index < self.count else { return nil }
        return self.pokemonsEffect[index].effectEntries[0].effect
    }

    func pokemonImage(for index: Int, completion: @escaping (Data?) -> Void) {
        
        guard index < self.count else {
            completion(nil)
            return
        }

        let url =  String(self.pokemons[index].id)
        if let imageData = self.cache.getImageData(key: url) {
            completion(imageData)
            return
        }
        
    }
}

