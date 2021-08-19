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

    func testGetTurnStatus_returnsProperlyFormattedStatus() {
        XCTAssertEqual(gamePresenter.getTurnStatus(.white), "White's Turn")
        XCTAssertEqual(gamePresenter.getTurnStatus(.black), "Black's Turn")
    }
}
