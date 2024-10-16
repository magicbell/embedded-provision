import Foundation

// Inspired by Expo
// https://github.com/expo/expo/blob/c158ef23812c2995f326c51565b189e234948885/packages/expo-application/ios/EXApplication/EXProvisioningProfile.m#L28 (MIT License)
// and https://github.com/doneservices/ApsEnvironment/blob/221afddd19be77f9a5a943be637a8cc7e9dfeb94/Sources/ApsEnvironment/ApsEnvironment.swift#L4 (MIT License)

public class EmbeddedProvision {

    init(provisionFileURL: URL? = nil) {
        embeddedProvisionFileURL = provisionFileURL
    }
    /**
     - SeeAlso: [TN3125 - Profile Location](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#Profile-location)

     - Returns: A file URL pinting to the location of the mobile provision, or nil.
     */
    lazy var embeddedProvisionFileURL: URL? = {
        if let iOSURL = Bundle.main.url(forResource: "embedded", withExtension: "mobileprovision") {
            return iOSURL
        }
        if let macOSURL = Bundle.main.url(forResource: "embedded", withExtension:"provisionprofile", subdirectory: "Contents") {
            return macOSURL
        }
        return nil
    }()

    /**
     - Returns: A stringly typed map of values inside the provision profile, if present.
     */
    lazy var embeddedProvisionPlist: [String: AnyObject]? = {
        guard
            let url = embeddedProvisionFileURL,
            let data = try? Data(contentsOf: url),
            let open = data.range(of: "<plist".data(using: .ascii)!),
            let close = data.range(of: "</plist>".data(using: .ascii)!, options: [], in: open.lowerBound..<data.endIndex),
            let rawPlist = try? PropertyListSerialization.propertyList(from: data[open.lowerBound..<close.upperBound], options: [], format: nil),
            let plist = rawPlist as? [String: AnyObject] else {
            return nil
        }
        return plist
    }()

    /**
     Wether the app has an embedded provision.

     Will return false on Simulator builds.

     - Returns: A boolean indicating wether the app contains an embedded provision
     */
    lazy var hasEmbeddedProvision: Bool = embeddedProvisionPlist != nil


    lazy var entitlements: [String: AnyObject]? = embeddedProvisionPlist?["Entitlements"] as? [String: AnyObject]

    lazy var apnsEnvironment: APNSEnvironment? = {
        guard let environmentString = entitlements?["aps-environment"] as? String,
              let environment = APNSEnvironment(rawValue: environmentString) else {
            return nil
        }
        return environment
    }()

    lazy var teamId: String? = entitlements?["com.apple.developer.team-identifier"] as? String
}
