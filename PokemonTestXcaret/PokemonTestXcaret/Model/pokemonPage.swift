//
//  pokemonPage.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/3/23.
//

import Foundation


//Main link
struct Pokemonapi: Decodable{
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable{
    let name: String
    let url: String
    var detail: [PokemonDetail]?
}

//Pokemon Link
struct PokemonDetail: Decodable{
    var abilities: [Abilities]
    var name: String
    var id: Int
    var moves:[Moves]
    var species: url
    var stats:[Stats]
    var types:[Types]
}

struct Abilities: Decodable{
    let ability: nameLink
}

struct Types: Decodable{
    let slot: Int
    let type: nameLink
}

struct Moves: Decodable{
    let move: nameLink
}

struct Stats: Decodable{
    let effort: Float?
    let baseStat: Int?
    let stat: nameLink?
}

struct EffectLink: Decodable{
    let effectEntries:[Effect]
}

struct Effect: Decodable{
    let effect: String
}

struct url: Decodable{
    let url: String
}

struct nameLink:Decodable{
    let name: String
    let url: String
}
