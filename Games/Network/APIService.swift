//
//  APIService.swift
//  Games
//
//  Created by Baran Koca on 2.05.2021.
//

import Foundation

final class APIService {
    
    
    func getGames(pageNumber: Int, searchText: String?, completion: @escaping (APIResult<GamesResult, Error>) -> Void) {
        
        guard var urlComponents = URLComponents(string: Url.sourceURL) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: APIKey.key, value: APIValue.key),
            URLQueryItem(name: APIKey.pageLimit, value: APIValue.pageLimit),
            URLQueryItem(name: APIKey.page, value: String(pageNumber))
        ]
        
        if let searchText = searchText {
            let searchQueryItem = URLQueryItem(name: APIKey.search, value: searchText)
            urlComponents.queryItems?.append(searchQueryItem)
        }
        
        guard let url = urlComponents.url  else { return }
        DispatchQueue.global(qos: .userInteractive).async {
            let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                guard let data = data,
                      error == nil
                else {
                    completion(APIResult.failure(error!))
                    return
                }
                
                var result: GamesResult?
                
                do {
                    result = try JSONDecoder().decode(GamesResult.self, from: data)
                    
                } catch{
                    completion(APIResult.failure(error))
                    return
                }
                
                guard let finalResult = result else { return }
                completion(APIResult.success(finalResult))
            })
            
            task.resume()
        }
    }
    
    func getDetail(id: Int, completion: @escaping (APIResult<GameDetailModel, Error>) -> Void) {
        
        guard var urlcomponents = URLComponents(string: Url.sourceURL) else { return }
        urlcomponents.queryItems = [URLQueryItem(name: APIKey.key, value: APIValue.key)]
        
        let urlWithPath = urlcomponents.url?.appendingPathComponent(String(id))
        
        guard let url = urlWithPath else { return }
        
        DispatchQueue.global(qos: .userInteractive).async {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data,
                      error == nil
                else {
                    completion(APIResult.failure(error!))
                    return
                }
                
                var result: GameDetailModel?
                
                do {
                    result = try JSONDecoder().decode(GameDetailModel.self, from: data)
                } catch {
                    completion(APIResult.failure(error))
                    return
                }
                
                guard let finalResult = result else { return }
                
                completion(APIResult.success(finalResult))
            }
            task.resume()
        }
    }
}
