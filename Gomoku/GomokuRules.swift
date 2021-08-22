final class GomokuRules {
    private enum Axis {
        case horizontal, vertical
    }

    let numberOfStonesForWin = 5

    func isWin(_ board: Board, _ stone: Stone) -> Bool {
        isDimensionWin(.horizontal, board, stone) || isDimensionWin(.vertical, board, stone)
    }

    private func isDimensionWin(_ axis: Axis, _ board: Board, _ stone: Stone) -> Bool {
        let maxWidth = axis == .horizontal ? board.numberOfRows : board.numberOfCols
        let maxHeight = axis == .vertical ? board.numberOfCols : board.numberOfRows

        for row in 0..<maxWidth {
            var numberOfConsecutiveStones = 0
            for column in 0..<maxHeight {
                let intersection = axis == .horizontal ? Intersection(row, column) : Intersection(column, row)
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
