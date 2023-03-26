//
//  NetworkManager.swift
//  ChatMessageWithComments
//
//  Created by Mohammad Zulqurnain on 26/03/2023.
//

import Foundation
import Combine

enum APIError: Error {
  case requestFailed
  case invalidResponse
  case decodingFailed
  case networkError(Error)
}

class NetworkManager {
  static let shared = NetworkManager()
  private let cache = NSCache<NSURL, NSData>()
  private let urlSession = URLSession.shared
  
  func get<T: Decodable>(url: URL) -> AnyPublisher<T, APIError> {
    if let cachedData = cache.object(forKey: url as NSURL) {
      do {
        let decodedData = try JSONDecoder().decode(T.self, from: cachedData as Data)
        return Just(decodedData)
          .setFailureType(to: APIError.self)
          .eraseToAnyPublisher()
      } catch {
        return Fail(error: APIError.decodingFailed)
          .eraseToAnyPublisher()
      }
    }
    
    return urlSession.dataTaskPublisher(for: url)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          throw APIError.invalidResponse
        }
        return data
      }
      .decode(type: Data.self, decoder: JSONDecoder())
      .tryMap { data in
        do {
          _ = try self.cache.setObject(data as NSData, forKey: url as NSURL)
          let decodedData = try JSONDecoder().decode(T.self, from: data as! Data)
          return decodedData
        } catch {
          throw APIError.decodingFailed
        }
      }
      .mapError { error in
        APIError.networkError(error)
      }
      .eraseToAnyPublisher()
  }
}
