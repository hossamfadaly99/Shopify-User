/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Draft_orders : Codable {
	var id : Int?
	var note : String?
	var email : String?
	var taxes_included : Bool?
	var currency : String?
	var invoice_sent_at : String?
	var created_at : String?
	var updated_at : String?
	var tax_exempt : Bool?
	var compvared_at : String?
	var name : String?
	var status : String?
	var line_items : [Line_items]?
	var shipping_address : Shipping_address?
	var billing_address : Billing_address?
	var invoice_url : String?
	var applied_discount : Applied_discount?
	var order_id : Int?
	var shipping_line : String?
	var tax_lines : [TaxLine]?
	var tags : String?
	var note_attributes : [String]?
	var total_price : String?
	var subtotal_price : String?
	var total_tax : String?
	var payment_terms : String?
	var admin_graphql_api_id : String?
	var customer : DraftOrderCustomer?

}
