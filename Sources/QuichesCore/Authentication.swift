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
        completion: @escaping (Result<LoginWebServiceResponse, Error>) -> Void
    ) {
        let parameters = LoginWebServiceParameters(mail: mail, password: password)
        let service = LoginWebService(parameters: parameters)
        
        execute(with: service) { result in
            switch result {
            case .success(let credentials):
                AuthenticationProvider.shared.setJwtToken(with: credentials.token)
                completion(.success(credentials))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        let service = GetCurrentUserWebService()
        
        execute(with: service) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
