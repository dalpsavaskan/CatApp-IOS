//
//  KittenDataSource.swift
//  MyKittens
//
//  Created by Deniz Alp Savaskan on 30.11.2018.
//  Copyright © 2018 Deniz Alp Savaskan. All rights reserved.
//

import Foundation

protocol KittenDataSourceDelegate {
    func kittenListLoaded(kittenList: [Kitten])
    func kittenDetailLoaded(kittenDetail: Kitten)
}

extension KittenDataSourceDelegate {
    func kittenListLoaded(kittenList: [Kitten]) {}
    func kittenDetailLoaded(kittenDetail: Kitten) {}
}
class KittenDataSource{
    
    var delegate: KittenDataSourceDelegate?
    
    func loadKittenList() {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "http://172.20.80.10:3000/")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            let kittenList = try! decoder.decode([Kitten].self, from: data!)
            self.delegate?.kittenListLoaded(kittenList: kittenList)
        }
        dataTask.resume()
    }
    
     func loadKittenDetail(kittenId: Int) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "http://172.20.80.10:3000/\(kittenId)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            let kittenDetail = try! decoder.decode(Kitten.self, from: data!)
            self.delegate?.kittenDetailLoaded(kittenDetail: kittenDetail)
        }
        dataTask.resume()
     }
}

