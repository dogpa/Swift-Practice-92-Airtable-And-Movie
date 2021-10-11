//
//  MovieTableViewController.swift
//  Swift Practice # 92 Airtable And Movie
//
//  Created by Dogpa's MBAir M1 on 2021/10/11.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    //自定義變數movieDetails為AirtalbeSecondFloor的ARRAY格式
    var movieDetails = [AirtalbeSecondFloor]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getAirtableData()       //執行抓JSON Function

    }
    
    //自定義Function抓Airtable JSON
    func getAirtableData () {
        

        //指派urlOfAirtableMovie為Airtable API網址
        //urlStr為urlOfAirtableMovie解碼後的字串
        //getDetailsUrl為URL格式傳入urlStr使用
        let urlOfAirtableMovie = "https://api.airtable.com/v0/app8mwjZQZBSaI2DN/SwiftPractice92?api_key="
        if let urlStr = urlOfAirtableMovie.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let getDetailsUrl = URL(string: urlStr) {
                
                //透過URLSession.shared.dataTask執行網路抓圖
                URLSession.shared.dataTask(with: getDetailsUrl) { data, response, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        
                        do {
                            
                            //將AirtableSearchResult存入抓到的資料存入到  self.movieDetails
                            //並重新更新tableVew
                            let AirtableSearchResult = try decoder.decode(AirtableJson.self, from: data)
                            print(type(of: AirtableSearchResult))
                            self.movieDetails = AirtableSearchResult.records
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            print(self.movieDetails.count)
                            
                        }catch{
                            print(error)
                            print("失敗")
                        }
                    }
                }.resume()
            }
        }
    }
    
    
    

    // MARK: - Table view data source
    
    //回傳一個Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    //顯示row總數 依照movieDetails抓出的資料總數決定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieDetails.count
    }

    //顯示海報照片與電影名稱內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.movieNameLabel.text = movieDetails[indexPath.row].fields.name
        
        URLSession.shared.dataTask(with: movieDetails[indexPath.row].fields.image[0].url) { data, response , error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.moviePhotoImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
        return cell
    }
    
    //選到指定row跳至下一頁
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "passSelectMovieDetails", sender: nil)
    }
    
    //透過prepare依照路徑"passSelectMovieDetails"傳資料過去給第二頁
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passSelectMovieDetails" {
            if let movieDetailsPage = segue.destination as? ViewController {
                let selectMovieIndex = self.tableView.indexPathForSelectedRow
                
                if let selectRow = selectMovieIndex?.row {
                    movieDetailsPage.movieInfo = movieDetails
                    movieDetailsPage.index = selectRow
                }
            }
        }
    }



}
