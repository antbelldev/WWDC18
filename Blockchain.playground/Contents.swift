//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//MARK: Functions

//Bitcoin Address

func generateP2PKH() -> String {
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< 30 {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return "1" + randomString
}

//MARK: Balance

func generateBalance() -> Int {
    let random = Int(arc4random_uniform(50))
    return 350 + random
}

//MARK: Blockchain

let blockchain = Blockchain()

func send(sender: String, recipient: String, amount: Int) -> Int {
    return blockchain.createTransaction(sender: sender, recipient: recipient, amount: amount)
}

func mine(recipient: String) -> Int {
    blockchain.createBlock()
    return blockchain.createTransaction(sender: "0", recipient: recipient, amount: 6)
    
}

func chain() -> [Block] {
    return blockchain.blockchain
}

//MARK: Constants

var register: [String:String] = [:]

let swiftcoinValue = 8

let backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
let mainColor = UIColor(red: 206/255, green: 169/255, blue: 50/255, alpha: 1)

let accountId = generateP2PKH()
register[accountId] = "You"
let balance = generateBalance()
let balanceConverted = Float(balance) / Float(swiftcoinValue)

let address1 = generateP2PKH()
let amount1 = Int(arc4random_uniform(100))
register[address1] = "Unknown"

let address2 = generateP2PKH()
let amount2 = Int(arc4random_uniform(100))
register[address2] = "Unknown"

let address3 = generateP2PKH()
let amount3 = Int(arc4random_uniform(100))
register[address3] = "Unknown"

let address4 = generateP2PKH()
let amount4 = Int(arc4random_uniform(100))
register[address4] = "Unknown"

let address5 = generateP2PKH()
let amount5 = Int(arc4random_uniform(100))
register[address5] = "Unknown"

let minerId = generateP2PKH()

var currentSelectedBlock = 0

class IntroViewController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        let textView = UITextView()
        textView.frame = CGRect(x: 20, y: 20, width: 330, height: 100)
        textView.text = "Hi ! Let's start !\nWelcome to an Introduction to Blockchain !"
        textView.textColor = .black
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textView.backgroundColor = backgroundColor
        textView.isEditable = false
        view.addSubview(textView)
        
        
        let subtitleTextView = UITextView()
        subtitleTextView.frame = CGRect(x: 20, y: 120, width: 330, height: 280)
        subtitleTextView.text = "You are the happy owner of a ledger (a wallet) and you will make today a transaction, sending money (under the form of a cryptocurrency) to one of your friends. We will assume that the cryptocurrency we use is built with blockchain.\n\nWhat we will run a simple example and then you will be able to explore the blocks contained in the blockchain. If you are interested and if there is more time left, you could also check out explanations I wrote about blockchain."
        subtitleTextView.textColor = .black
        subtitleTextView.textAlignment = .justified
        subtitleTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitleTextView.backgroundColor = backgroundColor
        subtitleTextView.isEditable = false
        view.addSubview(subtitleTextView)
        
        let currencyTextView = UITextView()
        currencyTextView.frame = CGRect(x: 20, y: 400, width: 330, height: 50)
        currencyTextView.text = "Our cryptocurrency is Swiftcoin (symbol: S$) and its current value is 1$ = \(swiftcoinValue)S$."
        currencyTextView.textColor = .black
        currencyTextView.textAlignment = .justified
        currencyTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        currencyTextView.backgroundColor = backgroundColor
        currencyTextView.isEditable = false
        view.addSubview(currencyTextView)
        
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 480, width: 150, height: 50)
        button.setTitle("Your Ledger", for: .normal)
        button.tintColor = .white
        button.backgroundColor = mainColor
        button.addTarget(self, action: #selector(seeLedger), for: .touchUpInside)
        view.addSubview(button)
        
        self.view = view
    }
    
    @objc func seeLedger() {
        PlaygroundPage.current.liveView = LedgerViewController()
    }
}

class LedgerViewController: UIViewController {
    
    override func loadView() {
        
        addTransactions()
        
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 15, width: 100, height: 30)
        button.setTitle("Back", for: .normal)
        button.tintColor = .white
        button.backgroundColor = mainColor
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(button)
        
        let ledgerLabel = UILabel()
        ledgerLabel.frame = CGRect(x: 15, y: 15, width: 330, height: 30)
        ledgerLabel.text = "Your Ledger"
        ledgerLabel.textColor = .black
        ledgerLabel.textAlignment = .right
        ledgerLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.addSubview(ledgerLabel)
        
