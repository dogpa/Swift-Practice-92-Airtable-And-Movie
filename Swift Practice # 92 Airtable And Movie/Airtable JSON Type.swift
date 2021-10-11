//
//  Airtable JSON Type.swift
//  Swift Practice # 92 Airtable And Movie
//
//  Created by Dogpa's MBAir M1 on 2021/10/11.
//

import Foundation


struct AirtableJson: Decodable {
    let records: [AirtalbeSecondFloor]
}

struct AirtalbeSecondFloor:Decodable {
    let fields: JSONInfo
    //let createdTime: String
}


struct JSONInfo: Decodable {
    let limit: String           //分級
    let genre: [String]         //類型
    let trailer: String         //預告片網址字串
    let name: String            //電影名稱
    let image: [imageUrl]       //照片網址Array
    let filmLenth: Int          //電影長度
    let releaseDate: String     //上映日期
    let imdb: Float             //IMDB Float格式
    
}

struct imageUrl: Decodable {
    let url: URL                //海報照URL網址
}

