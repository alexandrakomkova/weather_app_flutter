package dev.alexandrakomkova.weather_app

import HomeWidgetGlanceWidgetReceiver
import dev.alexandrakomkova.weather_app.WeatherWidget


class WeatherWidgetReceiver : HomeWidgetGlanceWidgetReceiver<WeatherWidget>() {
    override val glanceAppWidget = WeatherWidget()
}
