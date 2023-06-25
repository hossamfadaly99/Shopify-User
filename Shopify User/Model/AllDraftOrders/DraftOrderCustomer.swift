/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DraftOrderCustomer : Codable {
	var id : Int?
	let email : String?
	let accepts_marketing : Bool?
	let created_at : String?
	let updated_at : String?
	let first_name : String?
	let last_name : String?
	let orders_count : Int?
	let state : String?
	let total_spent : String?
	let last_order_id : Int?
	let note : String?
	let verified_email : Bool?
	let multipass_identifier : String?
	let tax_exempt : Bool?
	let tags : String?
	let last_order_name : String?
	let currency : String?
	let phone : String?
	let accepts_marketing_updated_at : String?
	let marketing_opt_in_level : String?
	let tax_exemptions : [String]?
	let email_marketing_consent : Email_marketing_consent?
	let sms_marketing_consent : Sms_marketing_consent?
	let admin_graphql_api_id : String?
	let default_address : Default_address?


}

