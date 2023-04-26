//
//  RequestLayer.swift
//  CurrencyConverterApp
//
//  Created by 김승태 on 2023/04/16.
//

import Foundation

struct RequestLayer {
    
    static func requestData(completion: @escaping (CurrencyModel) -> Void) {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        
        guard let url = URL(string: urlString) else {
            return
        }
        // data test
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let setData = data else {
                return
            }
            do {
                //JSON 데이터를 currencyModel로 만들기
                let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: setData)
        
                // 함수 밭같부분에서 실행될수. 있으면 이스케이프 붙히기
                completion(currencyModel)
                
                
//                //가져온 데이터를 정렬시켜서 튜플 형식으로 저장
//                self.rates = currencyModel.rates?.sorted{ $0.key < $1.key }
//
//                //피커를 새로고침해야함 UI는 메인스레드에서 사용해야하기때문에 메인스레드 이용
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
                
            }catch {
                print(error)
            }
        }.resume()

    }
    
}
