import XCTest
@testable import Gomoku

final class BoardTest: XCTestCase {

    // MARK: Properties
    private var sut: Board!

    // MARK: Lifecycle
    override func setUp() {
        super.setUp()
        sut = Board()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests
    func testPlacedStones_isEmpty_whenBoardIsNew() {
        XCTAssertEqual(sut.placedStones.count, 0)
    }

    func testPlaceStone_addsTheSameAndTheOnlyOneStone() throws {
        var intersection = Intersection(row: 1, column: 1)
        var player = Player.white

        try sut.placeStone(intersection: intersection, player: player)
        let placedWhiteStone = try sut.getStone(intersection: intersection)

        XCTAssertEqual(sut.placedStones.count, 1)
        XCTAssertEqual(placedWhiteStone, player)

        intersection = .zero
        player = .black

        try sut.placeStone(intersection: intersection, player: player)
        let placedBlackStone = try sut.getStone(intersection: intersection)

        XCTAssertEqual(sut.placedStones.count, 2)
        XCTAssertEqual(placedBlackStone, player)
    }

    func testGetStone_returnsNothing_whenBoardIsNew() throws {
        XCTAssertEqual(try sut.getStone(intersection: .zero), .nothing)
    }

    func testGetStone_returnsTheStone_whenAStoneIsPlaced() throws {
        let player = randomPlayer()
        let intersection: Intersection = .zero
        try sut.placeStone(intersection: intersection, player: player)

        XCTAssertEqual(try sut.getStone(intersection: intersection), player)
    }

    func testPlaceStone_throwsError_whenIntersectionIsOccupied() throws {
        let expectedError = BoardError.PlaceOccupied
        let intersection: Intersection = .zero

        try sut.placeStone(intersection: intersection, player: .white)

        XCTAssertThrowsError(
            try sut.placeStone(intersection: intersection, player: .black),
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
            Intersection(row: Board.Config.HEIGHT, column: Board.Config.WIDTH),
            Intersection(row: 0, column: Board.Config.WIDTH),
            Intersection(row: Board.Config.HEIGHT, column: 0),
        ]

        func assertPlaceStoneThrowsErrorAt(intersection: Intersection) {
            XCTAssertThrowsError(
                try sut.placeStone(intersection: intersection, player: randomPlayer()),
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
        XCTAssertEqual(sut.placedStones.count, 0)
    }
}
