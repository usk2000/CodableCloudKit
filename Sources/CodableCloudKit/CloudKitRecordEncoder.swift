//
//  CloudKitRecordEncoder.swift
//
//
//  Created by Yusuke Hasegawa on 2021/07/12.
//

import CloudKit
import Foundation

final public class CloudKitRecordEncoder: JSONEncoder {

    public func encodeToRecordValues<T>(_ value: T) throws -> CKRecord
    where T: CloudKitRecordEncodable {

        guard let decodedData = NSData.init(base64Encoded: value.metadata.data, options: []) else {
            throw NSError.init(
                domain: "CodableCloudKit", code: 0, userInfo: ["message": "can not get NSData"])
        }
        let unarchiver = try NSKeyedUnarchiver.init(forReadingFrom: decodedData as Data)
        unarchiver.requiresSecureCoding = true
        guard let record = CKRecord(coder: unarchiver) else {
            throw NSError.init(
                domain: "CodableCloudKit", code: 0,
                userInfo: ["message": "can not extract CKRecord"])
        }

        let data = try self.encode(value)
        var values =
            try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
            as? [String: Any] ?? [:]
        values.removeValue(forKey: "metadata")

        values.forEach { body in

            if let value = body.value as? __CKRecordObjCValue {
                record.setObject(value, forKey: body.key)
            } else {
                debugPrint("invalid value : \(body.value)")
            }
        }

        return record

    }
    public override init() {}

}
