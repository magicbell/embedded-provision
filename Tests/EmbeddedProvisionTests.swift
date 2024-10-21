import Foundation
import Testing

@testable import EmbeddedProvision

let existingProvisionURL: URL = {
    let fixturesBaseURL = Bundle.fixturesBaseURL()
    return fixturesBaseURL.appendingPathComponent("embedded.mobileprovision")
}()

let missingProvisionURL: URL = URL(
    fileURLWithPath: "/tmp/non-existent.provisionprofile")

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
    func defaultProvision() throws {
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
        #expect(
            provision.name == "iOS Team Provisioning Profile: pushinfo.example")
    }

    @Test("parses app ID")
    func appIDName() throws {
        #expect(provision.appIDName == "XC pushinfo example")
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
        #expect(provision.creationDate.timeIntervalSince1970 == 1_729_244_250)
    }

    @Test("parses expirationDate")
    func expirationDate() throws {
        #expect(provision.expirationDate.timeIntervalSince1970 == 1_760_780_250)
    }
}

@Suite("Entitlement parsing")
struct EmbeddedProvisionEntitlements {
    let entitlements = try! EmbeddedProvision.load(from: existingProvisionURL)
        .entitlements

    @Test("parses keychainAccessGroups")
    func keychainAccessGroups() throws {
        #expect(
            entitlements.keychainAccessGroups == [
                "7847W99F5L.*", "com.apple.token",
            ])
    }

    @Test("parses getTaskAllow")
    func getTaskAllow() throws {
        #expect(entitlements.getTaskAllow == true)
    }

    @Test("parses apsEnvironment")
    func apsEnvironment() throws {
        #expect(entitlements.apsEnvironment == .development)
    }

    @Test("parses teamId")
    func teamId() throws {
        #expect(entitlements.teamId == "7847W99F5L")
    }
}
