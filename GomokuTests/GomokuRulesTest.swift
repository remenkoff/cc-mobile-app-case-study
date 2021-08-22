import XCTest

final class GomokuRulesTest: XCTestCase {
    private var board: Board!
    private var rules: GomokuRules!

    override func setUp() {
        super.setUp()
        board = BoardData()
        rules = GomokuRules()
    }

    override func tearDown() {
        rules = nil
        board = nil
        super.tearDown()
    }

    func testIsWin_isFalse_whenBoardIsEmpty() {
        XCTAssertFalse(isWin(.white))
        XCTAssertFalse(isWin(.black))
    }

    func testIsWin_isFalse_whenBoardIsNotEmptyButNotWin() {
        let stone = randomStone()

        board.placeStone(.zero, stone)

        XCTAssertFalse(isWin(stone))
    }

    func testIsWin_isFalse_whenFourInARowInTheFirstRow() {
        let stone = randomStone()

        for column in 0..<rules.numberOfStonesForWin - 1 {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertFalse(isWin(stone))
    }

    func testIsWin_isTrue_whenFiveInARowInTheFirstRow() {
        let stone = randomStone()

        for column in 0..<rules.numberOfStonesForWin {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertTrue(isWin(stone))
    }

    func testIsWin_isTrue_whenSixInARowInTheFirstRow() {
        let stone = randomStone()

        for column in 0..<rules.numberOfStonesForWin + 1 {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertTrue(isWin(stone))
    }

    func testIsWin_isFalseForOtherStone_whenFiveInARow() {
        for column in 0..<rules.numberOfStonesForWin {
            board.placeStone(Intersection(0, column), .white)
        }

        XCTAssertFalse(isWin(.black))
    }

    func testIsWin_isTrue_whenFiveInARowInAnyRow() {
        let stone = randomStone()

        for row in 0..<board.numberOfRows {
            board = BoardData()

            for column in 0..<rules.numberOfStonesForWin {
                board.placeStone(Intersection(row, column), stone)
            }

            XCTAssertTrue(isWin(stone))
        }
    }

    func testIsWin_isFalse_whenFiveNonConsecutiveInRow() {
        let stone = randomStone()
        let nonConsecutiveStonesWithOffsets: [Int: Stone] = [
            1: stone,
            3: stone,
            5: stone,
            7: stone,
            9: stone,
        ]

        nonConsecutiveStonesWithOffsets.forEach { stoneWithOffset in
            board.placeStone(Intersection(stoneWithOffset.key, 0), stoneWithOffset.value)
        }

        XCTAssertFalse(isWin(stone))
    }

    func testIsWin_isTrue_whenFiveInARowInAnyColumn() {
        let stone = randomStone()

        for column in 0..<board.numberOfCols {
            board = BoardData()

            for row in 0..<rules.numberOfStonesForWin {
                board.placeStone(Intersection(row, column), stone)
            }

            XCTAssertTrue(isWin(stone))
        }
    }

    func testIsWin_isFalse_whenFiveNonConsecutiveInColumn() {
        let stone = randomStone()
        let nonConsecutiveStonesWithOffsets: [Int: Stone] = [
            1: stone,
            3: stone,
            5: stone,
            7: stone,
            9: stone,
        ]

        nonConsecutiveStonesWithOffsets.forEach { stoneWithOffset in
            board.placeStone(Intersection(0, stoneWithOffset.key), stoneWithOffset.value)
        }

        XCTAssertFalse(isWin(stone))
    }

    func testIsWin_isTrue_whenFiveConsecutiveInColumn() {
        let stone = randomStone()

        for column in 0..<board.numberOfCols {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertTrue(isWin(stone))
    }

    private func isWin(_ stone: Stone) -> Bool {
        rules.isWin(board, stone)
    }
}
