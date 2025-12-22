import HomeWidgetGlanceWidgetReceiver
import dev.alexandrakomkova.weather_app.weather_app_widget.WeatherWidget

class WeatherWidgetReceiver : HomeWidgetGlanceWidgetReceiver<WeatherWidget>() {
    override val glanceAppWidget = WeatherWidget()
}