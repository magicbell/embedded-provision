import ASN1Decoder
import Foundation

// import Security

// Inspired by Expo
// https://github.com/expo/expo/blob/c158ef23812c2995f326c51565b189e234948885/packages/expo-application/ios/EXApplication/EXProvisioningProfile.m#L28 (MIT License)
// and https://github.com/doneservices/ApsEnvironment/blob/221afddd19be77f9a5a943be637a8cc7e9dfeb94/Sources/ApsEnvironment/ApsEnvironment.swift#L4 (MIT License)

public enum EmbeddedProvisionError: Error {
    case decodingError
}

public struct EmbeddedProvision: Decodable {
    public let name: String
    public let appIDName: String
    public let platform: [String]
    public let isXcodeManaged: Bool?
    public let creationDate: Date
    public let expirationDate: Date
    public let entitlements: Entitlements

    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case appIDName = "AppIDName"
        case platform = "Platform"
        case isXcodeManaged = "IsXcodeManaged"
        case creationDate = "CreationDate"
        case expirationDate = "ExpirationDate"
        case entitlements = "Entitlements"
    }
}

extension EmbeddedProvision {
    public static func guessEmbeddedProvisionProfileURL() -> URL? {
        // [TN3125 - Profile Location](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#Profile-location)
        let iOSURL = Bundle.main.url(forResource: "embedded", withExtension: "mobileprovision")
        let macOSURL = Bundle.main.url(
            forResource: "embedded", withExtension: "provisionprofile", subdirectory: "Contents")
        return iOSURL ?? macOSURL
    }

    public static func load() throws -> EmbeddedProvision? {
        guard let url = guessEmbeddedProvisionProfileURL() else { return nil }
        return try load(from: url)
    }

    public static func load(from profileURL: URL) throws -> EmbeddedProvision {

        guard let data = try? Data(contentsOf: profileURL) else {
            throw EmbeddedProvisionError.decodingError
        }

        guard let pkcs7 = try? PKCS7(data: data) else {
            throw EmbeddedProvisionError.decodingError
        }

        let mainBlock = pkcs7.mainBlock

        guard let block = mainBlock.findOid(.pkcs7data) else {
            throw EmbeddedProvisionError.decodingError
        }

        guard let octetStringBlock = block.parent?.sub(1)?.sub(0) else {
            throw EmbeddedProvisionError.decodingError
        }

        guard let xmlString = octetStringBlock.value as? String else {
            throw EmbeddedProvisionError.decodingError
        }

        guard let plistData = xmlString.data(using: .utf8) else {
            throw EmbeddedProvisionError.decodingError
        }

        let mobileProvision = try PropertyListDecoder().decode(
            EmbeddedProvision.self, from: plistData)

        return mobileProvision
    }
}
