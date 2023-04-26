//
//  Model.swift
//  CurrencyConverterApp
//
//  Created by 김승태 on 2023/04/13.
//

import Foundation

// 일반적으로 서버에서 오는 이름으로 선언해야함
struct CurrencyModel: Codable {
    let result: String?
    let provider: String?
    let baseCode: String?
    let rates: [String : Double]?
    let time: Int?
    
    // 받는키랑 사용키랑 다르게 사용할때
    enum CodingKeys: String, CodingKey {
        case result
        case provider
        case baseCode = "base_code"
        case rates
        case time = "time_last_update_unix"
    }
}
