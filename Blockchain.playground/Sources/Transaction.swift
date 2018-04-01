import Foundation

public class Transaction {
    public let sender: String
    public let recipient: String
    public let amount: Int
    
    init(sender: String, recipient: String, amount: Int) {
        self.sender = sender
        self.recipient = recipient
        self.amount = amount
    }
}
