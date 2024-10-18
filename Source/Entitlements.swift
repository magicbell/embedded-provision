import Foundation

public struct Entitlements: Decodable {
    public let keychainAccessGroups: [String]
    public let getTaskAllow: Bool
    public let apsEnvironment: APSEnvironment?
    public let teamId: String

    private enum CodingKeys: String, CodingKey {
        case keychainAccessGroups = "keychain-access-groups"
        case getTaskAllow = "get-task-allow"
        case apsEnvironment = "aps-environment"
        case teamId = "com.apple.developer.team-identifier"
    }
}
