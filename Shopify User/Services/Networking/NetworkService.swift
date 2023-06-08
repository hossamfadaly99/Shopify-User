//
//  NetworkService.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//

import Foundation
import Alamofire

protocol NetworkService{
    func loadData<T: Decodable>(url:String,param :Parameters,header : HTTPHeaders ,compilitionHandler: @escaping (T?, Error?) -> Void)
}
class MonicaNetworkManager : NetworkService{
    
     func loadData<T: Decodable>(url:String,param :Parameters,header : HTTPHeaders,compilitionHandler: @escaping (T?, Error?) -> Void){
         
        AF.request(url,parameters: param,headers: header).responseDecodable(of: T.self){ response in
            debugPrint(response)

            guard response.data != nil else{
                compilitionHandler(nil , response.error)
                return
            }
            do{
                guard let data = response.data else{
                    compilitionHandler(nil , response.error)
                    return
                }
                let result = try JSONDecoder().decode(T.self, from: data)
                compilitionHandler(result,nil)

            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil,error)
            }
        }
        
    }
}
