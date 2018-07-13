//
//  ViewController.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ViewController: UIViewController {

    var index = 0
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rightsOwnerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //exerciseOne()
        //exerciseTwo()
        //exerciseThree()
        
        let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        // This code will call the iTunes top 25 movies endpoint listed above
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let jsonArray = json["feed"]["entry"].arrayValue
                    
                    for movie in jsonArray {
                        let tempMovie = Movie(json: movie)
                        print("Movie name: \(tempMovie.name)")
                        self.movies.append(tempMovie)
                    }
                    
                    self.index = 0
                    self.configureMovie(movie: self.movies[self.index])
                    
                    //print(json)
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Updates the image view when passed a url string
    private func loadPoster(urlString: String) {
        posterImageView.af_setImage(withURL: URL(string: urlString)!)
    }
    
    @IBAction func viewOniTunesPressed(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: movies[index].link)!)
        
    }
  
    @IBAction func nextBtnTapped(_ sender: Any) {
        (index<24) ? (index = index+1) : (index = 0)
        configureMovie(movie: movies[index])
    }
    
    private func configureMovie(movie: Movie){
        self.movieTitleLabel.text = movie.name
        self.rightsOwnerLabel.text = movie.rightsOwner
        self.releaseDateLabel.text = movie.releaseDate
        self.priceLabel.text = String(describing: movie.price)
        self.loadPoster(urlString: movie.URLString)
    }
}

