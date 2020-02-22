//
//  DataMovieManager.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class DataMovieManager {
    private let c = Constants()
    private var movies = [Movie]()
    private var endpoint = String()
    init(){
        endpoint = c.API_URL + "/" + c.LATEST_API_VERSION + "/movie/"
    }
    
    func getNowPlaying (
        query: MovieQuery,
        onSuccess: @escaping (Movie) -> Void,
        onFailure: @escaping () -> Void
    ) -> Void {
        let queryNowPlaying : String = endpoint + "now_playing?" + "api_key=" + query.api_key
        AF.request(queryNowPlaying).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let firstMovie = data["results"][0]
                        onSuccess(
                            Movie(
                                id: firstMovie["id"].intValue,
                                title: firstMovie["title"].stringValue,
                                poster_path: self.c.IMAGE_PRE_URL_W500 + firstMovie["poster_path"].stringValue,
                                backdrop_path: self.c.IMAGE_PRE_URL_W500 + firstMovie["backdrop_path"].stringValue
                            )
                        )
                    }
                    catch{
                        onFailure()
                    }
                }
            case .failure(let _):
                onFailure()
            }
        }
    }
    
    private func getPopular (
        query: MovieQuery,
        onSuccess: @escaping (Any) -> Void,
        onFailure: () -> Void
    ) -> String {
        let queryPopular : String = endpoint + "popular?" + "api_key=" + query.api_key
        return queryPopular
    }
    
    private func getTopRated(
        query: MovieQuery,
        onSuccess: @escaping (Any) -> Void,
        onFailure: () -> Void
    ) -> String {
        let queryTopRated : String = endpoint + "top_rated?" + "api_key=" + query.api_key
        return queryTopRated
    }
    
    private func getUpcoming(
        query: MovieQuery,
        onSuccess: @escaping (Any) -> Void,
        onFailure: () -> Void
    ) -> String {
        let queryUpcoming : String = endpoint + "upcoming?" + "api_key=" + query.api_key
        return queryUpcoming
    }
    
    private func getMovieDetail (
        query: MovieQuery.Detail,
        onSuccess: @escaping (Movie.Detail) -> Void,
        onFailure: @escaping () -> Void
    ) -> Void {
        let queryMovieDetail : String = endpoint + String(query.id) + "?" + "api_key=" + query.api_key
        AF.request(queryMovieDetail).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
//                        let firstMovie = data["results"][0]
                        onSuccess(
                            Movie.Detail(
                                id: data["id"].intValue,
                                title: data["title"].stringValue,
                                poster_path: self.c.IMAGE_PRE_URL_W500 + data["poster_path"].stringValue,
                                backdrop_path: self.c.IMAGE_PRE_URL_W500 + data["backdrop_path"].stringValue,
                                overview: data["overview"].stringValue,
                                genres: <#T##Array<String>#>,
                                production_companies: <#T##Array<ProductionCompanies>#>,
                                release_date: data["release_date"].stringValue,
                                runtime: data["runtime"].intValue,
                                status: data["status"].stringValue,
                                vote_average: data["vote_average"].floatValue)
                        )
                    }
                    catch{
                        onFailure()
                    }
                }
            case .failure(let _):
                onFailure()
            }
        }
    }
    
}
