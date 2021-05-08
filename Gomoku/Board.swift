final class Board {
    let NUMBER_OF_COLUMNS = 19
    let NUMBER_OF_ROWS = 19
    var placedStones = [Int: Player]()

    func placeStone(intersection: Intersection, player: Player) throws {
        let location = try makeLocation(intersection: intersection)
        guard placedStones[location] == nil else {
            throw BoardError.PlaceOccupied
        }
        placedStones[location] = player
    }

    func getStone(intersection: Intersection) throws -> Player {
        let location = try makeLocation(intersection: intersection)
        if let stone = placedStones[location] {
            return stone
        }
        return .nothing
    }

    private func makeLocation(intersection: Intersection) throws -> Int {
        guard isLocationValid(row: intersection.row, column: intersection.column) else {
            throw BoardError.BadLocation
        }
        return intersection.column * NUMBER_OF_COLUMNS + intersection.row
    }

    private func isLocationValid(row: Int, column: Int) -> Bool {
        (0..<NUMBER_OF_ROWS).contains(row) && (0..<NUMBER_OF_COLUMNS).contains(column)
    }
}
