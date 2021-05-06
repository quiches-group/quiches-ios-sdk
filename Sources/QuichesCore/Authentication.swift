//
//  Authentication.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation
import JWTDecode

public final class Authentication: RoutingProvider {
    public var token: String? {
        return AuthenticationProvider.shared.jwtToken
    }
    
    public var tokenIsExpired: Bool {
        guard let token = token else { return false }

        do {
            let jwt = try decode(jwt: token)
            
            return jwt.expired
        } catch {
            return false
        }
    }
    
    public func signInWithMailAndPassword(
        mail: String, password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        let parameters = LoginWebServiceParameters(mail: mail, password: password)
        let service = LoginWebService(parameters: parameters)
        
        execute(with: service) { [getCurrentUser] result in
            switch result {
            case .success(let credentials):
                AuthenticationProvider.shared.jwtToken = credentials.token
                AuthenticationProvider.shared.refreshToken = credentials.refreshToken
                
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
    
    public func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let refreshToken = AuthenticationProvider.shared.refreshToken else {
            completion(.failure(NSError(domain: "NO_REFRESH_TOKEN", code: 500, userInfo: nil)))
            return
        }
        let parameters = RefreshTokenServiceParameters(refreshToken: refreshToken)
        
        let service = RefreshTokenWebService(parameters: parameters)
        
        execute(with: service) { result in
            switch result {
            case .success(let credentials):
                AuthenticationProvider.shared.jwtToken = credentials.token
                AuthenticationProvider.shared.refreshToken = credentials.refreshToken
                
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
