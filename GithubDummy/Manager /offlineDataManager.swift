//
//  offlineDataManager.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import Foundation


extension  UserDefaults  {

     static let offlineUserKey = "offlineDataManager"

     func dowloadOfflineUser(user:Repository) {

        do {
            var dowloaduser =  offlineUsers()
            dowloaduser.append(user)
            let data = try JSONEncoder().encode(dowloaduser)
            UserDefaults.standard.set(data, forKey: UserDefaults.offlineUserKey)
        }catch _ {

        }
    }

    func offlineUsers() -> [Repository]  {
        guard let dowloadedUserData = data(forKey: UserDefaults.offlineUserKey) else {return []}
        do {
            let data =  try JSONDecoder().decode([Repository].self, from: dowloadedUserData)
            return data
        }catch _ {

        }
        return []
    }

    func deleteUserOfflineUsers(at index: Int) {
        var dowloaduser =  bookMarkUsers()
        guard index >= 0, index < dowloaduser.count else {
            return
        }
      dowloaduser.remove(at: index)
        do {
            let data = try JSONEncoder().encode(dowloaduser)
          set(data, forKey: UserDefaults.offlineUserKey)
        } catch  _ {

        }
    }
}


