
import Foundation

struct Weather: Codable {
    var temp: Double?
    var humidity: Double?
}
 
struct WeatherMain: Codable{
    let main: Weather
}

struct WeatherData: Decodable {
    let list: [List]
}
 
struct Main: Decodable {
    let temp: Float
    let temp_max: Float
    let temp_min: Float
    let feels_like: Float
    let humidity: Float
}
 
struct Weather2: Decodable {
    let main: String
    let description: String
    let icon: String
}
 
struct List: Decodable {
    let main: Main
    let weather: [Weather2]
    let wind: Wind
    let dt_txt: String
}

struct Wind: Decodable {
    let speed: Float
}
