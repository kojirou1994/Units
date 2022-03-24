public struct Resolution<T: UnsignedInteger & FixedWidthInteger>: Hashable, Equatable, CustomStringConvertible {

  public var width: T

  public var height: T

  public init(width: T, height: T) {
    self.width = width
    self.height = height
  }

  public static func parse<S: StringProtocol>(_ string: S, separator: Character = "x") -> Result<Self, ResolutionParserError> where S.SubSequence == Substring {
    guard let xIndex = string.firstIndex(of: separator) else {
      return .failure(.noSeparator(separator))
    }
    let widthString = string[..<xIndex]
    guard let width = T(widthString) else {
      return .failure(.invalidNumber(widthString))
    }
    let heightString = string[string.index(after: xIndex)...]
    guard let height = T(heightString) else {
      return .failure(.invalidNumber(heightString))
    }

    return .success(.init(width: width, height: height))
  }

  public var description: String {
    "\(width)x\(height)"
  }

  public var ratio: Double {
    precondition(height != 0)
    return Double(width) / Double(height)
  }

}

public enum ResolutionParserError: Error {
  case noSeparator(Character)
  case invalidNumber(Substring)
}
