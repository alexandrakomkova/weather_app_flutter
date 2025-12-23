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
import androidx.glance.text.TextStyle
import androidx.compose.runtime.Composable
import androidx.glance.state.GlanceStateDefinition
import dev.alexandrakomkova.weather_app.MainActivity
import androidx.glance.background

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
      val windDirection = data.getString("windDirection", "North")
      val temperatureUnits = data.getString("temperatureUnits", "C")
      val weatherConditions = data.getString("weatherConditions", "unknown")

      Box(contentAlignment = Alignment.Center,
          modifier = GlanceModifier.clickable(
              actionStartActivity<MainActivity>()
          )
      ){
          Column(
              modifier = GlanceModifier
                  .fillMaxSize()
                  .background(Color(0xFF6C63E7))
                  .padding(top = 14.dp)
                  .cornerRadius(15.dp),
              verticalAlignment = Alignment.CenterVertically,
              horizontalAlignment = Alignment.CenterHorizontally,
          ) {
               // weather info (temperature, wind speed, wind direction)
               Text(
                   text = "$temperature°$temperatureUnits $windSpeed km/h $windDirection",
                   style = TextStyle(
                     textAlign = TextAlign.Center,
                     fontSize = 18.sp
                   ),
                   maxLines = 1,
                   modifier = GlanceModifier
                       .fillMaxSize()
                       .padding(10.dp),
               )
                // weather image

               // weather conditions
               Text(
                   text = "$weatherConditions",
                   style = TextStyle(
                       textAlign = TextAlign.Center,
                       fontSize = 18.sp
                   ),
                   maxLines = 1,
                   modifier = GlanceModifier
                       .fillMaxSize()
                       .padding(10.dp),
               )
             }

      }
  }

}