//
//  CryptoTableViewController.swift
//  CryptoTracker
//
//  Created by Maxwell Stein on 12/13/17.
//  Copyright © 2017 Maxwell Stein. All rights reserved.
//

import UIKit
import CoreData

final class CryptoTableViewController: UITableViewController {

    let currencies: [CurrencyType] = [.btc, .eth, .ltc, .xrp, .bch, .etc]
    let reuseIdentifier = String(describing: CryptoTableViewCell.self)
    
    override func viewDidLoad() {

        // start of core data
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "BTC", in: context)
        let crypto = NSManagedObject(entity: entity!, insertInto: context)
        
        /*
        // test init
        crypto.setValue(0.01, forKey: "currentPrice")
        crypto.setValue(0.02, forKey: "boughtPrice")
        crypto.setValue(100, forKey: "volume")
        */
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BTC")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                // print(data.value(forKey: "currentPrice") as! Double)
            }
            
        } catch {
            
            print("Failed")
        }
        
        // end of core data

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let cryptoTableViewCell = tableViewCell as? CryptoTableViewCell {
            let currencyType = currencies[indexPath.row]
            cryptoTableViewCell.formatCell(withCurrencyType: currencyType)
        }
        
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cryptocurrency Prices (BTCMarkets)"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return "Updated on " + dateString
    }

    @IBAction func doRefresh(_ sender: UIButton) {
        refresh()
    }
    
    func refresh() {
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }

}

