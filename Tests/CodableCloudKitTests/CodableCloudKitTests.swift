import CloudKit
import XCTest

@testable import CodableCloudKit

final class CodableCloudKitTests: XCTestCase {

    private let decoder = CloudKitRecordDecoder()
    private let encoder = CloudKitRecordEncoder()

    func testDecode() {

        let record = CKRecord.init(recordType: "Sample")
        record.setObject("sample text" as NSString, forKey: "text")

        do {
            let model = try decoder.decode(SampleModel.self, from: record)
            debugPrint(model)
        } catch let error {
            debugPrint(error)
            XCTFail(error.localizedDescription)
        }

    }

    func testEncode() {

        let record = CKRecord.init(recordType: "Sample")
        record.setObject("sample text" as NSString, forKey: "text")

        do {
            let model = try decoder.decode(SampleModel.self, from: record)
            let encodedRecord = try encoder.encodeToRecordValues(model)

            debugPrint(encodedRecord)
            XCTAssertTrue(encodedRecord.recordType == "Sample")
            XCTAssertTrue(encodedRecord.recordID.recordName == record.recordID.recordName)
            XCTAssertTrue(encodedRecord["text"] == "sample text")

        } catch let error {
            debugPrint(error)
            XCTFail(error.localizedDescription)
        }

    }

}
