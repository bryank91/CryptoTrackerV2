//
//  PortfolioTableViewController.swift
//  CryptoTracker
//
//  Created by Bryan Kho on 10/2/18.
//  Copyright © 2018 Maxwell Stein. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class PortfolioTableViewController: UITableViewController {

    let currencies: [CurrencyType] = [.btc, .eth, .ltc, .xrp, .bch, .etc]
    let currenciesString: [String] = ["btc", "eth", "ltc", "xrp", "bch", "etc"]
    let portfolioIdentifier = String(describing: PortfolioTableViewCell.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        // Print all values from our core data
        for currency in currenciesString {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: currency.uppercased())
            //request.predicate = NSPredicate(format: "age = %@", "12")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "volume") as! Double)
                }
            } catch {
                print("Failed")
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return currencies.count
    }
    */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencies.count
    }

    // TO DO HERE:
    // try to make it to appear in the app
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: portfolioIdentifier, for: indexPath)

        if let portfolioTableViewCell = cell as? PortfolioTableViewCell {
            let currencyType = currencies[indexPath.row]
            portfolioTableViewCell.populateCell(withCurrencyType: currencyType)
            
        }

        return cell
    }
  
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Portfolio"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        print ("dataName type: \(currencies[indexPath.row].rawValue.uppercased())")
        
        // we now know what the data gives out. lets try adding to the entity
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: currencies[indexPath.row].rawValue.uppercased(), in: context)
        let crypto = NSManagedObject(entity: entity!, insertInto: context)
        
        crypto.setValue(10, forKey: "volume")
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
