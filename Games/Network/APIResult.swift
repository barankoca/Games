//
//  APIResult.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import Foundation

enum APIResult<T, U: Error> {
    case success(T)
    case failure(U)
}
