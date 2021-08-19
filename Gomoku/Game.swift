final class Game {
    private let rules: GomokuRules
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

    private func next() -> Stone {
        whoseTurn == .white ? .black : .white
    }
}
