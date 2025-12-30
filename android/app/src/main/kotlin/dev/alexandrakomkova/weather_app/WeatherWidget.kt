package dev.alexandrakomkova.weather_app

import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import androidx.glance.currentState
import androidx.compose.ui.graphics.Color
import android.content.Context
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.GlanceTheme
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.action.actionStartActivity
import androidx.glance.action.clickable
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.Box
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.FontWeight
import androidx.glance.text.TextStyle
import androidx.compose.runtime.Composable
import androidx.glance.state.GlanceStateDefinition
import dev.alexandrakomkova.weather_app.MainActivity
import androidx.glance.background
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.layout.ContentScale
import androidx.glance.layout.Spacer
import androidx.glance.layout.height

class WeatherWidget : GlanceAppWidget() {
    // need for updating

    override val stateDefinition: GlanceStateDefinition<*>
        get() = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val appWidgetId = GlanceAppWidgetManager(context).getAppWidgetId(id)
        provideContent {
            GlanceContent(context, currentState(), appWidgetId)
        }
    }

    @Composable
    private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState, appWidgetId: Int) {
        val data = currentState.preferences
        val temperature = data.getInt("temperature", 0)
        val windSpeed = data.getInt("windSpeed", 0)
        val windDirection = data.getString("windDirection", "North")?.filter { it.isUpperCase() }
        val weatherConditions = data.getString("weatherConditions", "unknown")
        val location = data.getString("location", "unknown")

        val weatherIconResId = getIconForCondition(weatherConditions)

        Box(contentAlignment = Alignment.Center,
            modifier = GlanceModifier.clickable(
                actionStartActivity<MainActivity>()
            )
        ) {
            Column(
                modifier = GlanceModifier
                    .fillMaxSize()
                    .background(Color(0xFF5d7c95))
                    .padding(15.dp)
                    .cornerRadius(15.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalAlignment = Alignment.Start,
            ) {
                Text(
                    text = "$location",
                    style = TextStyle(
                        textAlign = TextAlign.Start,
                        fontSize = 14.sp,
                        color = GlanceTheme.colors.onSurface,
                    ),
                    maxLines = 2,
                )
                Spacer(modifier = GlanceModifier.height(5.dp))
                // weather info (temperature, wind speed, wind direction)
                Text(
                    text = "$temperature°",
                    style = TextStyle(
                        textAlign = TextAlign.Start,
                        fontSize = 28.sp,
                        fontWeight = FontWeight.Bold,
                        color = GlanceTheme.colors.onSurface
                    ),
                    maxLines = 1,
                    modifier = GlanceModifier
                        .padding(bottom = 5.dp)
                )
                Text(
                    text = "$windSpeed km/h $windDirection",
                    style = TextStyle(
                        textAlign = TextAlign.Start,
                        fontSize = 18.sp,
                        color = GlanceTheme.colors.onSurface
                    ),
                    maxLines = 1,
                )
                // weather image

                Spacer(modifier = GlanceModifier.height(5.dp))
                // weather conditions
                Text(
                    text = "$weatherConditions",
                    style = TextStyle(
                        textAlign = TextAlign.Start,
                        fontSize = 18.sp,
                        color = GlanceTheme.colors.onSurface,
                    ),
                    maxLines = 1,
                )
                Image(
                    provider = ImageProvider(
                        resId = weatherIconResId
                    ),
                    contentDescription = null,
                    contentScale = ContentScale.Fit,
                    modifier = GlanceModifier
                        .height(80.dp)
                )
            }
        }
    }
    private fun getIconForCondition(weatherCondition: String?): Int {
        return when (weatherCondition) {
            "clear" -> R.drawable.clear_android
            "cloudy" -> R.drawable.cloudy_android
            "drizzle" -> R.drawable.drizzle_android
            "freezing drizzle" -> R.drawable.freezing_drizzle_android
            "mainly clear" -> R.drawable.mainly_clear_android
            "rain showers" -> R.drawable.rain_showers_android
            "rainy" -> R.drawable.rainy_android
            "snowy" -> R.drawable.snowy_android
            "thunderstorm" -> R.drawable.thunderstorm_android
            else -> R.drawable.cloudy_android
        }
    }
}