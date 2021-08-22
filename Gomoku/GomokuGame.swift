final class GomokuGame {
    private let rules: GomokuRules
    let board: Board & BoardState
    static var boardFactory: BoardFactory!
    private(set) var whoseTurn: Stone = .BLACK

    init() {
        board = GomokuGame.boardFactory.makeBoard()
        rules = GomokuRules()
    }

    func takeTurn(_ intersection: Intersection) {
        board.placeStone(intersection, whoseTurn)
        whoseTurn = next()
    }

    func findOutTheWinner() -> Stone? {
        if rules.isWin(board, .WHITE) {
            return .WHITE
        }
        else if rules.isWin(board, .BLACK) {
            return .BLACK
        }
        else {
            return nil
        }
    }

    private func next() -> Stone {
        whoseTurn == .WHITE ? .BLACK : .WHITE
    }
}
