//
//  CloudKitCodable.swift
//
//
//  Created by Yusuke Hasegawa on 2021/07/12.
//

import Foundation

public protocol CloudKitRecordRepresentable {
    var metadata: CloudKitMetadata { get }
}

public struct CloudKitMetadata: Codable {
    public var data: String  //base64 encoded
    public var type: String
    public var identifier: String
    public var created: CloudKitMetadataDate?
    public var modified: CloudKitMetadataDate?
}

extension CloudKitMetadata {
    
    public static func empty() -> CloudKitMetadata {
        return .init(data: "", type: "", identifier: "", created: nil, modified: nil)
    }
    
}

public struct CloudKitMetadataDate: Codable {
    public var date: Date
    public var user: String
}

public protocol CloudKitRecordDecodable: CloudKitRecordRepresentable & Decodable {

}

public protocol CloudKitRecordEncodable: CloudKitRecordRepresentable & Encodable {

}

public protocol CloudKitCodable: CloudKitRecordDecodable & CloudKitRecordEncodable {

}
