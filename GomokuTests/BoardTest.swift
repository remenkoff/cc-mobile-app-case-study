import XCTest

final class BoardTest: XCTestCase {
    private var board: (Board & BoardState)!

    override func setUp() {
        super.setUp()
        GomokuGame.boardFactory = BoardFactoryImpl()
        board = GomokuGame.boardFactory.makeBoard()
    }

    override func tearDown() {
        board = nil
        super.tearDown()
    }

    func testPlacedStones_isEmpty_whenBoardIsNew() {
        XCTAssertEqual(board.getPlacedStones().count, 0)
    }

    func testPlaceStone_addsTheSameAndTheOnlyOneStone() {
        var intersection = Intersection(1, 1)
        var stone: Stone = .WHITE

        board.placeStone(intersection, stone)

        XCTAssertEqual(try! board.getStone(intersection).get(), stone)
        XCTAssertEqual(board.getPlacedStones().count, 1)

        intersection = .zero
        stone = .BLACK

        board.placeStone(intersection, stone)

        XCTAssertEqual(try! board.getStone(intersection).get(), stone)
        XCTAssertEqual(board.getPlacedStones().count, 2)
    }

    func testGetStone_fails_whenBoardIsNew() {
        let expectedError: BoardError = .STONE_NOT_FOUND

        switch board.getStone(.zero) {
            case .success: XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
            case .failure(let error): XCTAssertEqual(error, expectedError)
        }
    }
    
    func testGetStone_fails_whenInvalidIntersectionProvided() {
        let expectedError: BoardError = .BAD_LOCATION

        switch board.getStone(Intersection(-1, -1)) {
            case .success: XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
            case .failure(let error): XCTAssertEqual(error, expectedError)
        }
    }

    func testGetStone_returnsStone_whenPlaced() {
        let stone = randomStone()
        let intersection: Intersection = .zero

        board.placeStone(intersection, stone)

        XCTAssertEqual(try! board.getStone(intersection).get(), stone)
    }

    func testPlaceStone_fails_whenIntersectionIsOccupied() {
        let expectedError: BoardError = .PLACE_OCCUPIED
        let intersection: Intersection = .zero
        let stone = randomStone()

        board.placeStone(intersection, stone)

        switch board.placeStone(intersection, stone) {
            case .success:
                XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
            case .failure(let error):
                XCTAssertEqual(error, expectedError)
        }
    }

    func testPlaceStone_fails_whenIntersectionIsOutsideBounds() {
        let expectedError: BoardError = .BAD_LOCATION
        let invalidIntersections = [
            Intersection(-1, -1),
            Intersection(0, -1),
            Intersection(-1, 0),
            Intersection(board.numberOfRows, board.numberOfCols),
            Intersection(0, board.numberOfCols),
            Intersection(board.numberOfRows, 0),
        ]

        for invalidIntersection in invalidIntersections {
            let result = board.placeStone(invalidIntersection, randomStone())
            XCTAssertThrowsError(try result.get())
            switch result {
                case .success:
                    XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
                case .failure(let error):
                    XCTAssertEqual(error, expectedError)
            }
        }
        XCTAssertEqual(board.getPlacedStones().count, 0)
    }
}
