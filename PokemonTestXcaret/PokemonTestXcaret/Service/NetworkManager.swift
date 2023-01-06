//
//  NetworkManager.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/4/23.
//

import Foundation

protocol NetworkService {
    func getModel<T: Decodable>(url: URL?, completion: @escaping (Result<T, NetworkError>) -> Void)
    func getRawData(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class NetworkManager {
    
    let session: Session
    let decoder: JSONDecoder = JSONDecoder()
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager: NetworkService {
    func getModel<T>(url: URL?, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
            
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.retrieveData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.other(error)))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.serverResponse(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(NetworkError.decodeError(error)))
            }
        }
    }
    
    func getRawData(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.retrieveData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.other(error)))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.serverResponse(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            completion(.success(data))
        }
    }
}
