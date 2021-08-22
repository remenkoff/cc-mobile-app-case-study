protocol GameDataFactory {
    func makeData() -> Board & BoardState
}
