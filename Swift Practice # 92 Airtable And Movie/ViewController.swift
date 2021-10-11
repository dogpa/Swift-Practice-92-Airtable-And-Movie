//
//  ViewController.swift
//  Swift Practice # 92 Airtable And Movie
//
//  Created by Dogpa's MBAir M1 on 2021/10/11.
//

import UIKit

class ViewController: UIViewController {

    var movieInfo : [AirtalbeSecondFloor]!  //定義變數movieInfo為上一頁傳來的AirtableJSON
    var index: Int!                         //定義變數為上一頁選擇的tableView的Row數
    
    @IBOutlet weak var movieBigPhotoImageView: UIImageView! //海報大圖
    
    @IBOutlet weak var limitImageView: UIImageView!         //分級圖
    
    @IBOutlet weak var movieDetailsLabel: UILabel!          //電影詳細資料
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(index!)
        
        //透過URLSession.shared.dataTask顯示movieBigPhotoImageView的海報大圖
        URLSession.shared.dataTask(with: movieInfo![index].fields.image[0].url) {
            data, response , error in
            if let data = data {
                DispatchQueue.main.async {
                    self.movieBigPhotoImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        
        //指派selectMovieIndex為選定電影的資料的前一層後續Lable找東西比較快
        let selectMovieIndex = movieInfo[index].fields
        
        //movieDetailsLabel顯示內容為selectMovieIndex裡面的資料
        movieDetailsLabel.text = "電影名稱：\(selectMovieIndex.name)\n上映日期：\(selectMovieIndex.releaseDate)\n類型：\(selectMovieIndex.genre)\nIMDB：\(String(selectMovieIndex.imdb))\n片長：\(String(selectMovieIndex.filmLenth))"
        var typeString = "\(selectMovieIndex.genre)"
        typeString.removeLast()
        typeString.removeFirst()
        movieDetailsLabel.text = "電影名稱：\(selectMovieIndex.name)\n上映日期：\(selectMovieIndex.releaseDate)\n類型：\(typeString)\nIMDB：\(String(selectMovieIndex.imdb))\n片長：\(String(selectMovieIndex.filmLenth)) 分"
        
        //limit為分級的字串
        let limit = movieInfo[index].fields.limit
        
        //透過switch來決定limitImageView分級照片
        switch limit {
        case "普遍":
            limitImageView.image = UIImage(named: "0")
        case "保護":
            limitImageView.image = UIImage(named: "6")
        case "輔12":
            limitImageView.image = UIImage(named: "12")
        case "輔15":
            limitImageView.image = UIImage(named: "15")
        case "限制":
            limitImageView.image = UIImage(named: "18")
         
        default:
            limitImageView.image = UIImage(named: "0")
        }
        
    }
    
    
    //IBSegueAcction傳資料 將選定電影的預告片網址字串傳給下一頁使用來顯示
    @IBSegueAction func seeTailer(_ coder: NSCoder) -> TailerViewController? {
        let controller = TailerViewController(coder: coder)
        controller?.movieURL = movieInfo[index].fields.trailer
        return controller
    }
    

}

