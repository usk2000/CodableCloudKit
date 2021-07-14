//
//  File.swift
//  
//
//  Created by Yusuke Hasegawa on 2021/07/14.
//

import Foundation

@propertyWrapper
struct CKBool: Codable {
    
    let wrappedValue: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let intValue = try container.decode(Int.self)
        switch intValue {
        case 0: wrappedValue = false
        case 1: wrappedValue = true
        default: throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected `0` or `1` but received `\(intValue)`")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let value = wrappedValue ? 1 : 0
        try container.encode(value)
    }
    
}
