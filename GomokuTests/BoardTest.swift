import XCTest

final class BoardTest: XCTestCase {
    private var board: Board!

    override func setUp() {
        super.setUp()
        board = BoardData()
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
        var stone: Stone = .white

        board.placeStone(intersection, stone)

        XCTAssertEqual(try! board.getStone(intersection).get(), stone)
        XCTAssertEqual(board.getPlacedStones().count, 1)

        intersection = .zero
        stone = .black

        board.placeStone(intersection, stone)

        XCTAssertEqual(try! board.getStone(intersection).get(), stone)
        XCTAssertEqual(board.getPlacedStones().count, 2)
    }

    func testGetStone_fails_whenBoardIsNew() {
        let expectedError: BoardError = .stoneNotFound

        switch board.getStone(.zero) {
            case .success: XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
            case .failure(let error): XCTAssertEqual(error, expectedError)
        }
    }
    
    func testGetStone_fails_whenInvalidIntersectionProvided() {
        let expectedError: BoardError = .badLocation

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
        let expectedError: BoardError = .placeOccupied
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
        let expectedError: BoardError = .badLocation
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
