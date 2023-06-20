import Foundation

struct DraftOrderResponse: Codable {

  var draftOrders : [MyDraftOrders]? = []

  enum CodingKeys: String, CodingKey {

    case draftOrders = "draft_orders"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    draftOrders = try values.decodeIfPresent([MyDraftOrders].self , forKey: .draftOrders )
 
  }

  init() {

  }

}

struct MyDraftOrder : Codable{
    
    var draft_order : MyDraftOrders?
    
    init(myDraftOrder:MyDraftOrders){
        self.draft_order = myDraftOrder
        
    }
}



struct MyDraftOrders: Codable {

  var id                : Int?             = nil
  var note              : String?          = nil
  var email             : String?          = nil
  var name              : String?          = nil
  var totalPrice        : String?          = nil
  var taxesIncluded     : Bool?            = nil
  var currency          : String?          = nil
  var createdAt         : String?          = nil
  var updatedAt         : String?          = nil
  var taxExempt         : Bool?            = nil
  var completedAt       : String?          = nil
  var lineItems         : [WishLineItems]?     = []
  var shippingAddress   : ShippingAddress? = ShippingAddress()
  var invoiceUrl        : String?          = nil
  var appliedDiscount   : AppliedDiscount?          = nil
  var orderId           : Int?             = nil
  var taxLines          : [MyTaxLines]?        = []
  var tags              : String?          = nil
  var subtotalPrice     : String?          = nil
  var totalTax          : String?          = nil
  var customer          : Customer?        = Customer()

  enum CodingKeys: String, CodingKey {

    case id                = "id"
    case note              = "note"
    case email             = "email"
    case name              = "name"
    case totalPrice        = "total_price"
    case taxesIncluded     = "taxes_included"
    case currency          = "currency"
    case createdAt         = "created_at"
    case updatedAt         = "updated_at"
    case taxExempt         = "tax_exempt"
    case completedAt       = "completed_at"
    case lineItems         = "line_items"
    case shippingAddress   = "shipping_address"
    case invoiceUrl        = "invoice_url"
    case appliedDiscount   = "applied_discount"
    case orderId           = "order_id"
    case taxLines          = "tax_lines"
    case tags              = "tags"
    case subtotalPrice     = "subtotal_price"
    case totalTax          = "total_tax"
    case customer          = "customer"
  
  }
    init(id:Int,lineItems:[WishLineItems]){
        self.id = id
        self.lineItems = lineItems
        self.note = "cart"
       // self.currency = getCurrency()
    }
    
    init(id:Int,lineItems:[WishLineItems],note:String){
        self.id = id
        self.lineItems = lineItems
        self.note = note
        //self.currency = getCurrency()
    }
  init() {

  }

}





struct AppliedDiscount: Codable {

  var appliedDiscount : ApliedDiscountDetails?

  enum CodingKeys: String, CodingKey {

    case appliedDiscount = "applied_discount"
  
  }

  init() {

  }

}

struct ApliedDiscountDetails: Codable {

  var description : String? = nil
  var value       : String? = nil
  var title       : String? = nil
  var amount      : String? = nil
  var valueType   : String? = nil

  enum CodingKeys: String, CodingKey {

    case description = "description"
    case value       = "value"
    case title       = "title"
    case amount      = "amount"
    case valueType   = "value_type"
  
  }


  init() {

  }

}


struct ShippingAddress: Codable {

  var firstName    : String? = nil
  var address1     : String? = nil
  var phone        : String? = nil
  var city         : String? = nil
  var zip          : String? = nil
  var province     : String? = nil
  var country      : String? = nil
  var lastName     : String? = nil
  var address2     : String? = nil
  var company      : String? = nil
  var latitude     : Double? = nil
  var longitude    : Double? = nil
  var name         : String? = nil
  var countryCode  : String? = nil
  var provinceCode : String? = nil

  enum CodingKeys: String, CodingKey {

    case firstName    = "first_name"
    case address1     = "address1"
    case phone        = "phone"
    case city         = "city"
    case zip          = "zip"
    case province     = "province"
    case country      = "country"
    case lastName     = "last_name"
    case address2     = "address2"
    case company      = "company"
    case latitude     = "latitude"
    case longitude    = "longitude"
    case name         = "name"
    case countryCode  = "country_code"
    case provinceCode = "province_code"
  
  }


  init() {

  }

}

struct MyTaxLines: Codable {
    
    var rate  : Double? = nil
    var title : String? = nil
    var price : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case rate  = "rate"
        case title = "title"
        case price = "price"
        
    }
    
    
    
    init() {
        
    }
}
