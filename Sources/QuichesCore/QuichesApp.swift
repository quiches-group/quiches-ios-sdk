//
//  QuichesApp.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation

public final class QuichesApp {
    private let publicKey: String

    public let authentication: Authentication
    public let notification: Notification
    
    public init(publicKey: String) {
        self.publicKey = publicKey
        
        self.authentication = Authentication()
        self.notification = Notification()
        
        AuthenticationProvider.shared.publicKey = publicKey
    }
}
