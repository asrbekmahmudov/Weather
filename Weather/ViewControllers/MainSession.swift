
import Foundation
import UIKit

let data: Data? = """
{"coord":{"lon":69.2163,"lat":41.2646},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":0,"feels_like":36.81,"temp_min":37.4,"temp_max":45,"pressure":1021,"humidity":80},"visibility":16093,"wind":{"speed":3.04,"deg":79},"clouds":{"all":90},"dt":1585068301,"sys":{"type":1,"id":3510,"country":"UZ","sunrise":1585048554,"sunset":1585092969},"timezone":-14400,"id":5206379,"name":"Tashkent","cod":200}
""".data(using: .utf8)

extension MainViewController {
    
   func decodeJSONForecast(JSONData: Data, city: String) {
       
       let response = try! JSONDecoder().decode(WeatherData.self, from: JSONData)
       var day = ""
       var currentTemp = ""
       var currentImage = ""
       var started = false
       for i in response.list {
           for j in i.weather {
               if let time = getDateText(date: i.dt_txt, main: i, weather: j, city: city) {
                   guard time == "now" || started else {
                       continue
                   }
                   started = true
                   
                   daily.append(WeatherForecast(time: time, image: "https://openweathermap.org/img/wn/\(j.icon)@2x.png", celsius: String(Int(round(i.main.temp))) + "°"))
                   
                   DispatchQueue.main.async { [self] in
                       dailyForecastCollectionView.reloadData()
                   }
                   
                   if currentTemp.isEmpty {
                       currentTemp = "\(Int(round(i.main.temp)))°"
                       currentImage = "\(j.icon)"
                       weekly.append(WeatherForecast(time: "today", image: "https://openweathermap.org/img/wn/\(currentImage)@2x.png", celsius: currentTemp))
                       
                       DispatchQueue.main.async { [self] in
                           weeklyForecastCollectionView.reloadData()
                       }
                   }
               } else if nextDays(date: i.dt_txt).isNextDays && nextDays(date: i.dt_txt).time == "12" {
                   day = nextDays(date: i.dt_txt).day
                   currentTemp = "\(Int(round(i.main.temp)))°"
                   currentImage = "\(j.icon)"
                   
                   weekly.append(WeatherForecast(time: day, image: "https://openweathermap.org/img/wn/\(currentImage)@2x.png", celsius: currentTemp))
                   
                   DispatchQueue.main.async { [self] in
                       weeklyForecastCollectionView.reloadData()
                   }
               }
               if started {
                   day = nextDays(date: i.dt_txt).day
                   fully.append(WeatherForecast(time: day, image: "https://openweathermap.org/img/wn/\(j.icon)@2x.png", celsius: String(Int(round(i.main.temp))) + "°"))
                   
                   DispatchQueue.main.async { [self] in
                       fullyForecastCollectionView.reloadData()
                   }
               }
           }
       }
   }
   
   func pullJSONData(url: URL?, city: String) {
       let task = URLSession.shared.dataTask(with: url!) { [self] data, response, error in
           if let error = error {
               print("Error: \(error.localizedDescription)")
           }
           
           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               print("Error: HTTP Response Code Error")
               return
           }
           
           guard let data = data else {
               print("Error: No Response")
               return
           }
           
           decodeJSONForecast(JSONData: data, city: city)
       }
       task.resume()
   }
    
}
