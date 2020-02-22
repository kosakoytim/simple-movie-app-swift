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
    
    func getPopular (
        query: MovieQuery,
        onSuccess: @escaping ([Movie]) -> Void,
        onFailure: @escaping () -> Void
    ) -> Void {
        let queryPopular : String = endpoint + "popular?" + "api_key=" + query.api_key
        AF.request(queryPopular).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let results = data["results"]
                        var movies = [Movie]()
                        for (index, _) in results.enumerated() {
                            movies.append(
                                Movie(
                                    id: results[index]["id"].intValue,
                                    title: results[index]["title"].stringValue,
                                    poster_path: self.c.IMAGE_PRE_URL_W500 + results[index]["poster_path"].stringValue,
                                    backdrop_path: self.c.IMAGE_PRE_URL_W500 + results[index]["poster_path"].stringValue
                                )
                            )
                        }
                        onSuccess(movies)
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
    
    func getTopRated(
        query: MovieQuery,
        onSuccess: @escaping ([Movie]) -> Void,
        onFailure: @escaping () -> Void
    ) -> Void {
        let queryTopRated : String = endpoint + "top_rated?" + "api_key=" + query.api_key
        AF.request(queryTopRated).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let results = data["results"]
                        var movies = [Movie]()
                        for (index, _) in results.enumerated() {
                            movies.append(
                                Movie(
                                    id: results[index]["id"].intValue,
                                    title: results[index]["title"].stringValue,
                                    poster_path: self.c.IMAGE_PRE_URL_W500 + results[index]["poster_path"].stringValue,
                                    backdrop_path: self.c.IMAGE_PRE_URL_W500 + results[index]["poster_path"].stringValue
                                )
                            )
                        }
                        onSuccess(movies)
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
    
    func getUpcoming(
        query: MovieQuery,
        onSuccess: @escaping ([Movie]) -> Void,
        onFailure: @escaping () -> Void
    ) -> Void {
        let queryUpcoming : String = endpoint + "upcoming?" + "api_key=" + query.api_key
        AF.request(queryUpcoming).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let results = data["results"]
                        var movies = [Movie]()
                        for (index, _) in results.enumerated() {
                            movies.append(
                                Movie(
                                    id: results[index]["id"].intValue,
                                    title: results[index]["title"].stringValue,
                                    poster_path: self.c.IMAGE_PRE_URL_W500 + results[index]["poster_path"].stringValue,
                                    backdrop_path: self.c.IMAGE_PRE_URL_W500 + results[index]["poster_path"].stringValue
                                )
                            )
                        }
                        onSuccess(movies)
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
    
    func getMovieDetail (
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
                        var genres = [String]()
                        var production_companies = [ProductionCompanies]()
                        for (index, _) in data["genres"].enumerated() {
                            genres.append(data["genres"][index]["name"].stringValue)
                        }
                        for (index, _) in data["production_companies"].enumerated() {
                            production_companies.append(
                                ProductionCompanies(
                                    name: data["production_companies"][index]["name"].stringValue,
                                    id: data["production_companies"][index]["id"].intValue,
                                    logo_path: self.c.IMAGE_PRE_URL_W200 + data["production_companies"][index]["logo_path"].stringValue
                                )
                            )
                        }

                        onSuccess(
                            Movie.Detail(
                                id: data["id"].intValue,
                                title: data["title"].stringValue,
                                poster_path: self.c.IMAGE_PRE_URL_W500 + data["poster_path"].stringValue,
                                backdrop_path: self.c.IMAGE_PRE_URL_W500 + data["backdrop_path"].stringValue,
                                overview: data["overview"].stringValue,
                                genres: genres,
                                production_companies: production_companies,
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
