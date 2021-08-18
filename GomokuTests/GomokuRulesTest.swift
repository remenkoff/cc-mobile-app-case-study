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
        board.placeStone(intersection: .zero, player: randomPlayer())

        XCTAssertFalse(isWin())
    }

    func testIsWin_isFalse_whenFourInARowInTheFirstRow() {
        for xPosition in 0..<4 {
            let intersection = Intersection(row: 0, column: xPosition)
            board.placeStone(intersection: intersection, player: .white)
        }

        XCTAssertFalse(isWin())
    }

    func testIsWin_isTrue_whenFiveInARowInTheFirstRow() {
        for xPosition in 0..<5 {
            let intersection = Intersection(row: 0, column: xPosition)
            board.placeStone(intersection: intersection, player: .white)
        }

        XCTAssertTrue(isWin())
    }

    func testIsWin_isTrue_whenSixInARowInTheFirstRow() {
        for xPosition in 0..<6 {
            let intersection = Intersection(row: 0, column: xPosition)
            board.placeStone(intersection: intersection, player: .white)
        }

        XCTAssertTrue(isWin())
    }

    func testIsWin_isTrue_whenFiveInARowInAnyRow() {
        for row in 0..<board.NUMBER_OF_ROWS {
            board = Board()
            for column in 0..<5 {
                let intersection = Intersection(row: row, column: column)
                board.placeStone(intersection: intersection, player: .white)
            }

            XCTAssertTrue(isWin())
        }
    }

    private func isWin() -> Bool {
        rules.isWin(board: board)
    }
}
