//
//  ImageCache.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/5/23.
//

import Foundation


class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, NSData>
    
    init() {
        self.cache = NSCache<NSString, NSData>()
    }
    
}

extension ImageCache {
    
    func setImageData(data: Data, key: String) {
        let nsKey = NSString(string: key)
        let object = NSData(data: data)
        self.cache.setObject(object, forKey: nsKey)
    }
    
    func getImageData(key: String) -> Data? {
        let nsKey = NSString(string: key)
        guard let object = self.cache.object(forKey: nsKey) else { return nil }
        return Data(referencing: object)
    }
    
}
