//
//  SampleModel.swift
//
//
//  Created by Yusuke Hasegawa on 2021/07/12.
//

import Foundation

@testable import CodableCloudKit

struct SampleModel: CloudKitCodable {
    var metadata: CloudKitMetadata
    let text: String
}
