//
//  Authentication.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation

public final class Authentication: NSObject {
    
    private let hostname: String = Config.Hostname.sso.rawValue
    
    private let publicKey: String
    
    init(publicKey: String) {
        self.publicKey = publicKey
    }
    
    public func signInWithMailAndPassword(
        mail: String, password: String,
        completion completionHandler: @escaping (Result<LoginWebServiceResponse, Error>) -> Void
    ) {
        let request = LoginWebService(publicKey: publicKey)
        let parameters = LoginWebServiceParameters(mail: mail, password: password)
        
        request.send(parameters: parameters) { result in
            print(result)
            completionHandler(result)
        }
    }
    
}
