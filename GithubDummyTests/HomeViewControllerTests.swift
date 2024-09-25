//
//  HomeViewControllerTests.swift
//  GithubDummyTests
//
//  Created by MacBook AIR on 25/09/2024.
//

import XCTest
@testable import GithubDummy

@MainActor
final class HomeViewControllerTests: XCTestCase {

    var mockOnboardingService:MockAPiService!

    override func setUpWithError() throws {
      mockOnboardingService = MockAPiService()
    }

    override func tearDownWithError() throws {
      mockOnboardingService = nil
    }

  private func makeSUT() throws -> HomeViewController {
    let vc = HomeViewController(networkManager: mockOnboardingService)
    return vc
  }


    func testPerformanceExample() throws {
      
        self.measure {
          let sut = try? makeSUT()
          sut?.viewDidLoad()
        }
    }

}
