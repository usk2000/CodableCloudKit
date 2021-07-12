//
//  CloudKitCodable.swift
//  
//
//  Created by Yusuke Hasegawa on 2021/07/12.
//

import Foundation

public protocol CloudKitCodable: Decodable & Encodable {
    var cloudKitSystemFields: Data { get }
    var cloudKitRecordType: String { get }
    var cloudKitIdentifier: String { get }
}
