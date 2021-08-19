final class GomokuRules {
    let numberOfStonesForWin = 5

    func isWin(_ board: Board) -> Bool {
        for row in 0..<board.NUMBER_OF_ROWS {
            var stonesInARow: [Stone: Int] = [.white: 0, .black: 0]
            for column in 0..<board.NUMBER_OF_COLUMNS {
                let intersection = Intersection(row, column)
                if let stone = try? board.getStone(intersection).get() {
                    stonesInARow[stone] = stonesInARow[stone]! + 1
                }
            }
            if let _ = stonesInARow.values.filter({ $0 >= numberOfStonesForWin }).first {
                return true
            }
        }
        return false
    }
}
