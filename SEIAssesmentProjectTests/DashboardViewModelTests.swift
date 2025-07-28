//
//  DashboardViewModelTests.swift
//  SEIAssesmentProjectTests
//
//  Created by Roger Jones Work  on 7/28/25.
//

import XCTest

final class DashboardViewModelTests: XCTestCase {
    var mockUserService: MockUserService!
    var mockNavHandler: NavigationHandler!
    var viewModel: DashboardViewModel!

    override func setUp() {
        super.setUp()
        mockUserService = MockUserService()
        mockNavHandler = NavigationHandler()
    }

    @MainActor func testLoadUser_success_setsUserAndAvatar() async  {
        // Arrange
        viewModel = DashboardViewModel(navigationHandler: mockNavHandler, userService: mockUserService)

        // Act
        await viewModel.loadUser()

        // Assert
        XCTAssertEqual(viewModel.currentUserName, MockData.user.name)
        if case .success(_) = viewModel.status {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected success status")
        }
    }

    func testLoadUser_failure_setsErrorStatus() async {
        // Arrange
        viewModel = await DashboardViewModel(navigationHandler: mockNavHandler, userService: mockUserService)
        mockUserService.shouldThrow = true

        // Act
        await viewModel.loadUser()

        // Assert
        if case .failure(let error) = await viewModel.status {
            XCTAssertFalse(error.isEmpty)
        } else {
            XCTFail("Expected failure status")
        }
    }

    @MainActor func testUserId_returnsValueWhenUserSet() {
        // Arrange
        viewModel = DashboardViewModel(navigationHandler: mockNavHandler, userService: mockUserService)
        let user = User(name: "Test User", avaterUrl: "")
        mockUserService.userToReturn = user

        Task {
            await viewModel.loadUser()
            XCTAssertEqual(viewModel.userId, user.id.uuidString)
        }
    }
}
