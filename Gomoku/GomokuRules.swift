final class GomokuRules {
    func isWin(board: Board) throws -> Bool {
        let yPosition = 0
        var playerPiecesInARow = 0

        for xPosition in 0..<board.NUMBER_OF_COLUMNS {
            let intersection = Intersection(row: yPosition, column: xPosition)
            let playerPiece = try board.getStone(intersection: intersection)
            if playerPiece == .white {
                playerPiecesInARow += 1
            }
        }

        return playerPiecesInARow >= 5
    }
}
