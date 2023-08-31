// Copyright SIX DAY LLC. All rights reserved.

import BigInt
import Foundation
import JSONRPCKit

struct GetTransactionCountRequest: JSONRPCKit.Request {
    typealias Response = Int

    let address: AlphaWallet.Address
    let state: String

    var method: String {
        return "eth_getTransactionCount"
    }

    var parameters: Any? {
        return [
            address.eip55String,
            state,
        ]
    }

    func response(from resultObject: Any) throws -> Response {
        if let response = resultObject as? String {
            return BigInt(response.drop0x, radix: 16).map({ numericCast($0) }) ?? 0
        } else {
            throw CastError(actualValue: resultObject, expectedType: Response.self)
        }
    }
}
