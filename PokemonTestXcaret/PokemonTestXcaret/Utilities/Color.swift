//
//  Color.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/5/23.
//

import UIKit


func color(pokemonDetail: String?) -> UIColor {
    
    var color: UIColor = hexStringToUIColor(hex: "#CD361B")
    
    if (pokemonDetail == "grass"){
        color = hexStringToUIColor(hex: "#09C138")
    }
    else if(pokemonDetail == "poison"){
        color = hexStringToUIColor(hex: "#943FC4")
    }
    else if(pokemonDetail == "fire"){
        color = hexStringToUIColor(hex: "#D73831")
    }
    else if(pokemonDetail == "water"){
        color = hexStringToUIColor(hex: "#2CB8CB")
    }
    else if(pokemonDetail == "electric"){
        color = hexStringToUIColor(hex: "#E9E433")
    }
    else if(pokemonDetail == "ice"){
        color = hexStringToUIColor(hex: "#D51CCA")
    }
    else if(pokemonDetail == "normal"){
        color = hexStringToUIColor(hex: "#CDC6CC")
    }
    else if(pokemonDetail == "flying"){
        color = hexStringToUIColor(hex: "#5FCBC4")
    }
    else if(pokemonDetail == "psychic"){
        color = hexStringToUIColor(hex: "#D696D0")
    }
    else if(pokemonDetail == "bug"){
        color = hexStringToUIColor(hex: "#CE9511")
    }
    else if(pokemonDetail == "rock"){
        color = hexStringToUIColor(hex: "#B48041")
    }
    else if(pokemonDetail == "fighting"){
        color = hexStringToUIColor(hex: "#F0820E")
    }
    else if(pokemonDetail == "ghost"){
        color = hexStringToUIColor(hex: "#DCDAD8")
    }
    else if(pokemonDetail == "dark"){
        color = hexStringToUIColor(hex: "#ADAAA7")
    }
    else if(pokemonDetail == "dragon"){
        color = hexStringToUIColor(hex: "#7E5BA5")
    }
    else if(pokemonDetail == "steel"){
        color = hexStringToUIColor(hex: "#88848B")
    }
    else if(pokemonDetail == "fairy"){
        color = hexStringToUIColor(hex: "#EA5DD3")
    }
    
   return color
}

func colorBorder(pokemonDetail: String, border: Bool = false) -> CGColor {

    var color: CGColor = UIColor.red.cgColor
    
    if (pokemonDetail == "grass"){
        color = hexStringToUIColor(hex: "#09C138").cgColor
    }
    else if(pokemonDetail == "poison"){
        color = hexStringToUIColor(hex: "#943FC4").cgColor
    }
    else if(pokemonDetail == "fire"){
        color = hexStringToUIColor(hex: "#D73831").cgColor
    }
    else if(pokemonDetail == "water"){
        color = hexStringToUIColor(hex: "#2CB8CB").cgColor
    }
    else if(pokemonDetail == "electric"){
        color = hexStringToUIColor(hex: "#E9E433").cgColor
    }
    else if(pokemonDetail == "ice"){
        color = hexStringToUIColor(hex: "#D51CCA").cgColor
    }
    else if(pokemonDetail == "normal"){
        color = hexStringToUIColor(hex: "#CDC6CC").cgColor
    }
    else if(pokemonDetail == "flying"){
        color = hexStringToUIColor(hex: "#5FCBC4").cgColor
    }
    else if(pokemonDetail == "psychic"){
        color = hexStringToUIColor(hex: "#D696D0").cgColor
    }
    else if(pokemonDetail == "bug"){
        color = hexStringToUIColor(hex: "#CE9511").cgColor
    }
    else if(pokemonDetail == "rock"){
        color = hexStringToUIColor(hex: "#B48041").cgColor
    }
    else if(pokemonDetail == "fighting"){
        color = hexStringToUIColor(hex: "#F0820E").cgColor
    }
    else if(pokemonDetail == "ghost"){
        color = hexStringToUIColor(hex: "#DCDAD8").cgColor
    }
    else if(pokemonDetail == "dark"){
        color = hexStringToUIColor(hex: "#ADAAA7").cgColor
    }
    else if(pokemonDetail == "dragon"){
        color = hexStringToUIColor(hex: "#7E5BA5").cgColor
    }
    else if(pokemonDetail == "steel"){
        color = hexStringToUIColor(hex: "#88848B").cgColor
    }
    else if(pokemonDetail == "fairy"){
        color = hexStringToUIColor(hex: "#EA5DD3").cgColor
    }
    
   return color
}
