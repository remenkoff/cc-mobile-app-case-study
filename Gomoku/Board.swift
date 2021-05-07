final class Board {

    // MARK: Nested
    enum Config {
        static let WIDTH = 19
        static let HEIGHT = 19
    }

    // MARK: Properties
    var placedStones = [Int: Player]()

    // MARK: Public
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

    // MARK: Private
    private func makeLocation(intersection: Intersection) throws -> Int {
        guard isLocationValid(row: intersection.row, column: intersection.column) else {
            throw BoardError.BadLocation
        }
        return intersection.column * Config.WIDTH + intersection.row
    }

    private func isLocationValid(row: Int, column: Int) -> Bool {
        (0..<Config.HEIGHT).contains(row) && (0..<Config.WIDTH).contains(column)
    }
}
