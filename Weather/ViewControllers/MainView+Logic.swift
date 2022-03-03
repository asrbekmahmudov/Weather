
import Foundation

extension MainViewController {
    func formatCity(city: String) -> String {
        return String(city.map { s in
            return s == " " ? "&" : s
        })
    }
    
    func nextDays(date: String) -> (isNextDays: Bool, day: String, time: String) {
        let dateArray = Array(date)
        var currentDate = ""
        var currentDay = ""
        var currentHour = ""
        currentHour.append(dateArray[11])
        currentHour.append(dateArray[12])
        for index in 5..<10 {
            currentDay.append(dateArray[index])
        }
        
        for item in date {
            if item != " " {
                currentDate.append(item)
            } else {
                break
            }
        }
        
        return (currentDate != formatter().dateString, currentDay, currentHour)
    }
    
    func formatter() -> (dateString: String, dateStringHour: String) {
        let df = DateFormatter()
        df.dateFormat = "HH"
        let dateStringHour = df.string(from: Date())
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: Date())
        return (dateString, dateStringHour)
    }
    
    func formatDateHourly(date_text: String, city: String) -> (isNow: Bool, isToday: Bool, time: String) {
        return formatHour(date: date_text, dateString: formatter().dateString, dateStringHour: formatter().dateStringHour)
    }
    
    func formatHour(date: String, dateString: String, dateStringHour: String) -> (isNow: Bool, isToday: Bool, time: String) {
        let dateArray = Array(date)
        var currentDate = ""
        var currentHour = ""
        currentHour.append(dateArray[11])
        currentHour.append(dateArray[12])
        
        for item in date {
            if item != " " {
                currentDate.append(item)
            } else {
                break
            }
        }
        
        return (dateString == currentDate && Int(dateStringHour)! >= Int(currentHour)! && Int(dateStringHour)! <= (Int(currentHour)! + 3), dateString == currentDate && Int(dateStringHour)! != Int(currentHour)!, currentHour)
    }
    
    func getDateText(date: String, main: List, weather: Weather2, city: String) -> String? {
        if formatDateHourly(date_text: date, city: city).isToday {
            if formatDateHourly(date_text: date, city: city).isNow {
                DispatchQueue.main.async { [self] in
                    lblPlace.text = city
                    lbltemp.text = "\(Int(round(main.main.temp)))°C"
                    lblmain.text = weather.main.description
                    lblhumiditywind.text = "H:\(Int(round(main.main.humidity)))%  W:\(Int(round(main.wind.speed)))m/s"
                }
                return "now"
            } else {
                return formatDateHourly(date_text: date, city: city).time
            }
        }
        return nil
    }
}
