import Testing
import Foundation
@testable import EmbeddedProvision

let existingProvisionURL: URL = {
    let fixturesBaseURL = Bundle.fixturesBaseURL()
    return fixturesBaseURL.appendingPathComponent("embedded.mobileprovision")
}()

let missingProvisionURL: URL = URL(fileURLWithPath: "/tmp/non-existent.provisionprofile")

@Suite("Loading")
struct EmbeddedProvisionLoading {
    @Test("is present for existing provision")
    func extistingProvision() throws {
        let provision = try! EmbeddedProvision.load(from: existingProvisionURL)

        #expect(provision != nil)
    }

    @Test("throws for missing or invalid provision")
    func missingProvision() throws {
        #expect(throws: EmbeddedProvisionError.decodingError) {
            try EmbeddedProvision.load(from: missingProvisionURL)
        }
    }

    @Test("is nil for missing provision in test bundle")
    func embeddedProvisionPlist_onTestBundleProvision_isNil() throws {
        let provision = try! EmbeddedProvision.load()

        #expect(provision == nil)
    }
}

@Suite("Property parsing")
struct EmbeddedProvisionProperties {
    let provision = try! EmbeddedProvision.load(from: existingProvisionURL)

    //    public let entitlements: Entitlements
    @Test("parses name")
    func name() throws {
        #expect(provision.name == "iOS Team Provisioning Profile: com.magicbell.fake-bundle-id")
    }

    @Test("parses app ID")
    func appIDName() throws {
        #expect(provision.appIDName == "A Fake App for Testing")
    }

    @Test("parses platform")
    func platform() throws {
        #expect(provision.platform == ["iOS", "xrOS", "visionOS"])
    }

    @Test("parses isXcodeManaged")
    func isXcodeManaged() throws {
        #expect(provision.isXcodeManaged == true)
    }

    @Test("parses creationDate")
    func creationDate() throws {
        #expect(provision.creationDate == Date(timeIntervalSince1970: 1711018098))
    }

    @Test("parses expirationDate")
    func expirationDate() throws {
        #expect(provision.expirationDate == Date(timeIntervalSince1970: 1742554098))
    }
}

@Suite("Entitlement parsing")
struct EmbeddedProvisionEntitlements {
    let entitlements = try! EmbeddedProvision.load(from: existingProvisionURL).entitlements

    @Test("parses keychainAccessGroups")
    func keychainAccessGroups() throws {
        #expect(entitlements.keychainAccessGroups == ["FAKETEAMID.*", "com.apple.token"])
    }

    @Test("parses getTaskAllow")
    func getTaskAllow() throws {
        #expect(entitlements.getTaskAllow == true)
    }

    @Test("parses apsEnvironment")
    func apsEnvironment() throws {
        #expect(entitlements.apsEnvironment == .production)
    }

    @Test("parses teamId")
    func teamId() throws {
        #expect(entitlements.teamId == "FAKETEAMID")
    }
}
