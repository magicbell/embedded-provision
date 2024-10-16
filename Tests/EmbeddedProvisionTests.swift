import Testing
import Foundation
@testable import EmbeddedProvision

let existingProvisionURL: URL = {
    let fixturesBaseURL = Bundle.fixturesBaseURL()
    return fixturesBaseURL.appendingPathComponent("embedded.mobileprovision")
}()

let missingProvisionURL: URL = URL(fileURLWithPath: "/tmp/non-existent.provisionprofile")

@Suite
struct embeddedProvisionPlist {
    @Test("is present for existing provision")
    func extistingProvision_isPresent() throws {
        let provision = EmbeddedProvision(provisionFileURL: existingProvisionURL)

        #expect(provision.embeddedProvisionPlist != nil)
    }

    @Test("is nil for missing provision")
    func missingProvision_isNil() throws {
        let provision = EmbeddedProvision(provisionFileURL: missingProvisionURL)

        #expect(provision.embeddedProvisionPlist == nil)
    }

    @Test("is nil for missing provision in test bundle")
    func embeddedProvisionPlist_onTestBundleProvision_isNil() throws {
        let provision = EmbeddedProvision()

        #expect(provision.embeddedProvisionPlist == nil)
    }
}

@Suite
struct hasEmbeddedProvision {
    @Test("is true for existing provision")
    func existingProvision_isTrue() throws {
        let provision = EmbeddedProvision(provisionFileURL: existingProvisionURL)

        #expect(provision.hasEmbeddedProvision)
    }

    @Test("is false for missing provision")
    func missingProvision_isFalse() throws {
        let provision = EmbeddedProvision(provisionFileURL: missingProvisionURL)

        #expect(provision.hasEmbeddedProvision == false)
    }
}

@Suite
struct entitlements {
    @Test("is present for existing provision")
    func extistingProvision_isPresent() throws {
        let provision = EmbeddedProvision(provisionFileURL: existingProvisionURL)

        #expect(provision.entitlements != nil)
    }

    @Test("is nil for missing provision")
    func missingProvision_isNil() throws {
        let provision = EmbeddedProvision(provisionFileURL: missingProvisionURL)

        #expect(provision.entitlements == nil)
    }
}

@Suite
struct apnsEnvironment {
    @Test("is present for existing provision")
    func extistingProvision_isPresent() throws {
        let provision = EmbeddedProvision(provisionFileURL: existingProvisionURL)

        #expect(provision.apnsEnvironment != nil)
    }

    @Test("is present for existing provision")
    func extistingProvision_isCorrect() throws {
        let provision = EmbeddedProvision(provisionFileURL: existingProvisionURL)

        #expect(provision.apnsEnvironment == .production)
    }

    @Test("is nil for missing provision")
    func missingProvision_isNil() throws {
        let provision = EmbeddedProvision(provisionFileURL: missingProvisionURL)

        #expect(provision.apnsEnvironment == nil)
    }
}

@Suite
struct teamId {
    @Test("is present for existing provision")
    func extistingProvision_isPresent() throws {
        let provision = EmbeddedProvision(provisionFileURL: existingProvisionURL)

        #expect(provision.teamId != nil)
    }

    @Test("is present for existing provision")
    func extistingProvision_isCorrect() throws {
        let provision = EmbeddedProvision(provisionFileURL: existingProvisionURL)

        #expect(provision.teamId == "FAKETEAMID")
    }

    @Test("is nil for missing provision")
    func missingProvision_isNil() throws {
        let provision = EmbeddedProvision(provisionFileURL: missingProvisionURL)

        #expect(provision.teamId == nil)
    }
}
