import SwiftUI

struct NFTAuctionView: View {
    @State private var start_price: String
    @State private var network: String
    @State private var date: String
    @State var NFTAuction: NftAuction
    @State var url: String
    let token_id: String
    let wallet:WalletTable = Search_Wallet(Count: 0, database: wallet_test.database_test)!
    var body: some View {
        NavigationView{
            Form{
                TextField("起始价格", text: $start_price)
                    .prefixedWithIcon(named: "bitcoinsign.circle.fill")
                TextField("有效日期", text: $date)
                    .prefixedWithIcon(named: "timer")
                TextField("选择主链", text: $network)
                    .prefixedWithIcon(named: "link.circle.fill")
                Button(
                    action: {
                        NFTAuction.expirationTime = Int(date)!
                        NFTAuction.start_price = Int(start_price)!
                        NFTAuction.network = network
                        NFTAuction.owner_address = wallet.WalletAccount!
                        NFTAuction.my_mnemonic = wallet.WalletMnemonic!
                        NFTAuction.token_id = token_id
                        url = UploadNftAuction(NftAuction: NFTAuction)
                    },
                    label: { Text("确定") }
                )
            }.navigationTitle(Text("定价拍卖"))
            if #available(iOS 15.0, *) {
                Link("Go To OpenSea", destination: URL(string: url)!)
                    .buttonStyle(.borderedProminent)
            } else {
                Link("Go To OpenSea", destination: URL(string: url)!)
            }
        }
    }
}
