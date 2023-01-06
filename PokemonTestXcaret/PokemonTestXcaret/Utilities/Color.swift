//
//  Color.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/5/23.
//

import UIKit


func color(pokemonDetail: String?) -> UIColor {
    
    var color: UIColor = .red
    
    if (pokemonDetail == "grass"){
        color = .green
    }
    else if(pokemonDetail == "poison"){
        color = .purple
    }
    else if(pokemonDetail == "fire"){
        color = .red
    }
    else if(pokemonDetail == "water"){
        color = .blue
    }
    else if(pokemonDetail == "electric"){
        color = .yellow
    }
    else if(pokemonDetail == "ice"){
        color = .systemIndigo
    }
    else if(pokemonDetail == "normal"){
        color = .gray
    }
    else if(pokemonDetail == "flying"){
        color = .systemCyan
    }
    else if(pokemonDetail == "psychic"){
        color = .systemPink
    }
    else if(pokemonDetail == "bug"){
        color = .systemMint
    }
    else if(pokemonDetail == "rock"){
        color = .systemBrown
    }
    else if(pokemonDetail == "fighting"){
        color = .systemOrange
    }
    else if(pokemonDetail == "ghost"){
        color = .systemGray6
    }
    else if(pokemonDetail == "dark"){
        color = .systemGray6
    }
    else if(pokemonDetail == "dragon"){
        color = .systemPurple
        
    }
    else if(pokemonDetail == "steel"){
        color = .darkGray
    }
    else if(pokemonDetail == "fairy"){
        color = .systemPink
    }
    
   return color
}

func colorBorder(pokemonDetail: String, border: Bool = false) -> CGColor {

    var color: CGColor = UIColor.red.cgColor
    
    if (pokemonDetail == "grass"){
        color = UIColor.green.cgColor
    }
    else if(pokemonDetail == "poison"){
        color = UIColor.purple.cgColor
    }
    else if(pokemonDetail == "fire"){
        color = UIColor.red.cgColor
    }
    else if(pokemonDetail == "water"){
        color = UIColor.blue.cgColor
    }
    else if(pokemonDetail == "electric"){
        color = UIColor.yellow.cgColor
    }
    else if(pokemonDetail == "ice"){
        color = UIColor.systemIndigo.cgColor
    }
    else if(pokemonDetail == "normal"){
        color = UIColor.gray.cgColor
    }
    else if(pokemonDetail == "flying"){
        color = UIColor.systemCyan.cgColor
    }
    else if(pokemonDetail == "psychic"){
        color = UIColor.systemPink.cgColor
    }
    else if(pokemonDetail == "bug"){
        color = UIColor.systemMint.cgColor
    }
    else if(pokemonDetail == "rock"){
        color = UIColor.systemBrown.cgColor
    }
    else if(pokemonDetail == "fighting"){
        color = UIColor.systemOrange.cgColor
    }
    else if(pokemonDetail == "ghost"){
        color = UIColor.systemGray6.cgColor
    }
    else if(pokemonDetail == "dark"){
        color = UIColor.systemGray6.cgColor
    }
    else if(pokemonDetail == "dragon"){
        color = UIColor.systemPurple.cgColor
        
    }
    else if(pokemonDetail == "steel"){
        color = UIColor.darkGray.cgColor
    }
    else if(pokemonDetail == "fairy"){
        color = UIColor.systemPink.cgColor
    }
    
   return color
}
