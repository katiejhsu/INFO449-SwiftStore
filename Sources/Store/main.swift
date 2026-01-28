//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

/* All items sold in the store have a "stock keeping unit" (SKU) number associated with them. When the item is swiped over the barcode scanner, the tag on the item sends the SKU to the Register, where it is looked up and added to the Receipt. To support this, you need to:
 
 Implement SKU as a protocol. It should require a property name that retrieves the name of the item, and a method price that returns the price (as an Int, in USD pennies).
 When a Register is created, have it create a Receipt on which to capture all the items scanned.
 On the Register class, implement a scan method that takes a SKU as a parameter, and add the SKU to the Receipt.
 The Register is responsible for displaying the total along the way, so you need to:

 Implement a subtotal method that returns the current total for all the items on the Receipt.
 Implmement a total method that returns the Receipt (which contains all the items scanned), and clears its state to start a new Receipt. (In other words, subtotal displays the price along the way, whereas total is the finished transaction.)
 The Receipt is a list of the entire transaction.

 Implement an items method that returns the list of SKUs that were scanned.
 Implement an output method to print out all of the items stored on the Receipt.
 Create a class Item that implements SKU and uses a price-per-item pricing scheme. That is to say, a $4.99 can of beans (an Iten("Beans", 499)) or a $.99 pencil (a Item("Pencil", 99)).

 Create a unit test that tests adding a single Item to the Register and displays its subtotal (which should be the single Item's price).
 Total: 5 points.

 You must have unit tests that exercise your code, and your tests must pass.

 Note that there is a natural inclination to have a minimal number of tests that each test trivial things; while we don't expect you to create thousands of tests, we reserve the right to dock points if we feel like you're not testing even the simplest of things.*/

import Foundation

protocol SKU {
    var name : String { get }
    func price() -> Int
}

class Item : SKU {
    var name : String
    var priceEach: Int
    
    init(name: String, priceEach: Int) {
            self.name = name
            self.priceEach = priceEach
        }

    func price() -> Int {
        return priceEach
    }
}

class Receipt {
    var itemsOnReceipt: [SKU] = []
    
    func add(_ item: SKU) {
        itemsOnReceipt.append(item)
    }
    
    func items() -> [SKU]{
        return itemsOnReceipt
    }
    
    func output() -> String {
        var receiptString = "Receipt:\n" // Ensure no space after "Receipt:"
        var runningTotal = 0
        
        for item in itemsOnReceipt {
            let price = item.price()
            runningTotal += price
            // Use the format to include the $ sign directly if needed, or ensure no extra spaces
            let formattedPrice = String(format: "$%d.%02d", price / 100, price % 100)
            receiptString += "\(item.name): \(formattedPrice)\n"
        }
        
        receiptString += "------------------\n"
        let totalFormatted = String(format: "$%d.%02d", runningTotal / 100, runningTotal % 100)
        receiptString += "TOTAL: \(totalFormatted)"
        
        return receiptString
    }
    
    func total() -> Int {
        var sum = 0
        for item in itemsOnReceipt {
            sum += item.price()
        }
        return sum
    }
}

// register.scan(Item(name: "Beans (8oz Can)", priceEach: 199))
class Register {
    var receipt = Receipt()

    func scan(_ sku: SKU) {
        receipt.add(sku)
    }

    func subtotal() -> Int {
        var total = 0
        for item in receipt.itemsOnReceipt {
            total += item.price()
        }
        return total
    }

    func total() -> Receipt {
        let returnedReceipt = receipt
        receipt = Receipt()
        return returnedReceipt
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}

