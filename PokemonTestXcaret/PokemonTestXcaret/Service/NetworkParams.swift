//
//  NetworkParams.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/4/23.
//

import Foundation


enum NetworkParams {
    
    private struct NetworkConstants {
        static let pokemonBase = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=20"
        static let baseImage = "https://image.tmdb.org/t/p/w500"
    }
        
    case pokemons
    case pokemonImage(String)
    
    var url: URL? {
        switch self {
        case .pokemons:
            return URL(string: NetworkConstants.pokemonBase)
        case .pokemonImage(let posterPath):
            return URL(string: NetworkConstants.baseImage + posterPath)

        }
    }
    
}
