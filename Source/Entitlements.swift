import Foundation

public struct Entitlements: Decodable {
    let keychainAccessGroups: [String]
    let getTaskAllow: Bool
    let apsEnvironment: APSEnvironment?
    let teamId: String

    private enum CodingKeys: String, CodingKey {
        case keychainAccessGroups = "keychain-access-groups"
        case getTaskAllow = "get-task-allow"
        case apsEnvironment = "aps-environment"
        case teamId = "com.apple.developer.team-identifier"
    }
}
