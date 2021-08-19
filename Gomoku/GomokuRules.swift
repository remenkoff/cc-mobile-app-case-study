final class GomokuRules {
    let numberOfStonesForWin = 5
    func isWin(_ board: Board) -> Bool {
        for row in 0..<board.NUMBER_OF_ROWS {
            var playerPiecesInARow = [Player: Int]()
            playerPiecesInARow[.white] = 0
            playerPiecesInARow[.black] = 0
            for column in 0..<board.NUMBER_OF_COLUMNS {
                let intersection = Intersection(row, column)
                if let player = try? board.getStone(intersection).get() {
                    playerPiecesInARow[player] = playerPiecesInARow[player]! + 1
                }
            }
            if let _ = playerPiecesInARow.values.filter({ $0 >= numberOfStonesForWin }).first {
                return true
            }
        }
        return false
    }
}
