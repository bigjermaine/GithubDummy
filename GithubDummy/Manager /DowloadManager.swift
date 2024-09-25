//
//  DowloadManager.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import Foundation


extension  UserDefaults  {

     static let dowloadUserKey = "dowloadEpisodeKey"

     func bookMarkUser(user:Repository) {

        do {
            var dowloadUsers =  bookMarkUsers()
            dowloadUsers.append(user)
            let data = try JSONEncoder().encode(dowloadUsers)
            UserDefaults.standard.set(data, forKey: UserDefaults.dowloadUserKey)
        }catch let error {
     
        }
    }

    func bookMarkUsers() -> [Repository]  {
        guard let dowloadUserData = data(forKey: UserDefaults.dowloadUserKey) else {return []}
        do {
            let data =  try JSONDecoder().decode([Repository].self, from: dowloadUserData)
            return data
        }catch _ {

        }
        return []
    }

    func deleteUser(at index: Int) {
        var dowloadUserData =  bookMarkUsers()
        guard index >= 0, index < dowloadUserData.count else {
            return
        }
      dowloadUserData.remove(at: index)
        do {
            let data = try JSONEncoder().encode(dowloadUserData)
            set(data, forKey: UserDefaults.dowloadUserKey)
        } catch  _ {

        }
    }
}


