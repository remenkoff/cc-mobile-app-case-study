final class Game {
    let rules: GomokuRules
    let board: Board
    private(set) var whoseTurn: Stone = .black

    init(_ board: Board, _ rules: GomokuRules) {
        self.board = board
        self.rules = rules
    }

    func takeTurn(_ intersection: Intersection) {
        board.placeStone(intersection, whoseTurn)
        whoseTurn = next()
    }

    func whoseWin() -> Stone? {
        if rules.isWin(board, .white) {
            return .white
        }
        else if rules.isWin(board, .black) {
            return .black
        }
        else {
            return nil
        }
    }

    private func next() -> Stone {
        whoseTurn == .white ? .black : .white
    }
}
