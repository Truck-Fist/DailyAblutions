//
//  NotificationScreen.swift
//  DailyAblutions
//
//  Created by Derek Noble on 4/13/20.
//  Copyright © 2020 Noble Software. All rights reserved.
//

import SwiftUI

struct NotificationScreen: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                Spacer()
                Text("All Reminders")
                    .padding(.horizontal)
                Spacer()
            }
            .padding()
            HStack {
                Text("Here's what you missed.")
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            List(notificationSampleData) { sample in
                ScrollView {
                    Text(sample.text)
                }
            }
        }
    }
}

struct NotificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationScreen()
    }
}

