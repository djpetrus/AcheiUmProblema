//
//  UIViewController+Context.swift
//  AcheiUmProblema
//
//  Created by Petrus Ribeiro Lima da Costa on 02/01/22.
//

import CoreData
import UIKit


extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        return appDelagate.persistentContainer.viewContext
    }
}
