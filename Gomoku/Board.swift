protocol Board {
    @discardableResult
    func placeStone(_ intersection: Intersection, _ stone: Stone) -> Result<Void, BoardError>
}
