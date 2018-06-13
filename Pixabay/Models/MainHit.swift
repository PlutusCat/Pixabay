//
//	Hit.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MainHit : NSObject, NSCoding{

	var comments : Int!
	var downloads : Int!
	var favorites : Int!
	var id : Int!
	var imageHeight : Int!
	var imageSize : Int!
	var imageWidth : Int!
	var largeImageURL : String!
	var likes : Int!
	var pageURL : String!
	var previewHeight : Int!
	var previewURL : String!
	var previewWidth : Int!
	var tags : String!
	var type : String!
	var user : String!
	var userImageURL : String!
	var userId : Int!
	var views : Int!
	var webformatHeight : Int!
	var webformatURL : String!
	var webformatWidth : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		comments = json["comments"].intValue
		downloads = json["downloads"].intValue
		favorites = json["favorites"].intValue
		id = json["id"].intValue
		imageHeight = json["imageHeight"].intValue
		imageSize = json["imageSize"].intValue
		imageWidth = json["imageWidth"].intValue
		largeImageURL = json["largeImageURL"].stringValue
		likes = json["likes"].intValue
		pageURL = json["pageURL"].stringValue
		previewHeight = json["previewHeight"].intValue
		previewURL = json["previewURL"].stringValue
		previewWidth = json["previewWidth"].intValue
		tags = json["tags"].stringValue
		type = json["type"].stringValue
		user = json["user"].stringValue
		userImageURL = json["userImageURL"].stringValue
		userId = json["user_id"].intValue
		views = json["views"].intValue
		webformatHeight = json["webformatHeight"].intValue
		webformatURL = json["webformatURL"].stringValue
		webformatWidth = json["webformatWidth"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if comments != nil{
			dictionary["comments"] = comments
		}
		if downloads != nil{
			dictionary["downloads"] = downloads
		}
		if favorites != nil{
			dictionary["favorites"] = favorites
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imageHeight != nil{
			dictionary["imageHeight"] = imageHeight
		}
		if imageSize != nil{
			dictionary["imageSize"] = imageSize
		}
		if imageWidth != nil{
			dictionary["imageWidth"] = imageWidth
		}
		if largeImageURL != nil{
			dictionary["largeImageURL"] = largeImageURL
		}
		if likes != nil{
			dictionary["likes"] = likes
		}
		if pageURL != nil{
			dictionary["pageURL"] = pageURL
		}
		if previewHeight != nil{
			dictionary["previewHeight"] = previewHeight
		}
		if previewURL != nil{
			dictionary["previewURL"] = previewURL
		}
		if previewWidth != nil{
			dictionary["previewWidth"] = previewWidth
		}
		if tags != nil{
			dictionary["tags"] = tags
		}
		if type != nil{
			dictionary["type"] = type
		}
		if user != nil{
			dictionary["user"] = user
		}
		if userImageURL != nil{
			dictionary["userImageURL"] = userImageURL
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if views != nil{
			dictionary["views"] = views
		}
		if webformatHeight != nil{
			dictionary["webformatHeight"] = webformatHeight
		}
		if webformatURL != nil{
			dictionary["webformatURL"] = webformatURL
		}
		if webformatWidth != nil{
			dictionary["webformatWidth"] = webformatWidth
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         comments = aDecoder.decodeObject(forKey: "comments") as? Int
         downloads = aDecoder.decodeObject(forKey: "downloads") as? Int
         favorites = aDecoder.decodeObject(forKey: "favorites") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imageHeight = aDecoder.decodeObject(forKey: "imageHeight") as? Int
         imageSize = aDecoder.decodeObject(forKey: "imageSize") as? Int
         imageWidth = aDecoder.decodeObject(forKey: "imageWidth") as? Int
         largeImageURL = aDecoder.decodeObject(forKey: "largeImageURL") as? String
         likes = aDecoder.decodeObject(forKey: "likes") as? Int
         pageURL = aDecoder.decodeObject(forKey: "pageURL") as? String
         previewHeight = aDecoder.decodeObject(forKey: "previewHeight") as? Int
         previewURL = aDecoder.decodeObject(forKey: "previewURL") as? String
         previewWidth = aDecoder.decodeObject(forKey: "previewWidth") as? Int
         tags = aDecoder.decodeObject(forKey: "tags") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         user = aDecoder.decodeObject(forKey: "user") as? String
         userImageURL = aDecoder.decodeObject(forKey: "userImageURL") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         views = aDecoder.decodeObject(forKey: "views") as? Int
         webformatHeight = aDecoder.decodeObject(forKey: "webformatHeight") as? Int
         webformatURL = aDecoder.decodeObject(forKey: "webformatURL") as? String
         webformatWidth = aDecoder.decodeObject(forKey: "webformatWidth") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if comments != nil{
			aCoder.encode(comments, forKey: "comments")
		}
		if downloads != nil{
			aCoder.encode(downloads, forKey: "downloads")
		}
		if favorites != nil{
			aCoder.encode(favorites, forKey: "favorites")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if imageHeight != nil{
			aCoder.encode(imageHeight, forKey: "imageHeight")
		}
		if imageSize != nil{
			aCoder.encode(imageSize, forKey: "imageSize")
		}
		if imageWidth != nil{
			aCoder.encode(imageWidth, forKey: "imageWidth")
		}
		if largeImageURL != nil{
			aCoder.encode(largeImageURL, forKey: "largeImageURL")
		}
		if likes != nil{
			aCoder.encode(likes, forKey: "likes")
		}
		if pageURL != nil{
			aCoder.encode(pageURL, forKey: "pageURL")
		}
		if previewHeight != nil{
			aCoder.encode(previewHeight, forKey: "previewHeight")
		}
		if previewURL != nil{
			aCoder.encode(previewURL, forKey: "previewURL")
		}
		if previewWidth != nil{
			aCoder.encode(previewWidth, forKey: "previewWidth")
		}
		if tags != nil{
			aCoder.encode(tags, forKey: "tags")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}
		if userImageURL != nil{
			aCoder.encode(userImageURL, forKey: "userImageURL")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if views != nil{
			aCoder.encode(views, forKey: "views")
		}
		if webformatHeight != nil{
			aCoder.encode(webformatHeight, forKey: "webformatHeight")
		}
		if webformatURL != nil{
			aCoder.encode(webformatURL, forKey: "webformatURL")
		}
		if webformatWidth != nil{
			aCoder.encode(webformatWidth, forKey: "webformatWidth")
		}

	}

}
