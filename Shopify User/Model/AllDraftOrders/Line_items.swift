/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Line_items : Codable {
	let id : Int?
	let variant_id : Int?
	let product_id : Int?
	let title : String?
	let variant_title : String?
	let sku : String?
	let vendor : String?
	let quantity : Int?
	let requires_shipping : Bool?
	let taxable : Bool?
	let gift_card : Bool?
	let fulfillment_service : String?
	let grams : Int?
	let tax_lines : [TaxLine]?
	let applied_discount : String?
	let name : String?
	let properties : [Properties]?
	let custom : Bool?
	let price : String?
	let admin_graphql_api_id : String?

}

struct TaxLine: Codable {
    let rate: Double?
    let title, price: String?
}

struct Properties: Codable {

  let name  : String?
  let value : String?

}
