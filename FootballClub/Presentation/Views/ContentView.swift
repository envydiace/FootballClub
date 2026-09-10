//
//  ContentView.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import SwiftUI

struct ContentView: View {

    let dependencies: AppDependencies

    @State private var selectedRole: ClubMemberRole = .member

    var body: some View {

        VStack(spacing: 0) {

            // Testing role switcher
            HStack {

                Text(
                    selectedRole == .member
                    ? "Testing as Member"
                    : "Testing as Organiser"
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()

                Button {
                    switchUser()
                } label: {
                    Label(
                        selectedRole == .member
                        ? "Member"
                        : "Organiser",
                        systemImage: "person.crop.circle"
                    )
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
            .padding(.horizontal)
            .padding(.vertical, 6)

            Divider()

            TabView {

                UpcomingGamesView(
                    dependencies: dependencies
                )
                .tabItem {
                    Label(
                        "Games",
                        systemImage: "sportscourt"
                    )
                }

                MyRegistrationsView(
                    dependencies: dependencies
                )
                .tabItem {
                    Label(
                        "My Registrations",
                        systemImage: "list.bullet.clipboard"
                    )
                }
            }

            // Recreate child Views/ViewModels when user changes
            .id(dependencies.currentMember.id)
        }
    }

    private func switchUser() {

        if selectedRole == .member {

            dependencies.switchToOrganiser()
            selectedRole = .organiser

        } else {

            dependencies.switchToMember()
            selectedRole = .member
        }
    }
}

#Preview {
    ContentView(
        dependencies: AppDependencies()
    )
}
