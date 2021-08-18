final class GomokuRules {
    func isWin(board: Board) -> Bool {
        var playerPiecesInARow = 0
        for row in 0..<board.NUMBER_OF_ROWS {
            for column in 0..<board.NUMBER_OF_COLUMNS {
                let intersection = Intersection(row: row, column: column)
                if let player = try? board.getStone(intersection: intersection).get(), player == .white {
                    playerPiecesInARow += 1
                }
            }
        }
        return playerPiecesInARow >= 5
    }
}
