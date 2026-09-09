//
//  MyRegistrationsView.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import SwiftUI

struct MyRegistrationsView: View {

    let dependencies: AppDependencies

    @State private var viewModel: MyRegistrationsViewModel

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies

        _viewModel = State(
            initialValue: MyRegistrationsViewModel(
                repository: dependencies.registrationRepository,
                currentMember: dependencies.currentMember
            )
        )
    }

    var body: some View {
        NavigationStack {
            List {
                if viewModel.registrations.isEmpty {
                    ContentUnavailableView(
                        "No Registrations",
                        systemImage: "calendar.badge.exclamationmark",
                        description: Text(
                            "You have not registered for any games yet."
                        )
                    )
                } else {
                    ForEach(viewModel.registrations) { registration in
                        VStack(alignment: .leading, spacing: 6) {

                            Text("Weekly Game")
                                .font(.headline)

                            Text(
                                registration.registrationStatus == .confirmed
                                ? "Confirmed"
                                : "Waitlisted"
                            )
                            .foregroundStyle(
                                registration.registrationStatus == .confirmed
                                ? .green
                                : .orange
                            )
                        }
                    }
                }
            }
            .navigationTitle("My Registrations")
            .onAppear {
                viewModel.loadRegistrations()
            }
        }
    }
}
