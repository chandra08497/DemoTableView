//
//  UserModal.swift
//  DisplayData
//
//  Created by FutureTeach on 22/12/21.
//

import Foundation


// MARK: - RegistrationModelElement
struct RegistrationModelElement: Codable {
    let url, repositoryURL: String
    let labelsURL: String
    let commentsURL, eventsURL, htmlURL: String
    let id: Int
    let nodeID: String
    let number: Int
    let title: String
    let user: User
    let labels: [Label]
    let state: State
    let locked: Bool
    let assignee: User?
    let assignees: [User]
    let milestone: Milestone?
    let comments: Int
    let createdAt, updatedAt: Date
    let closedAt: JSONNull?
    let authorAssociation: AuthorAssociation
    let activeLockReason: JSONNull?
    let body: String
    let reactions: Reactions
    let timelineURL: String
    let performedViaGithubApp: JSONNull?
    let draft: Bool?
    let pullRequest: PullRequest?

    enum CodingKeys: String, CodingKey {
        case url
        case repositoryURL = "repository_url"
        case labelsURL = "labels_url"
        case commentsURL = "comments_url"
        case eventsURL = "events_url"
        case htmlURL = "html_url"
        case id
        case nodeID = "node_id"
        case number, title, user, labels, state, locked, assignee, assignees, milestone, comments
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case authorAssociation = "author_association"
        case activeLockReason = "active_lock_reason"
        case body, reactions
        case timelineURL = "timeline_url"
        case performedViaGithubApp = "performed_via_github_app"
        case draft
        case pullRequest = "pull_request"
    }
}

// MARK: - User
struct User: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: TypeEnum
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

enum TypeEnum: String, Codable {
    case user = "User"
}

enum AuthorAssociation: String, Codable {
    case contributor = "CONTRIBUTOR"
    case none = "NONE"
}

// MARK: - Label
struct Label: Codable {
    let id: Int
    let nodeID: String
    let url: String
    let name, color: String
    let labelDefault: Bool
    let labelDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case url, name, color
        case labelDefault = "default"
        case labelDescription = "description"
    }
}

// MARK: - Milestone
struct Milestone: Codable {
    let url, htmlURL, labelsURL: String
    let id: Int
    let nodeID: String
    let number: Int
    let title, milestoneDescription: String
    let creator: User
    let openIssues, closedIssues: Int
    let state: State
    let createdAt, updatedAt: Date
    let dueOn, closedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case url
        case htmlURL = "html_url"
        case labelsURL = "labels_url"
        case id
        case nodeID = "node_id"
        case number, title
        case milestoneDescription = "description"
        case creator
        case openIssues = "open_issues"
        case closedIssues = "closed_issues"
        case state
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dueOn = "due_on"
        case closedAt = "closed_at"
    }
}

enum State: String, Codable {
    case stateOpen = "open"
}

// MARK: - PullRequest
struct PullRequest: Codable {
    let url, htmlURL: String
    let diffURL: String
    let patchURL: String
    let mergedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case url
        case htmlURL = "html_url"
        case diffURL = "diff_url"
        case patchURL = "patch_url"
        case mergedAt = "merged_at"
    }
}

// MARK: - Reactions
struct Reactions: Codable {
    let url: String
    let totalCount, the1, reactions1, laugh: Int
    let hooray, confused, heart, rocket: Int
    let eyes: Int

    enum CodingKeys: String, CodingKey {
        case url
        case totalCount = "total_count"
        case the1 = "+1"
        case reactions1 = "-1"
        case laugh, hooray, confused, heart, rocket, eyes
    }
}

typealias RegistrationModel = [RegistrationModelElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
