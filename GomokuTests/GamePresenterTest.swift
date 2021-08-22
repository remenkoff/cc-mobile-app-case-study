import XCTest

final class GamePresenterTest: XCTestCase {
    private var gamePresenter: GomokuPresenter!

    override func setUp() {
        super.setUp()
        gamePresenter = GomokuPresenter()
    }

    override func tearDown() {
        gamePresenter = nil
        super.tearDown()
    }

    func testGetTurnStatusText_returnsProperlyFormattedStatusText() {
        XCTAssertEqual(gamePresenter.getTurnStatusText(.WHITE), "White's Turn")
        XCTAssertEqual(gamePresenter.getTurnStatusText(.BLACK), "Black's Turn")
    }

    func testGetStoneStatusColor_returnsAppropriateStatusColor() {
        XCTAssertEqual(gamePresenter.getStatusTextColor(.WHITE), 0xFFFFFF)
        XCTAssertEqual(gamePresenter.getStatusTextColor(.BLACK), 0x000000)
    }

    func testGetWinStatusText_returnsProperlyFormattedStatusText() {
        XCTAssertEqual(gamePresenter.getWinStatusText(.WHITE), "White Wins!")
        XCTAssertEqual(gamePresenter.getWinStatusText(.BLACK), "Black Wins!")
    }
}
