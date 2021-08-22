import XCTest

final class GomokuRulesTest: XCTestCase {
    private var board: (Board & BoardState)!
    private var rules: GomokuRules!

    override func setUp() {
        super.setUp()
        GomokuGame.boardFactory = BoardFactoryImpl()
        board = GomokuGame.boardFactory.makeBoard()
        rules = GomokuRules()
    }

    override func tearDown() {
        rules = nil
        board = nil
        super.tearDown()
    }

    func testIsWin_isFalse_whenBoardIsEmpty() {
        XCTAssertFalse(rules.isWin(board, .WHITE))
        XCTAssertFalse(rules.isWin(board, .BLACK))
    }

    func testIsWin_isFalse_whenBoardIsNotEmptyButNotWin() {
        let stone = randomStone()

        board.placeStone(.zero, stone)

        XCTAssertFalse(rules.isWin(board, stone))
    }

    func testIsWin_isFalse_whenFourInARowInTheFirstRow() {
        let stone = randomStone()

        for column in 0..<rules.numberOfStonesForWin - 1 {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertFalse(rules.isWin(board, stone))
    }

    func testIsWin_isTrue_whenFiveInARowInTheFirstRow() {
        let stone = randomStone()

        for column in 0..<rules.numberOfStonesForWin {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertTrue(rules.isWin(board, stone))
    }

    func testIsWin_isTrue_whenSixInARowInTheFirstRow() {
        let stone = randomStone()

        for column in 0..<rules.numberOfStonesForWin + 1 {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertTrue(rules.isWin(board, stone))
    }

    func testIsWin_isFalseForOtherStone_whenFiveInARow() {
        for column in 0..<rules.numberOfStonesForWin {
            board.placeStone(Intersection(0, column), .WHITE)
        }

        XCTAssertFalse(rules.isWin(board, .BLACK))
    }

    func testIsWin_isTrue_whenFiveInARowInAnyRow() {
        let stone = randomStone()

        for row in 0..<board.numberOfRows {
            board = GomokuGame.boardFactory.makeBoard()

            for column in 0..<rules.numberOfStonesForWin {
                board.placeStone(Intersection(row, column), stone)
            }

            XCTAssertTrue(rules.isWin(board, stone))
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

        XCTAssertFalse(rules.isWin(board, stone))
    }

    func testIsWin_isTrue_whenFiveInARowInAnyColumn() {
        let stone = randomStone()

        for column in 0..<board.numberOfCols {
            board = GomokuGame.boardFactory.makeBoard()

            for row in 0..<rules.numberOfStonesForWin {
                board.placeStone(Intersection(row, column), stone)
            }

            XCTAssertTrue(rules.isWin(board, stone))
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

        XCTAssertFalse(rules.isWin(board, stone))
    }

    func testIsWin_isTrue_whenFiveConsecutiveInColumn() {
        let stone = randomStone()

        for column in 0..<board.numberOfCols {
            board.placeStone(Intersection(0, column), stone)
        }

        XCTAssertTrue(rules.isWin(board, stone))
    }
}
