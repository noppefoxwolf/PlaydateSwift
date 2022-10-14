import PackagePlugin

@main
struct BootablePlugin: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) async throws -> [Command] {
        [
        ]
    }
}
