final class GomokuRules {
    private enum Axis {
        case HORIZONTAL, VERTICAL
    }

    let numberOfStonesForWin = 5

    func isWin(_ board: BoardState, _ stone: Stone) -> Bool {
        isDimensionWin(.HORIZONTAL, board, stone) || isDimensionWin(.VERTICAL, board, stone)
    }

    private func isDimensionWin(_ axis: Axis, _ board: BoardState, _ stone: Stone) -> Bool {
        let maxWidth = axis == .HORIZONTAL ? board.numberOfRows : board.numberOfCols
        let maxHeight = axis == .VERTICAL ? board.numberOfCols : board.numberOfRows

        for row in 0..<maxWidth {
            var numberOfConsecutiveStones = 0
            for column in 0..<maxHeight {
                let intersection = axis == .HORIZONTAL ? Intersection(row, column) : Intersection(column, row)
                if let foundStone = try? board.getStone(intersection).get(), foundStone == stone {
                    numberOfConsecutiveStones += 1
                    if numberOfConsecutiveStones >= numberOfStonesForWin {
                        return true
                    }
                } else {
                    numberOfConsecutiveStones = 0
                }
            }
        }
        return false
    }
}