        let accountTitleLabel = UILabel()
        accountTitleLabel.frame = CGRect(x: 20, y: 50, width: 330, height: 50)
        accountTitleLabel.text = "Account :"
        accountTitleLabel.textColor = .black
        accountTitleLabel.textAlignment = .left
        accountTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        accountTitleLabel.backgroundColor = backgroundColor
        accountTitleLabel.numberOfLines = 1
        view.addSubview(accountTitleLabel)
        
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 20, y: 100, width: 330, height: 50)
        accountLabel.text = "Account ID :\n\(accountId)"
        accountLabel.textColor = .black
        accountLabel.textAlignment = .left
        accountLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        accountLabel.backgroundColor = backgroundColor
        accountLabel.numberOfLines = 2
        view.addSubview(accountLabel)
        
        let balanceLabel = UILabel()
        balanceLabel.frame = CGRect(x: 20, y: 150, width: 330, height: 70)
        balanceLabel.text = "Balance :\n\(balance)S$\n~\(Int(balanceConverted))$"
        balanceLabel.textColor = .black
        balanceLabel.textAlignment = .left
        balanceLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        balanceLabel.backgroundColor = backgroundColor
        balanceLabel.numberOfLines = 3
        view.addSubview(balanceLabel)
        
        let transactionsLabel = UILabel()
        transactionsLabel.frame = CGRect(x: 20, y: 220, width: 330, height: 50)
        transactionsLabel.text = "Latest Transactions :"
        transactionsLabel.textColor = .black
        transactionsLabel.textAlignment = .left
        transactionsLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        transactionsLabel.backgroundColor = backgroundColor
        transactionsLabel.numberOfLines = 1
        view.addSubview(transactionsLabel)
        
        let transactionsTextView = UITextView()
        transactionsTextView.frame = CGRect(x: 20, y: 270, width: 330, height: 200)
        transactionsTextView.text = "\(address1)\n+\(amount1)S$\n\n\(address2)\n-\(amount2)S$\n\n\(address3)\n-\(amount3)S$"
        transactionsTextView.textColor = .black
        transactionsTextView.textAlignment = .justified
        transactionsTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        transactionsTextView.backgroundColor = backgroundColor
        transactionsTextView.isEditable = false
        view.addSubview(transactionsTextView)
        
        let transactionButton = UIButton()
        transactionButton.frame = CGRect(x: 85, y: 520, width: 200, height: 50)
        transactionButton.setTitle("Create Transaction", for: .normal)
        transactionButton.tintColor = .white
        transactionButton.backgroundColor = mainColor
        transactionButton.addTarget(self, action: #selector(createTransaction), for: .touchUpInside)
        view.addSubview(transactionButton)
        
//        let helpLabel = UILabel()
//        helpLabel.frame = CGRect(x: 20, y: 570, width: 330, height: 50)
//        helpLabel.text = "(that's what you should do next)"
//        helpLabel.textColor = .black
//        helpLabel.textAlignment = .center
//        helpLabel.font = UIFont.systemFont(ofSize: 14, weight: .thin)
//        helpLabel.backgroundColor = backgroundColor
//        helpLabel.numberOfLines = 1
//        view.addSubview(helpLabel)
        
        self.view = view
    }
    
    @objc func goBack() {
        PlaygroundPage.current.liveView = IntroViewController()
    }
    
    @objc func createTransaction() {
        PlaygroundPage.current.liveView = CreateTransactionViewController()
    }
    
    func addTransactions() {
        //1
        let miner1 = generateP2PKH()
        send(sender: address1, recipient: accountId, amount: amount1)
        mine(recipient: miner1)
        register[miner1] = "Unknown"
        
        //2
        let miner2 = generateP2PKH()
        send(sender: accountId, recipient: address2, amount: amount2)
        mine(recipient: generateP2PKH())
        register[miner2] = "Unknown"
        
        //3
        let miner3 = generateP2PKH()
        send(sender: accountId, recipient: address3, amount: amount3)
        mine(recipient: generateP2PKH())
        register[miner3] = "Unknown"
        
        //4
        let miner4 = generateP2PKH()
        send(sender: address4, recipient: accountId, amount: amount4)
        mine(recipient: generateP2PKH())
        register[miner4] = "Unknown"
        
        //5
        let miner5 = generateP2PKH()
        send(sender: address5, recipient: accountId, amount: amount5)
        mine(recipient: generateP2PKH())
        register[miner5] = "Unknown"
    }
}

class CreateTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let addresses = [address1, address2, address3, address4, address5]
    let names = ["Shelia", "Antoine", "Adrien", "Eleonora", "Ben"]
    
    var currentRow = 0
    
    let selectedReceiverLabel = UILabel()
    let amountSlider = UISlider()
    let selectedAmountLabel = UILabel()
    let confirmButton = UIButton()

    var timer: Timer!
    var timeElapsed = 0
    var timeCount = 0
    
    var transactionIndex = 0
    
    override func loadView() {
        
        for i in 0..<addresses.count {
            register[addresses[i]] = names[i]
        }
        
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 15, width: 100, height: 30)
        button.setTitle("Back", for: .normal)
        button.tintColor = .white
        button.backgroundColor = mainColor
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(button)
        
        let ledgerLabel = UILabel()
        ledgerLabel.frame = CGRect(x: 15, y: 15, width: 330, height: 30)
        ledgerLabel.text = "New Transaction"
        ledgerLabel.textColor = .black
        ledgerLabel.textAlignment = .right
        ledgerLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.addSubview(ledgerLabel)
        
        let receiverLabel = UILabel()
        receiverLabel.frame = CGRect(x: 20, y: 60, width: 330, height: 30)
        receiverLabel.text = "Receiver"
        receiverLabel.textColor = .black
        receiverLabel.textAlignment = .left
        receiverLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        receiverLabel.backgroundColor = backgroundColor
        receiverLabel.numberOfLines = 1
        view.addSubview(receiverLabel)
        
        let pickerView = UIPickerView()
        pickerView.frame = CGRect(x: 20, y: 90, width: 330, height: 150)
        pickerView.dataSource = self
        pickerView.delegate = self
        view.addSubview(pickerView)
        
        let amountLabel = UILabel()
        amountLabel.frame = CGRect(x: 20, y: 230, width: 330, height: 30)
        amountLabel.text = "Amount"
        amountLabel.textColor = .black
        amountLabel.textAlignment = .left
        amountLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        amountLabel.backgroundColor = backgroundColor
        amountLabel.numberOfLines = 1
        view.addSubview(amountLabel)
        
        amountSlider.frame = CGRect(x: 20, y: 270, width: 330, height: 30)
        amountSlider.minimumValue = 1.0
        amountSlider.maximumValue = Float(balance)
        amountSlider.value = Float(balance/2)
        amountSlider.tintColor = mainColor
        amountSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.addSubview(amountSlider)
        
        selectedAmountLabel.frame = CGRect(x: 20, y: 315, width: 330, height: 30)
        selectedAmountLabel.text = "\(balance/2)S$"
        selectedAmountLabel.textColor = .black
        selectedAmountLabel.textAlignment = .center
        selectedAmountLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        selectedAmountLabel.backgroundColor = backgroundColor
        selectedAmountLabel.numberOfLines = 1
        view.addSubview(selectedAmountLabel)
        
        let confirmLabel = UILabel()
        confirmLabel.frame = CGRect(x: 20, y: 350, width: 330, height: 30)
        confirmLabel.text = "Confirmation"
        confirmLabel.textColor = .black
        confirmLabel.textAlignment = .left
        confirmLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        confirmLabel.backgroundColor = backgroundColor
        confirmLabel.numberOfLines = 1
        view.addSubview(confirmLabel)
        
        selectedReceiverLabel.frame = CGRect(x: 20, y: 380, width: 330, height: 120)
        selectedReceiverLabel.text = "Send \(Int(balance/2))S$\nto :\n\(addresses[currentRow])\n\(names[currentRow])"
        selectedReceiverLabel.textColor = .black
        selectedReceiverLabel.textAlignment = .left
        selectedReceiverLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        selectedReceiverLabel.backgroundColor = backgroundColor
        selectedReceiverLabel.numberOfLines = 4
        view.addSubview(selectedReceiverLabel)
        
        confirmButton.frame = CGRect(x: 85, y: 520, width: 200, height: 50)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.tintColor = .white
        confirmButton.backgroundColor = mainColor
        confirmButton.addTarget(self, action: #selector(confirmTransaction), for: .touchUpInside)
        view.addSubview(confirmButton)
        
        self.view = view
    }
    
    @objc func sliderValueChanged() {
        selectedAmountLabel.text = "\(Int(amountSlider.value)) S$"
        selectedReceiverLabel.text = "Send \(Int(amountSlider.value))S$\nto :\n\(addresses[currentRow])\n\(names[currentRow])"
    }
    
    @objc func goBack() {
        PlaygroundPage.current.liveView = LedgerViewController()
    }
    
    @objc func confirmTransaction() {
        
        transactionIndex = send(sender: accountId, recipient: addresses[currentRow], amount: Int(amountSlider.value))
        
        self.showLoading()
    }
    
    func showLoading() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        timeCount += 1
    }

    @objc func timerRunning() {
        timeElapsed += 1
        print(timeCount, timeElapsed)
        
        if timeCount == 1 {
            let sendingAlertController = UIAlertController(title: "Sending...", message: "Your transaction is being added to the Block #\(transactionIndex).", preferredStyle: .alert)

            if timeElapsed > 4 {
                timeCount += 1
                dismiss(animated: true, completion: nil)
            } else {
                present(sendingAlertController, animated: true, completion: nil)
            }
        }
        else {
            let alertController = UIAlertController(title: "Mining...", message: "Waiting for the block to be forged. After this, the transaction will be confirmed.", preferredStyle: .alert)
            present(alertController, animated: true, completion: nil)

            if timeElapsed > 12 {
                dismiss(animated: true, completion: {
                    mine(recipient: minerId)
                    self.timer.invalidate()
                    PlaygroundPage.current.liveView = BlockchainViewController()
                })
            }
        }
        
        
    }
    
    //MARK: UIPickerViewDataSource & UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addresses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRow = row
        selectedReceiverLabel.text = "Send \(Int(amountSlider.value))S$\nto :\n\(addresses[row])\n\(names[row])"
    }
}

class BlockchainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func loadView() {
        
        print(blockchain.blockchain)
        
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 15, width: 100, height: 30)
        button.setTitle("Back", for: .normal)
        button.tintColor = .white
        button.backgroundColor = mainColor
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(button)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 15, width: 330, height: 30)
        titleLabel.text = "Blockchain"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.addSubview(titleLabel)
        
        let tableView = UITableView()
        tableView.frame = CGRect(x: 20, y: 60, width: 330, height: 440)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = backgroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        let newTransactionButton = UIButton()
        newTransactionButton.frame = CGRect(x: 85, y: 520, width: 200, height: 50)
        newTransactionButton.setTitle("New Transaction", for: .normal)
        newTransactionButton.tintColor = .white
        newTransactionButton.backgroundColor = mainColor
        newTransactionButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(newTransactionButton)
        
        let aboutButton = UIButton()
        aboutButton.frame = CGRect(x: 85, y: 600, width: 200, height: 50)
        aboutButton.setTitle("About Blockchain", for: .normal)
        aboutButton.tintColor = .white
        aboutButton.backgroundColor = mainColor
        aboutButton.addTarget(self, action: #selector(about), for: .touchUpInside)
        view.addSubview(aboutButton)
        
        self.view = view
    }
    
    @objc func goBack() {
        PlaygroundPage.current.liveView = CreateTransactionViewController()
    }
    
    @objc func about() {
        PlaygroundPage.current.liveView = AboutBlockchainViewController()
    }

    //MARK: UITableViewDataSource & UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockchain.blockchain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell") as UITableViewCell
        
        let currentBlock = blockchain.blockchain[indexPath.row]
        let transactions = currentBlock.transactions
        let transactionCount = transactions.count
        var transactionText = "transactions"

        if transactionCount < 2 {
            transactionText = "transaction"
        }
        
        cell.textLabel?.text = "Block #\(currentBlock.index!)"
        cell.detailTextLabel?.text = "\(transactionCount) \(transactionText)"
        cell.backgroundColor = backgroundColor
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedBlock = indexPath.row
        PlaygroundPage.current.liveView = BlockViewController()
    }
    
}

class BlockViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let block = blockchain.blockchain[currentSelectedBlock]

    override func loadView() {
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 15, width: 100, height: 30)
        button.setTitle("Back", for: .normal)
        button.tintColor = .white
        button.backgroundColor = mainColor
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(button)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 15, width: 330, height: 30)
        titleLabel.text = "Block #\(block.index!)"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.addSubview(titleLabel)
        
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 20, y: 60, width: 330, height: 50)
        dateLabel.text = "Date :"
        dateLabel.textColor = .black
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        dateLabel.backgroundColor = backgroundColor
        dateLabel.numberOfLines = 1
        view.addSubview(dateLabel)
        
        let currentDate: Date = Date(timeIntervalSince1970: Double(block.dateCreated)!)
        
        let timestampDateLabel = UILabel()
        timestampDateLabel.frame = CGRect(x: 20, y: 110, width: 330, height: 60)
        timestampDateLabel.text = "Timestamp : \(block.dateCreated!)\nDate : \(currentDate)"
        timestampDateLabel.textColor = .black
        timestampDateLabel.textAlignment = .left
        timestampDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        timestampDateLabel.backgroundColor = backgroundColor
        timestampDateLabel.numberOfLines = 2
        view.addSubview(timestampDateLabel)
        
        let transactionsLabel = UILabel()
        transactionsLabel.frame = CGRect(x: 20, y: 170, width: 330, height: 50)
        transactionsLabel.text = "Transactions :"
        transactionsLabel.textColor = .black
        transactionsLabel.textAlignment = .left
        transactionsLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        transactionsLabel.backgroundColor = backgroundColor
        transactionsLabel.numberOfLines = 1
        view.addSubview(transactionsLabel)
        
        let tableView = UITableView()
        tableView.frame = CGRect(x: 20, y: 220, width: 350, height: 300)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = backgroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        self.view = view
    }
    
    @objc func goBack() {
        PlaygroundPage.current.liveView = BlockchainViewController()
    }
    
    //MARK: UITableViewDataSource & UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return block.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell") as UITableViewCell
        
        let transaction = block.transactions[indexPath.row]
        let transactionSender = transaction.sender
        let sender = register[transactionSender]
        let transactionRecipient = transaction.recipient
        let recipient = register[transactionRecipient]
        let transactionAmount = transaction.amount
        
        if sender != nil && recipient != nil {
            cell.textLabel?.text = "\(sender!) -> \(recipient!)"
        } else {
            cell.textLabel?.text = "Swiftcoin -> Unknown (Mining Reward)"
        }
        cell.detailTextLabel?.text = "\(transactionAmount) S$"
        cell.backgroundColor = backgroundColor
        
        return cell
    }
}

class AboutBlockchainViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 15, width: 100, height: 30)
        button.setTitle("Back", for: .normal)
        button.tintColor = .white
        button.backgroundColor = mainColor
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(button)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 15, width: 330, height: 30)
        titleLabel.text = "About Blockchain"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.addSubview(titleLabel)
        
        let qaTextView = UITextView()
        qaTextView.frame = CGRect(x: 20, y: 60, width: 330, height: 580)
        qaTextView.text = "What is blockchain ?\nWe will talk here of blockchain used with a cryptocurrency.\nIt is a decentralized ledger made up of blocks.\n\nWhat is a ledger ?\nSimply your wallet : it contains your cryptocurrency (Swiftcoin or Bitcoin for example).\n\nWhat is a block ?\nA block contains transactions.\n\nHow does it work ?\nYou just experienced that in the Playground. You create a transaction which is added to a block. It must be then mined to be validated, this prevents from you using the coins of someone else for example.\n\nWhere is the cryptography inside ?\nThe original data inside the block is hashed. The miners will try to get as close to the original hash to mine the block.\n\nWhy mining ?\nBecause you get a reward ! For Bitcoins, it is currently 12.5 Bitcoins per block mined. This is as of today (2018/04/01) more than $80’000.\nThis reward allows the Bitcoin Central System to release progressively all of the 21 millions Bitcoin.\n\nWhy are they two transactions in my block (in the playground) ?\nThere is the transaction you created, sending money to a friend and the reward for the miner."
        qaTextView.textColor = .black
        qaTextView.textAlignment = .justified
        qaTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        qaTextView.backgroundColor = backgroundColor
        qaTextView.isEditable = false
        view.addSubview(qaTextView)
        
        self.view = view
    }
    
    @objc func goBack() {
        PlaygroundPage.current.liveView = BlockchainViewController()
    }
}

PlaygroundPage.current.liveView = IntroViewController()
