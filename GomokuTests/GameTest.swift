import XCTest

final class GameTest: XCTestCase {
    private var game: GomokuGame!

    override func setUp() {
        super.setUp()
        game = GomokuGame()
    }

    override func tearDown() {
        game = nil
        super.tearDown()
    }

    func testWhoseTurn_returnsBlackStone_whenGameStarts() {
        XCTAssertEqual(game.whoseTurn, .BLACK)
    }

    func testTakeTurn_makesOtherStonesTurn_afterTurn() {
        let blackStone: Stone = .BLACK
        let whiteStone: Stone = .WHITE
        let zeroIntersection: Intersection = .zero
        let intersection = Intersection(1, 0)

        game.takeTurn(zeroIntersection)

        XCTAssertEqual(try! game.board.getStone(zeroIntersection).get(), blackStone)
        XCTAssertEqual(game.whoseTurn, whiteStone)

        game.takeTurn(intersection)

        XCTAssertEqual(try! game.board.getStone(intersection).get(), whiteStone)
        XCTAssertEqual(game.whoseTurn, blackStone)
    }

    func testWhoseWin_returnsWhite_whenWhiteWins() {
        let stone: Stone = .WHITE

        for row in 0..<game.board.numberOfRows {
            game.board.placeStone(Intersection(row, 0), stone)
        }

        XCTAssertEqual(stone, game.findOutTheWinner())
    }

    func testWhoseWin_returnsBlack_whenBlackWins() {
        let stone: Stone = .BLACK

        for row in 0..<game.board.numberOfRows {
            game.board.placeStone(Intersection(row, 0), stone)
        }

        XCTAssertEqual(.BLACK, game.findOutTheWinner())
    }

    func testWhoseWin_returnsNil_whenNoOneWins() {
        XCTAssertEqual(nil, game.findOutTheWinner())
    }
}
