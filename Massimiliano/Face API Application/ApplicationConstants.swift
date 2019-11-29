//
//  ApplicationConstants.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/28/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import Foundation

struct ApplicationConstants
{
    // Graph information
    static let clientId = "a4448746-1cb9-4d64-b894-8ad1371f717e"
    static let authority = "https://login.microsoftonline.com/common"
    static let scopes = ["User.ReadBasic.All"]
    
    // Cognitive services information
    static let ocpApimSubscriptionKey = "3a510ac747854dec8d510cfb223d8379"
    static let faceApiEndpoint = "https://massimilianofaceservice.cognitiveservices.azure.com/face/v1.0"
    //static let faceApiEndpoint = "https://eastus.api.cognitive.microsoft.com/face/v1.0"
}

enum ErrorType: Error
{
    case UnexpectedError(nsError: NSError?)
    case ServiceError(json: [String: AnyObject])
    case JSonSerializationError
}

typealias JSON = AnyObject
typealias JSONDictionary = [String: JSON]
typealias JSONArray = [JSON]

