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

    func saveContext(){
        let context = self.persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
    
    func fetchPokemons() -> [Pokemons] {
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<Pokemons> = Pokemons.fetchRequest()
        
        do{
            let results = try context.fetch(request)
            return results
           
        }catch{
            print(error)
        }
        return []
    }
    
    func savePokemonsDetail(pok: PokemonDetail, img: Data, effect: String) {
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
        pokemons.type = pok.types[0].type.name
        pokemons.img = img
        pokemons.effect = effect
        
        self.saveContext()
    
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
    
    func deleteAllData(_ entity:String) {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
                
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
        self.saveContext()
    }
    
}
