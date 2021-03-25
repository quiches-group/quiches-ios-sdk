//
//  AuthenticationProvider.swift
//  
//
//  Created by Maxence Mottard on 25/03/2021.
//

import Foundation
import KeychainSwift

final class AuthenticationProvider {
    private let keychain = KeychainSwift()
    
    static let shared: AuthenticationProvider = AuthenticationProvider()
    
    var publicKey: String?
    
    var jwtToken: String? {
        return keychain.get("quiches-jwt-bearer-token")
    }
    
    func setJwtToken(with token: String) {
        keychain.set(token, forKey: "quiches-jwt-bearer-token")
    }
}
