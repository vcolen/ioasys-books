//
//  UserViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 16/02/22.
//

import Foundation

protocol UserViewModelProtocol {
    var authorization: String { get }
    var name: String { get }
    var gender: String { get }
}

class UserViewModel: UserViewModelProtocol {
    var authorization: String
    let name: String
    let gender: String
    
    init(user: User) {
        self.authorization = user.authorization ?? "No authorization"
        self.name = user.name
        self.gender = user.gender
    }
}
