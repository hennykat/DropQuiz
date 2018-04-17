import XCTest
@testable import DropQuiz

class UIUtilTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test1GetListItem() {
        let itemList = ["string0", "string1", "string2"]
        let indexPath = IndexPath(row: 2, section: 0)
        
        let actual = UIUtil.getListItem(at: indexPath, itemList)
        XCTAssertEqual(actual, "string2", "input: good index")
    }
    
    func test2GetListItem() {
        let itemList = [1, 6, 36]
        let indexPath = IndexPath(row: 10, section: 0)
        
        let actual = UIUtil.getListItem(at: indexPath, itemList)
        XCTAssertNil(actual, "input: bad index")
    }
    
    func test3GetListItem() {
        let itemList = [1.4, 3.6, 5.8]
        let indexPath = IndexPath(row: 3, section: 0)
        
        let actual = UIUtil.getListItem(at: indexPath, itemList, defaultItem: 8.9)
        XCTAssertEqual(actual, 8.9, "input: bad index with default")
    }
    
}
