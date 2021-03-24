//
//  File.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation

public final class Authentication: NSObject {
    
    private let hostname: String = Config.Hostname.sso.rawValue
    
    private let publicKey: String
    
    public init(publicKey: String) {
        self.publicKey = publicKey
    }
    
    public func signInWithMailAndPassword(mail: String, password: String) {
        let request = LoginWebService(publicKey: publicKey)
        let parameters = LoginWebServiceParameters(mail: mail, password: password)

        request.send(parameters: parameters) { (credentials) in
            print(credentials)
        }
    }
    
}
