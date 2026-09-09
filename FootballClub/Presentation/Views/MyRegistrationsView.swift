//
//  MyRegistrationsView.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import SwiftUI

enum RegistrationFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case confirmed = "Confirmed"
    case waitlist = "Waitlist"

    var id: String { rawValue }
}

struct MyRegistrationsView: View {

    let dependencies: AppDependencies

    @State private var viewModel: MyRegistrationsViewModel
    @State private var selectedFilter: RegistrationFilter = .all

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies

        _viewModel = State(
            initialValue: MyRegistrationsViewModel(
                registrationRepository:
                    dependencies.registrationRepository,
                gameRepository:
                    dependencies.gameRepository,
                currentMember:
                    dependencies.currentMember
            )
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    // Summary
                    HStack(spacing: 12) {

                        summaryCard(
                            title: "Upcoming",
                            value: confirmedCount
                        )

                        summaryCard(
                            title: "Waitlist",
                            value: waitlistCount
                        )
                    }

                    // Filter
                    Picker(
                        "Filter",
                        selection: $selectedFilter
                    ) {
                        ForEach(
                            RegistrationFilter.allCases
                        ) { filter in
                            Text(filter.rawValue)
                                .tag(filter)
                        }
                    }
                    .pickerStyle(.segmented)

                    // Registrations
                    if filteredItems.isEmpty {

                        ContentUnavailableView(
                            "No Registrations",
                            systemImage:
                                "calendar.badge.exclamationmark",
                            description: Text(
                                "No registrations match this filter."
                            )
                        )

                    } else {

                        ForEach(filteredItems) { item in

                            VStack(
                                alignment: .leading,
                                spacing: 10
                            ) {

                                HStack {

                                    Text(item.game.gameName)
                                        .font(.headline)

                                    Spacer()

                                    statusBadge(
                                        for:
                                            item.registration.registrationStatus
                                    )
                                }

                                Label(
                                    item.game.kickOffAt.formatted(
                                        date: .abbreviated,
                                        time: .shortened
                                    ),
                                    systemImage: "clock"
                                )

                                Label(
                                    item.game.venueName,
                                    systemImage:
                                        "mappin.and.ellipse"
                                )

                                Button(role: .destructive) {
                                    viewModel.cancelRegistration(
                                        for: item.game
                                    )
                                } label: {
                                    Text("Cancel Registration")
                                }
                                .buttonStyle(.borderless)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12
                                )
                                .fill(.background)
                                .shadow(
                                    color:
                                        .black.opacity(0.08),
                                    radius: 4
                                )
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("My Registration")
            .onAppear {
                viewModel.loadRegistrations()
            }
        }
    }

    private var filteredItems:
        [RegistrationDisplayItem] {

        switch selectedFilter {

        case .all:
            return viewModel.items

        case .confirmed:
            return viewModel.items.filter {
                $0.registration.registrationStatus
                    == .confirmed
            }

        case .waitlist:
            return viewModel.items.filter {
                $0.registration.registrationStatus
                    == .waitlisted
            }
        }
    }

    private var confirmedCount: Int {
        viewModel.items.filter {
            $0.registration.registrationStatus
                == .confirmed
        }.count
    }

    private var waitlistCount: Int {
        viewModel.items.filter {
            $0.registration.registrationStatus
                == .waitlisted
        }.count
    }

    private func summaryCard(
        title: String,
        value: Int
    ) -> some View {

        VStack(spacing: 6) {
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
                .shadow(
                    color: .black.opacity(0.06),
                    radius: 3
                )
        )
    }

    @ViewBuilder
    private func statusBadge(
        for status: WeeklyGameRegistrationStatus
    ) -> some View {

        switch status {

        case .confirmed:
            Text("Confirmed")
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.green.opacity(0.15))
                .foregroundStyle(.green)
                .clipShape(Capsule())

        case .waitlisted:
            Text("Waitlist")
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.orange.opacity(0.15))
                .foregroundStyle(.orange)
                .clipShape(Capsule())

        case .cancelled:
            EmptyView()
        }
    }
}

#Preview {
    MyRegistrationsView(
        dependencies: AppDependencies()
    )
}
