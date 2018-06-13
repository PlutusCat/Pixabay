//
//  MainModel.swift
//  Pixabay
//
//  Created by PlutusCat on 2018/6/11.
//  Copyright © 2018年 Pixabay. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainModel: NSObject {

    var hits : [MainHit]!
    var total : Int!
    var totalHits : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        hits = [MainHit]()
        let hitsArray = json["hits"].arrayValue
        for hitsJson in hitsArray{
            let value = MainHit(fromJson: hitsJson)
            hits.append(value)
        }
        total = json["total"].intValue
        totalHits = json["totalHits"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if hits != nil{
            var dictionaryElements = [[String:Any]]()
            for hitsElement in hits {
                dictionaryElements.append(hitsElement.toDictionary())
            }
            dictionary["hits"] = dictionaryElements
        }
        if total != nil{
            dictionary["total"] = total
        }
        if totalHits != nil{
            dictionary["totalHits"] = totalHits
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        hits = aDecoder.decodeObject(forKey: "hits") as? [MainHit]
        total = aDecoder.decodeObject(forKey: "total") as? Int
        totalHits = aDecoder.decodeObject(forKey: "totalHits") as? Int

    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if hits != nil{
            aCoder.encode(hits, forKey: "hits")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        if totalHits != nil{
            aCoder.encode(totalHits, forKey: "totalHits")
        }

    }


}
