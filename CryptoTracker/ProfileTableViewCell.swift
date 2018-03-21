//
//  ProfileTableViewCell.swift
//  CryptoTracker
//
//  Created by Bryan Kho on 12/2/18.
//  Copyright © 2018 Maxwell Stein. All rights reserved.
//

import UIKit
import CoreData

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileGross: UILabel!
    @IBOutlet weak var profileVolume: UILabel!
    
    func populateCell(input: String, withCurrencyType currencytype: CurrencyType) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: input) // input gets passed to CoreData
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
            
                profileName.text = input
                profileVolume.text = data.value(forKey: "volume" ) as? String
                
                // might need to the above
            }
            
        } catch {
            
            print("Failed")
        }
        
        profileName.text = currencytype.name
        
        // this should be fetched through API and our Core Data
        profileGross.text = "100" // placeholder
        
        profileImage.image = currencytype.image
        
        // fetched from coredata
        profileVolume.text = "100" // placeholder
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
