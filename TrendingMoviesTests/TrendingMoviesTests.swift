//
//  TrendingMoviesTests.swift
//  TrendingMoviesTests
//
//  Created by Marina on 14/06/2022.
//

import XCTest
@testable import TrendingMovies

// testing APIRoute Enum that it returns correct API URL with given parameters
class APIRouteTests: XCTestCase {

    // testing Movies List API retrieved URL with first page
    func testAPIMoviesList() throws {
        let firstPage = 1
        let moviesListAPI = APIRoute.getMoviesList(page: firstPage)
        let url = moviesListAPI.asURL()
        let request = moviesListAPI.asRequest()
        XCTAssertEqual(url.absoluteString, "https://api.themoviedb.org/3/discover/movie")
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/discover/movie?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3&page=\(firstPage)")
    }

    // testing Movies List API retrieved URL with Invalid Page Number ( less than 1 )
    // it supposed to ignore the page parameter as the API designed to retrieve the first page by default
    func testAPIMoviesListWithInvalidPageNumber() throws {
        let notActuallyPageNumber = -1
        let moviesListAPI = APIRoute.getMoviesList(page: notActuallyPageNumber)
        let url = moviesListAPI.asURL()
        let request = moviesListAPI.asRequest()
        XCTAssertEqual(url.absoluteString, "https://api.themoviedb.org/3/discover/movie")
        let expectedRequestURL = "https://api.themoviedb.org/3/discover/movie?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3"
        XCTAssertEqual(request.url?.absoluteString, expectedRequestURL)
    }

    // testing MoviesList API retrieved URL with the first 5 pages
    func testAPIMoviesListIncrementingPage() throws {
        let numberOfPages = 5
        for pageNumber in 1...numberOfPages {
            let moviesListAPI = APIRoute.getMoviesList(page: pageNumber)
            let url = moviesListAPI.asURL()
            let request = moviesListAPI.asRequest()
            XCTAssertEqual(url.absoluteString, "https://api.themoviedb.org/3/discover/movie")
            var expectedRequestURL = "https://api.themoviedb.org/3/discover/movie?"
            expectedRequestURL += "api_key=c9856d0cb57c3f14bf75bdc6c063b8f3"
            expectedRequestURL += "&page=\(pageNumber)"
            XCTAssertEqual(request.url?.absoluteString, expectedRequestURL)
        }
    }

    // testing Movie Details API retrieved URL with given movieId
    func testAPIMovieDetails() throws {
        let movieId = 338953
        let movieDetailsAPI = APIRoute.getMovieDetails(id: movieId)
        let url = movieDetailsAPI.asURL()
        let request = movieDetailsAPI.asRequest()
        XCTAssertEqual(url.absoluteString, "https://api.themoviedb.org/3/movie/\(movieId)")
        let expectedRequestURL = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3"
        XCTAssertEqual(request.url?.absoluteString, expectedRequestURL)
    }
}
