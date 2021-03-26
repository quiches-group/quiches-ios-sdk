//
//  RegisterNewDeviceForNotification.swift
//  
//
//  Created by Maxence Mottard on 26/03/2021.
//

import Foundation

struct RegisterNewDeviceForNotificationParameters: Encodable {
    var deviceId: String
    var deviceType: String = "iOS"
}

final class RegisterNewDeviceForNotification: Routing {
    typealias DecodeType = EmptyCodable
    
    let baseURL: Config.Hostname = .notiches
    let path: String = "/devices"
    let authenticationType: AuthenticationType = .JWTBearer
    let method: HTTPMethod = .PUT
    
    let parameters: RegisterNewDeviceForNotificationParameters?
    
    init(parameters: RegisterNewDeviceForNotificationParameters) {
        self.parameters = parameters
    }
}
