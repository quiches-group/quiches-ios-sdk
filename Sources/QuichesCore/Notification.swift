//
//  Notification.swift
//  
//
//  Created by Maxence Mottard on 26/03/2021.
//

import Foundation

public final class Notification: RoutingProvider {
    public func registerNewDevice(deviceId: String, completion: @escaping(Result<Void, Error>) -> Void) {
        let parameters = RegisterNewDeviceForNotificationParameters(deviceId: deviceId)
        let service = RegisterNewDeviceForNotification(parameters: parameters)
        
        execute(with: service, completion: completion)
    }
    
    public func sendMessage(
        mail: String, body: String,
        completion: @escaping(Result<Void, Error>) -> Void
    ) {
        let parameters = SendMessageWebServiceParameters(mail: mail, body: body)
        let service = SendMessageWebService(parameters: parameters)
        
        execute(with: service, completion: completion)
    }
}
