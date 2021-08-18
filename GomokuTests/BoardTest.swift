import XCTest

final class BoardTest: XCTestCase {

    private var board: Board!

    override func setUp() {
        super.setUp()
        board = Board()
    }

    override func tearDown() {
        board = nil
        super.tearDown()
    }

    func testPlacedStones_isEmpty_whenBoardIsNew() {
        XCTAssertEqual(board.placedStones.count, 0)
    }

    func testPlaceStone_addsTheSameAndTheOnlyOneStone() {
        var intersection = Intersection(row: 1, column: 1)
        var player: Player = .white

        board.placeStone(intersection: intersection, player: player)

        XCTAssertEqual(try! board.getStone(intersection: intersection).get(), player)
        XCTAssertEqual(board.placedStones.count, 1)

        intersection = .zero
        player = .black

        board.placeStone(intersection: intersection, player: player)

        XCTAssertEqual(try! board.getStone(intersection: intersection).get(), player)
        XCTAssertEqual(board.placedStones.count, 2)
    }

    func testGetStone_fails_whenBoardIsNew() {
        let expectedError = BoardError.stoneNotFound

        switch board.getStone(intersection: .zero) {
            case .success: XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
            case .failure(let error): XCTAssertEqual(error, expectedError)
        }
    }

    func testGetStone_returnsStone_whenPlaced() {
        let player = randomPlayer()
        let intersection: Intersection = .zero

        board.placeStone(intersection: intersection, player: player)

        XCTAssertEqual(try! board.getStone(intersection: intersection).get(), player)
    }

    func testPlaceStone_fails_whenIntersectionIsOccupied() {
        let expectedError = BoardError.placeOccupied
        let intersection: Intersection = .zero

        board.placeStone(intersection: intersection, player: .white)

        switch board.placeStone(intersection: intersection, player: .white) {
            case .success:
                XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
            case .failure(let error):
                XCTAssertEqual(error, expectedError)
        }
    }

    func testPlaceStone_fails_whenIntersectionIsOutsideBounds() {
        let expectedError: BoardError = .badLocation
        let invalidIntersections = [
            Intersection(row: -1, column: -1),
            Intersection(row: 0, column: -1),
            Intersection(row: -1, column: 0),
            Intersection(row: board.NUMBER_OF_ROWS, column: board.NUMBER_OF_COLUMNS),
            Intersection(row: 0, column: board.NUMBER_OF_COLUMNS),
            Intersection(row: board.NUMBER_OF_ROWS, column: 0),
        ]

        for invalidIntersection in invalidIntersections {
            assertPlaceStoneFailsAt(intersection: invalidIntersection, expectedError: expectedError)
        }
        XCTAssertEqual(board.placedStones.count, 0)
    }

    private func assertPlaceStoneFailsAt(intersection: Intersection, expectedError: BoardError) {
        let result = board.placeStone(intersection: intersection, player: randomPlayer())
        XCTAssertThrowsError(try result.get())
        switch result {
            case .success:
                XCTFail("Failure result with `\(expectedError)` error was expected, but result succeeded.")
            case .failure(let error):
                XCTAssertEqual(error, expectedError)
        }
    }
}
