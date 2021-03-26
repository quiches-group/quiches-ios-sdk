//
//  Authentication.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation

public final class Authentication: RoutingProvider {    
    public func signInWithMailAndPassword(
        mail: String, password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        let parameters = LoginWebServiceParameters(mail: mail, password: password)
        let service = LoginWebService(parameters: parameters)
        
        execute(with: service) { [getCurrentUser] result in
            switch result {
            case .success(let credentials):
                AuthenticationProvider.shared.setJwtToken(with: credentials.token)
                
                getCurrentUser(completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        let service = GetCurrentUserWebService()
        
        execute(with: service, completion: completion)
    }
    
    public func registerAppUser(
        mail: String, password: String, firstname: String, lastname: String,
        completion: @escaping(Result<Void, Error>) -> Void
    ) {
        let parameters = RegisterWebServiceParameters(mail: mail, password: password, firstname: firstname, lastname: lastname)
        let service = RegisterWebService(parameters: parameters)
        
        execute(with: service, completion: completion)
    }
}
