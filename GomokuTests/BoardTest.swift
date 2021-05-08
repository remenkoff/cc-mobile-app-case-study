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

    func testPlaceStone_addsTheSameAndTheOnlyOneStone() throws {
        var intersection = Intersection(row: 1, column: 1)
        var player = Player.white

        try board.placeStone(intersection: intersection, player: player)
        let placedWhiteStone = try board.getStone(intersection: intersection)

        XCTAssertEqual(board.placedStones.count, 1)
        XCTAssertEqual(placedWhiteStone, player)

        intersection = .zero
        player = .black

        try board.placeStone(intersection: intersection, player: player)
        let placedBlackStone = try board.getStone(intersection: intersection)

        XCTAssertEqual(board.placedStones.count, 2)
        XCTAssertEqual(placedBlackStone, player)
    }

    func testGetStone_returnsNothing_whenBoardIsNew() throws {
        XCTAssertEqual(try board.getStone(intersection: .zero), .nothing)
    }

    func testGetStone_returnsTheStone_whenAStoneIsPlaced() throws {
        let player = randomPlayer()
        let intersection: Intersection = .zero
        try board.placeStone(intersection: intersection, player: player)

        XCTAssertEqual(try board.getStone(intersection: intersection), player)
    }

    func testPlaceStone_throwsError_whenIntersectionIsOccupied() throws {
        let expectedError = BoardError.PlaceOccupied
        let intersection: Intersection = .zero

        try board.placeStone(intersection: intersection, player: .white)

        XCTAssertThrowsError(
            try board.placeStone(intersection: intersection, player: .black),
            expectedError.localizedDescription
        ) { error in

            guard let thrownError = error as? BoardError else {
                XCTFail("An error of the \(BoardError.self) type was expected to be thrown.")
                return
            }

            XCTAssertEqual(thrownError, expectedError)
        }
    }

    func testPlaceStone_throwsError_whenIntersectionIsOutsideBounds() throws {
        let expectedError = BoardError.BadLocation
        let invalidIntersections = [
            Intersection(row: -1, column: -1),
            Intersection(row: 0, column: -1),
            Intersection(row: -1, column: 0),
            Intersection(row: board.NUMBER_OF_ROWS, column: board.NUMBER_OF_COLUMNS),
            Intersection(row: 0, column: board.NUMBER_OF_COLUMNS),
            Intersection(row: board.NUMBER_OF_ROWS, column: 0),
        ]

        func assertPlaceStoneThrowsErrorAt(intersection: Intersection) {
            XCTAssertThrowsError(
                try board.placeStone(intersection: intersection, player: randomPlayer()),
                expectedError.localizedDescription
            ) { error in

                guard let thrownError = error as? BoardError else {
                    XCTFail("An error of the \(BoardError.self) type was expected to be thrown.")
                    return
                }

                XCTAssertEqual(thrownError, expectedError)
            }
        }

        for invalidIntersection in invalidIntersections {
            assertPlaceStoneThrowsErrorAt(intersection: invalidIntersection)
        }
        XCTAssertEqual(board.placedStones.count, 0)
    }
}
