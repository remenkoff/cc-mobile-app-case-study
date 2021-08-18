enum BoardError: Error {
    case placeOccupied
    case badLocation
    case stoneNotFound

    var localizedDescription: String {
        "\(BoardError.self).\(self)"
    }
}
