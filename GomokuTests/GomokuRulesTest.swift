import XCTest
@testable import Gomoku

final class GomokuRulesTest: XCTestCase {

    // MARK: Properties
    private var board: Board!
    private var rules: GomokuRules!

    // MARK: Lifecycle
    override func setUp() {
        super.setUp()
        board = Board()
        rules = GomokuRules()
    }

    override func tearDown() {
        rules = nil
        board = nil
        super.tearDown()
    }

    // MARK: Tests
    func testIsWin_isFalse_whenBoardIsEmpty() {
        XCTAssertFalse(try isWin())
    }

    func testIsWin_isFalse_whenBoardIsNotEmptyButNotWin() throws {
        try board.placeStone(intersection: .zero, player: randomPlayer())

        XCTAssertFalse(try isWin())
    }

    func testIsWin_isFalse_whenFourInARowInTheFirstRow() throws {
        for xPosition in 0..<4 {
            let intersection = Intersection(row: 0, column: xPosition)
            try board.placeStone(intersection: intersection, player: .white)
        }

        XCTAssertFalse(try isWin())
    }

    func testIsWin_isTrue_whenFiveInARowInTheFirstRow() throws {
        for xPosition in 0..<5 {
            let intersection = Intersection(row: 0, column: xPosition)
            try board.placeStone(intersection: intersection, player: .white)
        }

        XCTAssertTrue(try isWin())
    }

    func testIsWin_isTrue_whenSixInARowInTheFirstRow() throws {
        for xPosition in 0..<6 {
            let intersection = Intersection(row: 0, column: xPosition)
            try board.placeStone(intersection: intersection, player: .white)
        }

        XCTAssertTrue(try isWin())
    }

    func testIsWin_isTrue_whenFiveInARowInAnyRow() throws {
        for yPosition in 0..<Board.Config.HEIGHT {
            board = Board()
            for xPosition in 0..<5 {
                let intersection = Intersection(row: yPosition, column: xPosition)
                try board.placeStone(intersection: intersection, player: .white)
            }
        }

        XCTAssertTrue(try isWin())
    }

    // MARK: Private
    private func isWin() throws -> Bool {
        try rules.isWin(board: board)
    }
}
