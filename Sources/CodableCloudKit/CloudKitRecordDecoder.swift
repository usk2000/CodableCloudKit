//
//  CloudKitRecordDecoder.swift
//  
//
//  Created by Yusuke Hasegawa on 2021/07/12.
//

import CloudKit
import Foundation

final public class CloudKitRecordDecoder: Decoder {
    public var codingPath: [CodingKey] = []
    
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        
    }
        
}

extension CloudKitRecordDecoder {
    
    final class KeyedContainer<Key> where Key: CodingKey {
        var record: CKRecord
        var codingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]
        let keyOverrides: [String: Any]

        private lazy var systemFieldsData: Data = {
            return decodeSystemFields()
        }()

        func nestedCodingPath(forKey key: CodingKey) -> [CodingKey] {
            return self.codingPath + [key]
        }

        init(
            record: CKRecord, codingPath: [CodingKey], userInfo: [CodingUserInfoKey: Any],
            keyOverrides: [String: Any]
        ) {
            self.codingPath = codingPath
            self.userInfo = userInfo
            self.record = record
            self.keyOverrides = keyOverrides
        }

        func checkCanDecodeValue(forKey key: Key) throws {
            guard self.contains(key) else {
                let context = DecodingError.Context(
                    codingPath: self.codingPath, debugDescription: "key not found: \(key)")
                throw DecodingError.keyNotFound(key, context)
            }
        }
    }
    
}
