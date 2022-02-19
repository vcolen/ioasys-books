//
//  UserViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 18/02/22.
//

import Foundation

protocol UserViewModelProtocol {
    var userName: String { get }
    var userGender: String { get }
}

class UserViewModel: UserViewModelProtocol {
    let userName: String
    let userGender: String
    
    init(user: User) {
        self.userName = user.name
        self.userGender = user.gender
    }
}
