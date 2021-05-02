//
//  APIService.swift
//  Games
//
//  Created by Baran Koca on 2.05.2021.
//

import Foundation



final class APIService {
    
    
    func getGames(completion: @escaping ([GamesData], Error?) -> Void) {
        
        guard var urlComponents = URLComponents(string: Url.sourceURL) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: APIKey.key, value: APIValue.key),
            URLQueryItem(name: APIKey.pageLimit, value: APIValue.pageLimit),
            URLQueryItem(name: APIKey.page, value: "1")
        ]
        
        guard let url = urlComponents.url  else { return }
        
            URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                guard let data = data,
                      error == nil
                else {
                    return
                }

                var result: GamesResult?
                
                do {
                    result = try JSONDecoder().decode(GamesResult.self, from: data)
                    
                } catch{
                    print("error")
                }
                
                guard let finalResult = result else {
                    return
                }
                completion(finalResult.games, error)
                
                
            }).resume()
            
        }
}
