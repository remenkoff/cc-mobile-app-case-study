final class GomokuGame {
    private let rules: GomokuRules
    private let data: Board & BoardState
    static var dataFactory: GameDataFactory!
    var boardWidth: Int {
        data.numberOfCols
    }
    var boardHeight: Int {
        data.numberOfRows
    }
    var whoseTurn: Stone {
        data.whoseTurn
    }

    init() {
        data = GomokuGame.dataFactory.makeData()
        rules = GomokuRules()
    }

    @discardableResult
    func takeTurn(_ intersection: Intersection) -> BoardError? {
        switch data.placeStone(intersection, data.whoseTurn) {
            case .success: return nil
            case .failure(let boardError): return boardError
        }
    }

    func findOutTheWinner() -> Stone? {
        rules.findOutTheWinner(data)
    }

    func getStone(_ intersection: Intersection) -> Stone? {
        switch data.getStone(intersection) {
            case .success(let stone): return stone
            case .failure: return nil
        }
    }
}
