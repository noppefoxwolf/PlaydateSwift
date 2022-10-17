import PackagePlugin
import Foundation

@main
struct BootablePlugin: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) async throws -> [Command] {
        let makefileURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
        return [
            .prebuildCommand(
                displayName: "Inject event handler file.",
                executable: Path("/bin/cp"),
                arguments: [
                    "\(makefileURL.path)/Boot.swift",
                    "\(context.pluginWorkDirectory.string)/Boot.swift",
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            ),
        ]
    }
}
