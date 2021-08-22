final class GomokuRules {
    private enum Axis {
        case HORIZONTAL, VERTICAL
    }

    private let numberOfStonesToWin = 5

    func findOutTheWinner(_ board: BoardState) -> Stone? {
        if isWin(board, .WHITE) {
            return .WHITE
        }
        else if isWin(board, .BLACK) {
            return .BLACK
        }
        else {
            return nil
        }
    }

    func isWin(_ board: BoardState, _ stone: Stone) -> Bool {
        isDimensionWin(.HORIZONTAL, board, stone) || isDimensionWin(.VERTICAL, board, stone)
    }

    private func isDimensionWin(_ axis: Axis, _ board: BoardState, _ stone: Stone) -> Bool {
        let maxWidth = axis == .HORIZONTAL ? board.numberOfRows : board.numberOfCols
        let maxHeight = axis == .VERTICAL ? board.numberOfCols : board.numberOfRows

        for row in 0..<maxWidth {
            var consecutiveStones = 0
            for column in 0..<maxHeight {
                let intersection = axis == .HORIZONTAL ? Intersection(row, column) : Intersection(column, row)
                let foundStone = try? board.getStone(intersection).get()
                if countConsecutiveStones(&consecutiveStones, foundStone, stone) >= numberOfStonesToWin {
                    return true
                }
            }
        }
        return false
    }

    private func countConsecutiveStones(_ consecutiveStones: inout Int, _ foundStone: Stone?, _ stone: Stone) -> Int {
        consecutiveStones = foundStone == stone ? consecutiveStones + 1 : 0
        return consecutiveStones
    }
}
