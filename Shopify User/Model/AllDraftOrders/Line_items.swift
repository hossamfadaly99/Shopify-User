/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Line_items : Codable {
	var id : Int?
	var variant_id : Int?
	var product_id : Int?
	var title : String?
	var variant_title : String?
	var sku : String?
	var vendor : String?
	var quantity : Int?
	var requires_shipping : Bool?
	var taxable : Bool?
	var gift_card : Bool?
	var fulfillment_service : String?
	var grams : Int?
	var tax_lines : [TaxLine]?
	var applied_discount : String?
	var name : String?
	var properties : [Properties]?
	var custom : Bool?
	var price : String?
	var admin_graphql_api_id : String?

}

struct TaxLine: Codable {
    var rate: Double?
    var title, price: String?
}

struct Properties: Codable {

  var name  : String?
  var value : String?

}
