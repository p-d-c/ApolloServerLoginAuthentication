import Foundation
import Apollo

class Network {
  static let shared = Network()
  
  // Configure the network transport to use the singleton as the delegate.
  private lazy var networkTransport = HTTPNetworkTransport(
    url: URL(string: "http://localhost:4000/graphql.dev.rtw.team")!
  )
    
  // Use the configured network transport in your Apollo client.
  private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
}

