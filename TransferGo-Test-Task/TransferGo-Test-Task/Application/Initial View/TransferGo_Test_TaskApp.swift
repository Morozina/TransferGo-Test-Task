//
//  TransferGo_Test_TaskApp.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 15/01/2024.
//

import SwiftUI

@main
struct TransferGo_Test_TaskApp: App {
    var body: some Scene {
        WindowGroup {
            ConvertorView(viewModel: ConvertorViewModel())
        }
    }
}
