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
    var recipeToBeDeleted : NSManagedObject?
    
    static let sharedInstance = DataManager()
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    func insertFavProduct(myProduct: Product,productRate:Double) {
        let entity = NSEntityDescription.entity(forEntityName: Constants.CD_ENTITY_NAME, in: manager)
        let product = NSManagedObject(entity: entity ?? NSEntityDescription(), insertInto: manager)
        product.setValue(myProduct.title, forKey: Constants.ENTITY_ROW_TITLE)
        product.setValue(myProduct.id, forKey: Constants.ENTITY_ROW_ID)
        product.setValue(myProduct.variants?[0].price, forKey: Constants.ENTITY_ROW_PRICE)
        product.setValue(productRate, forKey: Constants.ENTITY_ROW_RATE)
        product.setValue(myProduct.image?.src, forKey: Constants.ENTITY_ROW_IMAGE)
        do{
            try manager.save()
            print("inserted product : \(product)")
            print("product Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getStoredProducts() -> [Product] {
        var productsArray : [CDProduct]?
        var myProducts = [Product]()
        let fetch = NSFetchRequest<CDProduct>(entityName: Constants.CD_ENTITY_NAME)

        do{
            productsArray = try manager.fetch(fetch)
            guard let productsArray = productsArray else{
                print("error")
                return []
            }
            
            for item in productsArray{
                var myProduct = Product()
                myProduct.title = item.value(forKey: Constants.ENTITY_ROW_TITLE) as? String
                myProduct.id = item.value(forKey: Constants.ENTITY_ROW_ID) as? Int
                myProduct.variants?[0].price = item.value(forKey: Constants.ENTITY_ROW_PRICE) as? String
                myProduct.image?.src = item.value(forKey: Constants.ENTITY_ROW_IMAGE) as? String
              
                myProducts.append(myProduct)
            }

        }catch let error{
            print(error.localizedDescription)
        }

        return myProducts
    }

    
    func deleteFavProduct(myProduct: Product) {
        let fetch = NSFetchRequest<CDProduct>(entityName: Constants.CD_ENTITY_NAME)
        fetch.predicate = NSPredicate(format: "id == %@", myProduct.id ?? "")
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
    
    func isProductExist(myProduct: Product) -> Bool {
        let fetch = NSFetchRequest<CDProduct>(entityName: Constants.CD_ENTITY_NAME)
        fetch.predicate = NSPredicate(format: "id == %@", myProduct.id ?? "")
        do {
            let myFavouriteList = try manager?.fetch(fetch)
            guard let favourite = myFavouriteList else {
                return false
            }
            return (favourite.count != 0) ?  true :  false
           // if(favourite.count != 0){ return true }else{ return false }
        }catch{
            print("error in product is exist function")
            return false
        }
        
    }
}
