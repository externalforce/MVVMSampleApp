//
//  ImdbService.swift
//  ImdbListSample
//
//  Created by Muhammet Gokhan Yavuz on 14.12.2021.
//

import Alamofire


enum EndPoint: String {
    case url = "https://www.omdbapi.com"
    case path = "/?s=friends&apikey=f5133d7"

    static func searchPath() -> String {
        return "\(url.rawValue)\(path.rawValue)"
    }
}

protocol ImdbListServiceProtocol {
    func fetchAllDatas(response: @escaping ([Film]?) -> Void)
}


struct ImdbListService: ImdbListServiceProtocol {

    func fetchAllDatas(response: @escaping ([Film]?) -> Void) {
        AF.request(EndPoint.searchPath()).responseDecodable(of: FilmList.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.search)
        }
    }

}
