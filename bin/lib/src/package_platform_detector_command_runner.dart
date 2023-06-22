import 'package:args/command_runner.dart';

import 'commands/detect_command.dart';
import 'commands/version_command.dart';

/// [PackagePlatformDetectorCommandRunner] is the main class for the `PackagePlatformDetector` tool.
/// It is responsible for initiating and running the package platform detection process.
///
/// It inherits from the [CommandRunner] class of the `args` package,
/// which is a class that generates command-line apps.
///
/// Example usage:
/// ```dart
/// void main(List<String> arguments) async {
///   await PackagePlatformDetectorCommandRunner().run(arguments);
/// }
/// ```
class PackagePlatformDetectorCommandRunner extends CommandRunner<void> {
  PackagePlatformDetectorCommandRunner()
      : super(
          'package_platform_detector',
          'A CLI tool to detect supported platform for each package on pubspec file.',
        ) {
    addCommand(VersionCommand());
    addCommand(DetectCommand());
  }
}
