//
//  CloudKitRecordDecoder.swift
//
//
//  Created by Yusuke Hasegawa on 2021/07/12.
//

import CloudKit
import Foundation

final public class CloudKitRecordDecoder: JSONDecoder {

    public func decode<T>(_ type: T.Type, from record: CKRecord)
        throws -> T where T: CloudKitRecordDecodable
    {
        
        let values = replaceAllDate(values: record.allValues())
        
        let data = try JSONSerialization.data(withJSONObject: values, options: [.fragmentsAllowed])
        return try decode(T.self, from: data)
    }

    public override init() {}

}

private extension CloudKitRecordDecoder {
    
    func replaceAllDate(values: [String: Any]) -> [String: Any] {
        var result = values
        let dateDecodingStrategy = self.dateDecodingStrategy

        result.forEach { body in
            if let date = body.value as? Date {
                switch dateDecodingStrategy {
                case .deferredToDate, .secondsSince1970:
                    result[body.key] = date.timeIntervalSince1970
                case .millisecondsSince1970:
                    result[body.key] = date.timeIntervalSince1970 * 1000.0
                case .iso8601:
                    result[body.key] = ISO8601DateFormatter().string(from: date)
                case .formatted(_): fatalError()
                case .custom(_): fatalError()
                @unknown default:
                    fatalError()
                }
            } else if let dict = body.value as? [String: Any] {
                result[body.key] = self.replaceAllDate(values: dict)
            }
        }
        
        return result
    }
    
}

extension CKRecord {

    func encodedData() -> Data {
        let coder = NSKeyedArchiver.init(requiringSecureCoding: true)
        self.encodeSystemFields(with: coder)
        coder.finishEncoding()
        return coder.encodedData
    }

    func allValues() -> [String: Any] {

        var values: [String: Any] = ["metadata": self.extractMetadata()]

        self.allKeys().forEach { key in
            values[key] = self[key]
        }

        return values
    }

    func extractMetadata() -> [String: Any] {
        var metadata: [String: Any] = [
            "data": encodedData().base64EncodedString(),
            "type": self.recordType,
            "identifier": self.recordID.recordName,
        ]

        if let date = self.creationDate, let userId = self.creatorUserRecordID?.recordName {
            metadata["created"] = [
                "date": date,
                "user": userId,
            ]
        }

        if let date = self.modificationDate, let userId = self.lastModifiedUserRecordID?.recordName
        {
            metadata["modified"] = [
                "date": date,
                "user": userId,
            ]
        }

        return metadata

    }

}
