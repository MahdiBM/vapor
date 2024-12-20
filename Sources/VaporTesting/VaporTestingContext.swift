#if compiler(>=6.0)
import Testing

public enum VaporTestingContext {
    @TaskLocal public static var emitWarningIfCurrentTestInfoIsUnavailable: Bool?

    /// Throws an error if the test is not being run in a swift-testing context.
    static func warnIfNotInSwiftTestingContext(
        fileID: String,
        filePath: String,
        line: Int,
        column: Int
    ) {
        let shouldWarn = VaporTestingContext.emitWarningIfCurrentTestInfoIsUnavailable ?? true
        let isNotInSwiftTesting = Test.current == nil
        if shouldWarn, isNotInSwiftTesting {
            let sourceLocation = Testing.SourceLocation(
                fileID: fileID,
                filePath: filePath,
                line: line,
                column: column
            )
            print("""
            🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻
            swift-testing function triggered in a non-swift-testing context.
            This will result in test failures not being reported.
            Use 'app.testing()' instead of 'app.testable()' in swift-testing tests.
            This warning can be incorrect if you're in a detached task.
            In that case, use `VaporTestingContext.$emitWarningIfCurrentTestInfoIsUnavailable.withValue(false) { /* Execute your tests here */ }` to avoid this warning.
            Location: \(sourceLocation.debugDescription)
            🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺
            """)
            fflush(stdout)
        }
    }
}
#endif