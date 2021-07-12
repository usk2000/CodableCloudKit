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
    var data: String //base64 encoded
    var type: String
    var identifier: String
    var created: CloudKitMetadataDate?
    var modified: CloudKitMetadataDate?
}

public struct CloudKitMetadataDate: Codable {
    var date: Date
    var user: String
}

public protocol CloudKitRecordDecodable: CloudKitRecordRepresentable & Decodable {
    
}

public protocol CloudKitRecordEncodable: CloudKitRecordRepresentable & Encodable {
    
}

public protocol CloudKitCodable: CloudKitRecordDecodable & CloudKitRecordEncodable {
    
}
