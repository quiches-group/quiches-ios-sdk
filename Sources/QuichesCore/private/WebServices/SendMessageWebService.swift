//
//  File.swift
//  
//
//  Created by Zakarya TOLBA on 28/03/2021.
//

import Foundation

struct SendMessageWebServiceParameters: Encodable {
    let mail: String
    let message: String
}

final class SendMessageWebService: Routing {
    typealias DecodeType = EmptyCodable
    
    var baseURL: Config.Hostname = .apiclient
    var path: String = "/api/message/"
    var authenticationType: AuthenticationType = .PublicKey
    var method: HTTPMethod = .PUT
    
    let parameters: SendMessageWebServiceParameters?
    
    init(parameters: SendMessageWebServiceParameters) {
        self.parameters = parameters
    }
}
