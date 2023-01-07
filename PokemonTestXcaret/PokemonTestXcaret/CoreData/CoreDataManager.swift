//
//  CoreDataManager.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/6/23.
//

import Foundation
import CoreData

class CoreDataManager {
    private let cache: ImageCache
    
    init(cache: ImageCache) {
        self.cache = cache
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonTestXcaret")
        container.loadPersistentStores{(description, error) in
            if let _ = error {
                fatalError("Error")
            }
        }
        return container
    }()

    func fetchPokemons() -> [Pokemons]?{
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<Pokemons> = Pokemons.fetchRequest()
        
        do{
            let results = try context.fetch(request)
            print(results)
            return results
           
        }catch{
            print(error)
        }
        return nil
    }
    
    func savePokemonsDetail(pok: PokemonDetail) {
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Pokemons", in: context) else {return}
        
        let pokemons = Pokemons(entity: entity, insertInto: context)
        
        pokemons.name = pok.name
        pokemons.hp = Int32(pok.stats[0].baseStat ?? 0)
        pokemons.attack = Float(pok.stats[1].baseStat ?? 0)
        pokemons.defense = Float(pok.stats[2].baseStat ?? 0)
        pokemons.specialAttack = Float(pok.stats[3].baseStat ?? 0)
        pokemons.specialDefense = Float(pok.stats[4].baseStat ?? 0)
        pokemons.speed = Float(pok.stats[5].baseStat ?? 0)
    
    }
    
    func savePokemonsImg(pok: String) {
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Pokemons", in: context) else {return}
        
        let pokemons = Pokemons(entity: entity, insertInto: context)
        
        pokemons.img = self.cache.getImageData(key: pok)
        
    }
    
    func savePokemonsEffect(effect: EffectLink) {
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Pokemons", in: context) else {return}
        
        let pokemons = Pokemons(entity: entity, insertInto: context)
        
        pokemons.effect = effect.effectEntries[0].effect
        
    }
    
    func getPokemons() -> [Pokemons]{
        var arrayPokemons: [Pokemons] = []
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<Pokemons> = Pokemons.fetchRequest()
        request.predicate = NSPredicate(format: "name != nil")
        
        
        do{
            arrayPokemons = try context.fetch(request)

        }catch{
            print(error)
        }
        return arrayPokemons
    }
    
}
