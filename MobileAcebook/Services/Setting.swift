//
//  Setting.swift
//  MobileAcebook
//
//  Created by Aisha Mohamed on 21/02/2024.
//

import Foundation
import SwiftUI

class Settings: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = false
}
