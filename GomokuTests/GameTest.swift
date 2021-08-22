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

        XCTAssertEqual(game.getStone(zeroIntersection), blackStone)
        XCTAssertEqual(game.whoseTurn, whiteStone)

        game.takeTurn(intersection)

        XCTAssertEqual(game.getStone(intersection), whiteStone)
        XCTAssertEqual(game.whoseTurn, blackStone)
    }

    func testWhoseWin_returnsBlack_whenBlackWins() {
        for row in 0..<4 {
            game.takeTurn(Intersection(row, 0))
            game.takeTurn(Intersection(row, 1))
        }
        game.takeTurn(Intersection(4, 0))

        XCTAssertEqual(.BLACK, game.findOutTheWinner())
    }

    func testWhoseWin_returnsWhite_whenWhiteWins() {
        game.takeTurn(.zero)
        for row in 1..<5 {
            game.takeTurn(Intersection(row, 0))
            game.takeTurn(Intersection(row, 1))
        }
        game.takeTurn(Intersection(5, 0))

        XCTAssertEqual(.WHITE, game.findOutTheWinner())
    }

    func testWhoseWin_returnsNil_whenNoOneWins() {
        XCTAssertEqual(nil, game.findOutTheWinner())
    }
}
