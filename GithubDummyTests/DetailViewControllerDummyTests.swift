//
//  GithubDummyTests.swift
//  GithubDummyTests
//
//  Created by MacBook AIR on 25/09/2024.
//

import XCTest
@testable import GithubDummy

@MainActor
final class DetailViewControllerDummyTests: XCTestCase {
  var mockOnboardingService:MockAPiService!


  override func setUpWithError() throws {
    mockOnboardingService = MockAPiService()

  }

  override func tearDownWithError() throws {
    mockOnboardingService = nil
  }


private func makeSUT() throws -> DetailViewController {
  let vc = DetailViewController(userUrl: "https://api.github.com/repositories", networkManager: mockOnboardingService)
  return vc
}

  func testUserNameReturnsCorrectNameForFirstUser() throws {
         let sut = try makeSUT()
         sut.userDetail = mockUsers[0]
         let expectedName = "The Octocat"

         XCTAssertEqual(expectedName, sut.userDetail?.name, "Expected user name does not match")
     }

     func testUserNameReturnsCorrectNameForSecondUser() throws {
         let sut = try makeSUT()
         sut.userDetail = mockUsers[1]
         sut.viewDidLoad()
         let expectedName = "Rick Olson"

         XCTAssertEqual(expectedName, sut.userDetail?.name, "Expected user name does not match")
     }




     func testUIElementsAfterLoadingUserDetail() throws {
         let sut = try makeSUT()
         sut.userDetail = mockUsers[0]
         sut.viewDidLoad()

         // Assuming you have a label for the username
       XCTAssertEqual(sut.userDetail?.name, "The Octocat", "Username label does not display the correct name")
     }

     func testPerformanceOfViewLoading() throws {
         measure {
             let sut = try? makeSUT()
             sut?.viewDidLoad() // Simulating loading the view
         }
     }
 }


class MockAPiService:NetworkManager {
  override func fetchCities(url: String) async throws -> User {
    return mockUsers[0]
  }

  override func fetchCities(page: Int = 1, perPage: Int = 30) async throws -> [Repository] {
    return mockRepositories
  }
}


let mockUsers: [User] = [
    User(
        login: "octocat",
        id: 1,
        nodeId: "MDQ6VXNlcjE=",
        avatarUrl: "https://github.com/images/error/octocat_happy.gif",
        gravatarId: nil,
        url: "https://api.github.com/users/octocat",
        htmlUrl: "https://github.com/octocat",
        followersUrl: "https://api.github.com/users/octocat/followers",
        followingUrl: "https://api.github.com/users/octocat/following{/other_user}",
        gistsUrl: "https://api.github.com/users/octocat/gists{/gist_id}",
        starredUrl: "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        subscriptionsUrl: "https://api.github.com/users/octocat/subscriptions",
        organizationsUrl: "https://api.github.com/users/octocat/orgs",
        reposUrl: "https://api.github.com/users/octocat/repos",
        eventsUrl: "https://api.github.com/users/octocat/events{/privacy}",
        receivedEventsUrl: "https://api.github.com/users/octocat/received_events",
        type: "User",
        siteAdmin: false,
        name: "The Octocat",
        company: "GitHub",
        blog: "https://github.blog",
        location: "San Francisco",
        email: "octocat@github.com",
        hireable: true,
        bio: "There once was...",
        twitterUsername: "octocat",
        publicRepos: 5,
        publicGists: 10,
        followers: 100,
        following: 50,
        createdAt: "2011-01-25T18:44:36Z",
        updatedAt: "2021-02-12T18:44:36Z"
    ),
    User(
        login: "defunkt",
        id: 2,
        nodeId: "MDQ6VXNlcjI=",
        avatarUrl: "https://github.com/images/error/defunkt_happy.gif",
        gravatarId: nil,
        url: "https://api.github.com/users/defunkt",
        htmlUrl: "https://github.com/defunkt",
        followersUrl: "https://api.github.com/users/defunkt/followers",
        followingUrl: "https://api.github.com/users/defunkt/following{/other_user}",
        gistsUrl: "https://api.github.com/users/defunkt/gists{/gist_id}",
        starredUrl: "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
        subscriptionsUrl: "https://api.github.com/users/defunkt/subscriptions",
        organizationsUrl: "https://api.github.com/users/defunkt/orgs",
        reposUrl: "https://api.github.com/users/defunkt/repos",
        eventsUrl: "https://api.github.com/users/defunkt/events{/privacy}",
        receivedEventsUrl: "https://api.github.com/users/defunkt/received_events",
        type: "User",
        siteAdmin: false,
        name: "Rick Olson",
        company: "GitHub",
        blog: "http://defunkt.com",
        location: "San Francisco",
        email: nil,
        hireable: false,
        bio: "Co-founder of GitHub",
        twitterUsername: "defunkt",
        publicRepos: 20,
        publicGists: 5,
        followers: 200,
        following: 75,
        createdAt: "2008-02-25T18:44:36Z",
        updatedAt: "2021-02-12T18:44:36Z"
    )
    // Add more mock users as needed
]


// Mock data for Owner
let mockOwner = Owner(
    login: "octocat",
    id: 1,
    nodeId: "MDQ6VXNlcjE=",
    avatarUrl: "https://github.com/images/error/octocat_happy.gif",
    url: "https://api.github.com/users/octocat",
    htmlUrl: "https://github.com/octocat"
)

// Mock data for Repository
let mockRepositories: [Repository] = [
    Repository(
        id: 1,
        nodeId: "MDEwOlJlcG9zaXRvcnkx",
        name: "Hello-World",
        fullName: "octocat/Hello-World",
        isPrivate: false,
        owner: mockOwner,
        htmlUrl: "https://github.com/octocat/Hello-World",
        description: "This is your first repository",
        fork: false,
        url: "https://api.github.com/repos/octocat/Hello-World"
    ),
    Repository(
        id: 2,
        nodeId: "MDEwOlJlcG9zaXRvcnky",
        name: "Another-Repo",
        fullName: "octocat/Another-Repo",
        isPrivate: false,
        owner: mockOwner,
        htmlUrl: "https://github.com/octocat/Another-Repo",
        description: "Another repository example",
        fork: false,
        url: "https://api.github.com/repos/octocat/Another-Repo"
    )
]
