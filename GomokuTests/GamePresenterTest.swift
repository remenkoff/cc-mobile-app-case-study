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

    func testGetStoneStatusColor_returnsAppropriateStatusColor() {
        XCTAssertEqual(gamePresenter.getStatusTextColor(.white), 0xFFFFFF)
        XCTAssertEqual(gamePresenter.getStatusTextColor(.black), 0x000000)
    }

    func testGetWinStatusText_returnsProperlyFormattedStatusText() {
        XCTAssertEqual(gamePresenter.getWinStatusText(.white), "White Wins!")
        XCTAssertEqual(gamePresenter.getWinStatusText(.black), "Black Wins!")
    }
}
