//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by Юзер on 23.12.25.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetControl()
    }
}
