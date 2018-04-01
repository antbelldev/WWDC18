import Foundation

public class Block {
    public let index: Int!
    public let dateCreated: String!
    public let transactions: [Transaction]
    
    init(index: Int, dateCreated: String, transactions: [Transaction]) {
        self.index = index
        self.dateCreated = dateCreated
        self.transactions = transactions
    }
}
