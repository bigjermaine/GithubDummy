//
//  NetWorkManager.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import Foundation

  class NetworkManager {

  static let shared = NetworkManager()

    func fetchCities(page: Int = 1, perPage: Int = 30) async throws -> [Repository] {
        let baseURL = "https://api.github.com/repositories"
        guard let url = URL(string: "\(baseURL)?page=\(page)&per_page=\(perPage)") else {
            throw RespositoryError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let cities = try JSONDecoder().decode([Repository].self, from: data)
            return cities
        } catch let decodingError as DecodingError {
            throw RespositoryError.decodingFailed(decodingError)
        } catch {
            throw RespositoryError.requestFailed(error)
        }
    }

    func fetchCities(url:String) async throws -> User {
      guard let url = URL(string: url) else {
        throw RespositoryError.invalidURL
      }
      do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(User.self, from: data)
        return users
      } catch {
        throw RespositoryError.requestFailed(error)
      }
    }

}
