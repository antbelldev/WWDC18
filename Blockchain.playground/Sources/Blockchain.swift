import Foundation

public class Blockchain {
    
    public var currentTransactions: [Transaction] = []
    public var blockchain = [Block]()
    
    public init() {
        createBlock()
    }
    
    public func createBlock() -> Block {
        
        
        let block = Block(index: blockchain.count + 1, dateCreated: String(Date().timeIntervalSince1970), transactions: currentTransactions)
        blockchain.append(block)
        
        currentTransactions = []
        
        return block
    }
    
    public func createTransaction(sender: String, recipient: String, amount: Int) -> Int {
        let transaction = Transaction(sender: sender, recipient: recipient, amount: amount)
        currentTransactions.append(transaction)
        
        return blockchain.last!.index + 1
    }
}
