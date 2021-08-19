import XCTest

final class GomokuRulesTest: XCTestCase {
    
    private var board: Board!
    private var rules: GomokuRules!

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

    func testIsWin_isFalse_whenBoardIsEmpty() {
        XCTAssertFalse(isWin())
    }

    func testIsWin_isFalse_whenBoardIsNotEmptyButNotWin() {
        board.placeStone(.zero, randomStone())

        XCTAssertFalse(isWin())
    }

    func testIsWin_isFalse_whenFourInARowInTheFirstRow() {
        for column in 0..<4 {
            let intersection = Intersection(0, column)
            board.placeStone(intersection, .white)
        }

        XCTAssertFalse(isWin())
    }

    func testIsWin_isTrue_whenFiveInARowInTheFirstRow() {
        for column in 0..<rules.numberOfStonesForWin {
            let intersection = Intersection(0, column)
            board.placeStone(intersection, .white)
        }

        XCTAssertTrue(isWin())
    }

    func testIsWin_isTrue_whenSixInARowInTheFirstRow() {
        for column in 0..<6 {
            let intersection = Intersection(0, column)
            board.placeStone(intersection, .white)
        }

        XCTAssertTrue(isWin())
    }

    func testIsWin_isTrue_whenFiveInARowInAnyRow() {
        for row in 0..<board.NUMBER_OF_ROWS {
            board = Board()
            for column in 0..<rules.numberOfStonesForWin {
                let intersection = Intersection(row, column)
                board.placeStone(intersection, .white)
            }

            XCTAssertTrue(isWin())
        }
    }

    private func isWin() -> Bool {
        rules.isWin(board)
    }
}
