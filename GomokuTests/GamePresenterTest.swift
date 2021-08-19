import XCTest

final class GamePresenterTest: XCTestCase {
    private var gamePresenter: GamePresenter!

    override func setUp() {
        super.setUp()
        gamePresenter = GamePresenter()
    }

    override func tearDown() {
        gamePresenter = nil
        super.tearDown()
    }

    func testGetTurnStatusText_returnsProperlyFormattedStatusText() {
        XCTAssertEqual(gamePresenter.getTurnStatusText(.white), "White's Turn")
        XCTAssertEqual(gamePresenter.getTurnStatusText(.black), "Black's Turn")
    }

    func testGetTurnStatusColor_returnsAppropriateStatusColor() {
        XCTAssertEqual(gamePresenter.getTurnStatusColor(.white), 0xFFFFFF)
        XCTAssertEqual(gamePresenter.getTurnStatusColor(.black), 0x000000)
    }
}
