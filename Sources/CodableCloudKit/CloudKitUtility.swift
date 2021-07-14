//
//  CloudKitUtility.swift
//  
//
//  Created by Yusuke Hasegawa on 2021/07/13.
//

import Foundation

public class CloudKitUtility {
    
    /// check if user is logged in to iCloud
    /// - Returns: true if user is logged in to iCloud
    static public func isCloudKitContainerAvailable() -> Bool {
        //https://developer.apple.com/documentation/foundation/filemanager/1408036-ubiquityidentitytoken
        return FileManager.default.ubiquityIdentityToken != nil
    }
    
    //NOTE: NSUbiquityIdentityDidChangeが見つからない
    
}
