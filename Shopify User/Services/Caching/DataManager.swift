//
//  DataManager.swift
//  Shopify User
//
//  Created by MAC on 10/06/2023.
//

import Foundation
import CoreData
import UIKit

class DataManager : DataManagerProtocol{
    
    var manager : NSManagedObjectContext!
    static let sharedInstance = DataManager()
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    func insertFavProduct(myProduct: ProductCoreData,productRate:Double) {
        let entity = NSEntityDescription.entity(forEntityName: Constants.CD_ENTITY_NAME, in: manager)
        let product = NSManagedObject(entity: entity ?? NSEntityDescription(), insertInto: manager)
        product.setValue(myProduct.title, forKey: Constants.ENTITY_ROW_TITLE)
        product.setValue(myProduct.id, forKey: Constants.ENTITY_ROW_ID)
        product.setValue(myProduct.price, forKey: Constants.ENTITY_ROW_PRICE)
        product.setValue(productRate, forKey: Constants.ENTITY_ROW_RATE)
        product.setValue(myProduct.Pimage, forKey: Constants.ENTITY_ROW_IMAGE)
        do{
            try manager.save()
            print("inserted product : \(myProduct)")
            print("product Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getStoredProducts() -> [ProductCoreData] {
        var productsArray : [CDProduct]?
        var myProducts = [ProductCoreData]()
        let fetch = NSFetchRequest<CDProduct>(entityName: Constants.CD_ENTITY_NAME)

        do{
            productsArray = try manager.fetch(fetch)
            guard let productsArray = productsArray else{
                print("error")
                return []
            }
            
            for item in productsArray{
                var myProduct = ProductCoreData()
                myProduct.title = item.value(forKey: Constants.ENTITY_ROW_TITLE) as? String
                myProduct.id = item.value(forKey: Constants.ENTITY_ROW_ID) as? Int
                myProduct.price = item.value(forKey: Constants.ENTITY_ROW_PRICE) as? String
                myProduct.Pimage = item.value(forKey: Constants.ENTITY_ROW_IMAGE) as? String
                print("coraData Image :\(myProduct.Pimage)")
                myProducts.append(myProduct)
                print("Fetched products:\(myProduct)")
            }

        }catch let error{
            print(error.localizedDescription)
        }

        return myProducts
    }

    
    func deleteFavProduct(myProduct: ProductCoreData) {
        let fetch = NSFetchRequest<CDProduct>(entityName: Constants.CD_ENTITY_NAME)
        fetch.predicate = NSPredicate(format: "title == %@", myProduct.title ?? "")
        do {
            let items = try manager?.fetch(fetch)
            if let itemToDelete = items?.first {
                manager?.delete(itemToDelete)
                try manager?.save()
                print("Product Deleted")
            }
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
    
    func isProductExist(myProduct: ProductCoreData) -> Bool {
        let fetchRequest = NSFetchRequest<CDProduct>(entityName: Constants.CD_ENTITY_NAME)
        fetchRequest.predicate = NSPredicate(format: "title == %@", myProduct.title ?? "" )
        do {
            let myFavouriteList = try manager?.fetch(fetchRequest)
            guard let myFavouriteList = myFavouriteList else {
                return false
            }
            if(myFavouriteList.count != 0){
                print(myFavouriteList.count)
                return true
            }else{
                return false
            }
        } catch {
            print("Error in isProductExist function: \(error)")
            return false
        }
    }

}
