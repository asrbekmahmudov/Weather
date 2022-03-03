
import Foundation

class WeatherForecast {
    var time: String? = ""
    var image: String? = ""
    var celsius: String? = ""
    
    init(time: String, image: String, celsius: String) {
        self.time = time
        self.image = image
        self.celsius = celsius
    }
}
