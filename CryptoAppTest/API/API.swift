//
//  API.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 11.04.2025.
//

import Foundation

final class APIClass {
    private let baseURL = "https://data.messari.io/api/v1/assets/"
    
    private let jsonDecoder = JSONDecoder()
    
    private let lock = NSLock()
    
    func loadCoinData(coin: Coins, completion: @escaping(Result<CoinResponce, Error>) -> Void) {
        
        guard let url = URL(string: baseURL + coin.rawValue + "/metrics")  else {
            completion(.failure(LoadError.loadError))
            return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self else {
                completion(.failure(LoadError.loadError))
                return}
            guard error == nil else {
                completion(.failure(LoadError.loadError))
                return
            }
            guard let data else {
                completion(.failure(LoadError.loadError))
                return
            }
            if let decoded = try? jsonDecoder.decode(Response.self, from: data) {
                completion(.success(decoded.data))
            } else {
                completion(.failure(LoadError.loadError))
            }
        }.resume()
    }
    
    func loadAll(completion: @escaping([CoinResponce]) -> Void) {
        let group = DispatchGroup()
        var workItems = [DispatchWorkItem]()
        var array = [CoinResponce]()
        
        
        Coins.allCases.forEach { coin in
            
            workItems.append(DispatchWorkItem { [weak self] in
                guard let self else {
                    group.leave()
                    return }
                
                loadCoinData(coin: coin) { result in
                    switch result {
                    case .success(let success):
                        self.lock.lock()
                        array.append(success)
                        self.lock.unlock()
                        group.leave()
                    case .failure(_):
                        group.leave()
                    }
                }
            })
        }
        workItems.forEach({
            group.enter()
            DispatchQueue.global().async(execute: $0)
        })
        
        group.notify(queue: DispatchQueue.global()) {
            completion(array)
        }
    }
}

enum LoadError:  Error {
    case loadError
    case unknownError
}
