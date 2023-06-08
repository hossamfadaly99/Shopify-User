/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Draft_orders : Codable {
	let id : Int?
	let note : String?
	let email : String?
	let taxes_included : Bool?
	let currency : String?
	let invoice_sent_at : String?
	let created_at : String?
	let updated_at : String?
	let tax_exempt : Bool?
	let completed_at : String?
	let name : String?
	let status : String?
	let line_items : [Line_items]?
	let shipping_address : Shipping_address?
	let billing_address : Billing_address?
	let invoice_url : String?
	let applied_discount : Applied_discount?
	let order_id : String?
	let shipping_line : String?
	let tax_lines : [TaxLine]?
	let tags : String?
	let note_attributes : [String]?
	let total_price : String?
	let subtotal_price : String?
	let total_tax : String?
	let payment_terms : String?
	let admin_graphql_api_id : String?
	let customer : DraftOrderCustomer?

}
