protocol BoardFactory {
    func makeBoard() -> Board & BoardState
}
