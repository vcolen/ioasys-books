//
//  UserViewModel.swift
//  ioasys books
//
//  Created by Victor Colen on 16/02/22.
//

import Foundation

protocol LoginViewModelProtocol {
    func loginUser(email: String,
                   password: String,
                   completion: @escaping ((UserViewModel?, String?, Error?) -> Void)
    )
}

class LoginViewModel: LoginViewModelProtocol {
    
    func loginUser(email: String,
                   password: String,
                   completion: @escaping ((UserViewModel?, String?, Error?) -> Void)
    ) {
        Network.loginUser(email: email,
                          password: password) { data, response, error in
            if let error = error {
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let data = data {
                            do {
                                let user = try JSONDecoder().decode(User.self, from: data)
                                let userViewModel = UserViewModel(user: user)
                                let authorizationToken = response.value(forHTTPHeaderField: "Authorization")!
                                
                                completion(userViewModel, authorizationToken, nil)
                                
                            } catch {
                                completion(nil, nil, error)
                            }
                        }
                    }  else if response.statusCode == 401 {
                        completion(nil, nil, error)
                    }
                }
            }
        }
    }
}
