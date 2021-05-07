enum BoardError: Error {
    case PlaceOccupied
    case BadLocation

    var localizedDescription: String {
        "\(BoardError.self).\(self)"
    }
}
