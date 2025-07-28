//
//  MockData.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

struct MockData {
    static let courseTitle = "NURS5000"
    static let quizCellTitle = "Latest Quiz Submission Details"
    
    static var user = User(name: "Able", avaterUrl: "someUrl")
    
    static var degree = DegreeProgress(title: "Assoc. Arts in Business Admin", pointsCompleted: 72.5, pointsToal: 90)
    
    static var courses: [Course] =
    [
        Course(courseTitle: courseTitle, daysSinceLastEngament: 5, overDueTasks: 1, upcomingTasks: 4, unreadMessages: 1, announcements: 2, progress: 14, total: 32),
        Course(courseTitle: "NURS2503", daysSinceLastEngament: 1, overDueTasks: 1, upcomingTasks: 2, unreadMessages: 0, announcements: 0, progress: 14, total: 32)
    ]
    
    static var newsItems: [News] =
    [
        News(title: "Want a $25 gift card?", description: "Are you a Capella Mobile app user? Participant in an Interview..."),
        News(title: "Call for abstract is open.", description: "This sixth annual Practice Change Symposium occurs May...")
    ]
    
    static var courseMenuItems1 = [CourseMenuItem(title: "Cate Thompson", description: "Learner"), CourseMenuItem(title: "Competency Map"), CourseMenuItem(title: "Syllabus")]
    static var courseMenuItems2 = [CourseMenuItem(title: "Messages"), CourseMenuItem(title: "Annoucments"), CourseMenuItem(title: "Assessment and Status"), CourseMenuItem(title: quizCellTitle), CourseMenuItem(title: "Discussions"), CourseMenuItem(title: "Set Target Dates")]
    static var courseMenuAlert = CourseMenuAlert(title: "Target Dates Successfully Set", description: "Your target dates for this course have been set. You may edit these dates at any time throughout the course.", status: .positive)
    static var courseMenu: CourseMenu = CourseMenu(courseTitle: courseTitle, courseDescription: "Ethics is Healthcare for Nursing Professionals", alert: courseMenuAlert, menuItems:[courseMenuItems1, courseMenuItems2])
    
    static var quizSettings = QuizSettings(questions: 20, timeLimitMin: 10, allowedAttempts: 1)
    static var quizDetailsText = "Content Info: This content comes from the July 2023 version of COUN5832 Week 5 Quiz. This quiz does not include all question types.\n\nRead the following instructions before taking the quiz"
    static var quizDetails = QuizDetails(courseTitle: courseTitle, sectionTitle: "Section 02", quizTitle: "Week 3 Quiz: How Does Culture Shape Our Country?", quizAvailable: true, points: nil, totalPoints: 59, submitted: false, dueDate: nil, submissionType: "Quiz", quizSettings: quizSettings, quizDetails: quizDetailsText)
}

