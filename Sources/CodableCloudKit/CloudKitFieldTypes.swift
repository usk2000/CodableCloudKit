//
//  File.swift
//  
//
//  Created by Yusuke Hasegawa on 2021/07/14.
//

import Foundation

@propertyWrapper
public struct CKBool: Codable {
    
    public let wrappedValue: Bool
    
    public init(_ value: Bool) {
        self.wrappedValue = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let intValue = try container.decode(Int.self)
        switch intValue {
        case 0: wrappedValue = false
        case 1: wrappedValue = true
        default: throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected `0` or `1` but received `\(intValue)`")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let value = wrappedValue ? 1 : 0
        try container.encode(value)
    }
    
}
