import XCTest
import Units

class ResolutionTests: XCTestCase {

  func testResolution() {
    let str = "1920x1080"
    switch Resolution<UInt32>.parse(str) {
    case .success(let resolution):
      XCTAssertEqual(resolution.width, 1920)
      XCTAssertEqual(resolution.height, 1080)
      XCTAssertEqual(resolution.description, str)
    case .failure:
      XCTFail()
    }

    XCTAssertEqual(Resolution<UInt32>(width: 1, height: 1).ratio, 1)
    XCTAssertEqual(Resolution<UInt32>(width: 1, height: 1), Resolution<UInt32>(width: 1, height: 1))

    measure {
      _ = Resolution<UInt32>.parse(str)
    }

    let invalidStrs = [
      "1920",
      "1920x",
      "x1080",
      "1920xabc",
      "",
      "x",
      "-1920x1080",
      "-1920x-1080"
    ]
    for v in invalidStrs {
      switch Resolution<UInt32>.parse(v) {
      case .success:
        XCTFail()
      case .failure:
        break
      }
    }
  }

}
