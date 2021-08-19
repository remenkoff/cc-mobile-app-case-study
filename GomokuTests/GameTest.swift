import XCTest

final class GameTest: XCTestCase {
    private var board: Board!
    private var game: Game!

    override func setUp() {
        super.setUp()
        board = Board()
        game = Game(board, GomokuRules())
    }

    override func tearDown() {
        game = nil
        board = nil
        super.tearDown()
    }

    func testWhoseTurn_returnsBlackStone_whenGameStarts() {
        XCTAssertEqual(game.whoseTurn, .black)
    }

    func testTakeTurn_makesOtherStonesTurn_afterTurn() {
        let blackStone: Stone = .black
        let whiteStone: Stone = .white
        let zeroIntersection: Intersection = .zero
        let intersection = Intersection(1, 0)

        game.takeTurn(zeroIntersection)

        XCTAssertEqual(try! board.getStone(zeroIntersection).get(), blackStone)
        XCTAssertEqual(game.whoseTurn, whiteStone)

        game.takeTurn(intersection)

        XCTAssertEqual(try! board.getStone(intersection).get(), whiteStone)
        XCTAssertEqual(game.whoseTurn, blackStone)
    }
}
