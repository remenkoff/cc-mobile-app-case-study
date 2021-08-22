protocol Board {
    typealias Location = Int
    var numberOfRows: Int { get }
    var numberOfCols: Int { get }
    func getStone(_ intersection: Intersection) -> Result<Stone, BoardError>
    func getPlacedStones() -> [Location: Stone]
    @discardableResult
    func placeStone(_ intersection: Intersection, _ stone: Stone) -> Result<Void, BoardError>
}
