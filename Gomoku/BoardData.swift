final class BoardFactoryImpl: BoardFactory {
    func makeBoard() -> Board & BoardState {
        BoardData()
    }
}

private final class BoardData: Board, BoardState {
    let numberOfRows = 19
    let numberOfCols = 19

    private var placedStones = [Location: Stone]()

    func placeStone(_ intersection: Intersection, _ stone: Stone) -> Result<Void, BoardError> {
        switch makeLocation(intersection) {
            case .success(let location):
                if let _ = placedStones[location] {
                    return .failure(.PLACE_OCCUPIED)
                }
                placedStones[location] = stone

            case .failure(let error):
                return .failure(error)
        }
        return .success(Void())
    }

    func getStone(_ intersection: Intersection) -> Result<Stone, BoardError> {
        switch makeLocation(intersection) {
            case .success(let location):
                if let stone = placedStones[location] {
                    return .success(stone)
                } else {
                    return .failure(.STONE_NOT_FOUND)
                }
            case .failure(let error):
                return .failure(error)
        }
    }

    func getPlacedStones() -> [Location: Stone] {
        placedStones
    }

    private func makeLocation(_ intersection: Intersection) -> Result<Location, BoardError> {
        if isNotValidLocation(intersection) {
            return .failure(.BAD_LOCATION)
        }
        let intersection = intersection.column * numberOfCols + intersection.row
        return .success(intersection)
    }

    private func isNotValidLocation(_ intersection: Intersection) -> Bool {
        !((0..<numberOfRows).contains(intersection.row) && (0..<numberOfCols).contains(intersection.column))
    }
}
