//
//  ErrorsConstants.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import Foundation

enum RespositoryError: Error, LocalizedError {
  case invalidURL
  case requestFailed(Error)
  case decodingFailed(Error)
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "The URL is invalid."
    case .requestFailed(let error):
      return "Request failed: \(error.localizedDescription)"
    case .decodingFailed(let error):
      return "Decoding failed: \(error.localizedDescription)"
    }
  }
}
