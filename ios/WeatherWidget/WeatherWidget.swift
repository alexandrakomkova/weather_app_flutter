//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Юзер on 23.12.25.
//

import WidgetKit
import SwiftUI

private let prefsKeyTemperature = "temperature"
private let prefsKeyTemperatureUnits = "temperatureUnits"
private let prefsKeyWindSpeed = "windSpeed"
private let prefsKeyWindDirection = "windDirection"
private let prefsKeyWeatherConditions = "weatherConditions"
private let widgetGroupId = "group.weather_app_flutter"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
            let prefs = UserDefaults(suiteName: widgetGroupId)
            let temperature = prefs?.integer(forKey: prefsKeyTemperature) ?? 0
        let windSpeed = prefs?.integer(forKey: prefsKeyWindSpeed) ?? 0
        let windDirection = prefs?.string(forKey: prefsKeyWindDirection) ?? "N"
        let weatherConditions = prefs?.string(forKey: prefsKeyWeatherConditions) ?? "Clear"
            return WeatherEntry(
                date: Date(),
                temperature: temperature,
                windSpeed: windSpeed,
                windDirection: windDirection,
                weatherConditions: weatherConditions,
            )
        }
    
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
            let prefs = UserDefaults(suiteName: widgetGroupId)
        let temperature = prefs?.integer(forKey: prefsKeyTemperature) ?? 0
    let windSpeed = prefs?.integer(forKey: prefsKeyWindSpeed) ?? 0
    let windDirection = prefs?.string(forKey: prefsKeyWindDirection) ?? "N"
    let weatherConditions = prefs?.string(forKey: prefsKeyWeatherConditions) ?? "Clear"
            
        let entry = WeatherEntry(
            date: .now,
            temperature: temperature,
            windSpeed: windSpeed,
            windDirection: windDirection,
            weatherConditions: weatherConditions,
        )
            completion(entry)
        }

//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, emoji: "😀")
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
            getSnapshot(in: context) { (entry) in
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
        }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let temperature: Int
    let windSpeed: Int
    let windDirection: String
    let weatherConditions: String
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("\(entry.temperature)°")
            Text("\(entry.windSpeed) km/h \(entry.windDirection)")
            Text(entry.weatherConditions)
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeatherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WeatherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Weather Widget")
        .description("Shows weather conditions, temperature, wind speed and direction.")
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
    WeatherEntry(
        date: .now,
        temperature: 17,
        windSpeed: 5,
        windDirection: "NW",
        weatherConditions: "Sunny"
    )
}
