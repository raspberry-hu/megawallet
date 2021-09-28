import Foundation
struct Loan: Codable {
    var name: String
    var country: String
    var use: String
    var amount: Int
    init(_ name:String, _ country:String, _ use:String, _ amount: Int){
        self.name = name
        self.country = country
        self.use = use
        self.amount = amount
    }
}

let decoder = JSONDecoder()
let encoder = JSONEncoder()

func decode(json: String) -> (Loan?) {
    if let jsonData = json.data(using: .utf8) {
        do {
            let loan = try decoder.decode(Loan.self, from: jsonData)
            print(loan)
            return loan
        } catch {
            print(error)
        }
    }
    return nil
}

func encoder(loan: Loan) -> String?{
    do  {
        let data: Data = try encoder.encode(loan)
        let json_string = String(data: data, encoding: String.Encoding.utf8) ?? ""
        print(data)
        print(String(data: data, encoding: String.Encoding.utf8) as Any)
        print(loan)
        return json_string
    } catch {
        print(error)
    }
    return nil
}
