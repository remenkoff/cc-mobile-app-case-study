final class Board {
    typealias BoardLocation = Int

    let NUMBER_OF_COLUMNS = 19
    let NUMBER_OF_ROWS = 19
    private(set) var placedStones = [BoardLocation: Player]()

    @discardableResult
    func placeStone(intersection: Intersection, player: Player) -> Result<Void, BoardError> {
        switch makeLocation(intersection: intersection) {
            case .success(let location):
                if let _ = placedStones[location] {
                    return .failure(.placeOccupied)
                }
                placedStones[location] = player

            case .failure(let error):
                return .failure(error)
        }
        return .success(Void())
    }

    func getStone(intersection: Intersection) -> Result<Player, BoardError> {
        switch makeLocation(intersection: intersection) {
            case .success(let location):
                if let stone = placedStones[location] {
                    return .success(stone)
                } else {
                    return .failure(.stoneNotFound)
                }
            case .failure(let error):
                return .failure(error)
        }
    }

    private func makeLocation(intersection: Intersection) -> Result<BoardLocation, BoardError> {
        if isNotValidLocation(intersection: intersection) {
            return .failure(.badLocation)
        }
        let intersection = intersection.column * NUMBER_OF_COLUMNS + intersection.row
        return .success(intersection)
    }

    private func isNotValidLocation(intersection: Intersection) -> Bool {
        !((0..<NUMBER_OF_ROWS).contains(intersection.row) && (0..<NUMBER_OF_COLUMNS).contains(intersection.column))
    }
}
