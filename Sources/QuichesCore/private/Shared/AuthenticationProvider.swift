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
        get {
            return keychain.get("quiches-jwt-bearer-token")
        }
        set {
            if let token = newValue {
                keychain.set(token, forKey: "quiches-jwt-bearer-token")
            }
        }
    }
    
    var refreshToken: String? {
        get {
            return keychain.get("quiches-jwt-refresh-bearer-token")
        }
        set {
            if let token = newValue {
                keychain.set(token, forKey: "quiches-jwt-refresh-bearer-token")
            }
        }
    }
}
