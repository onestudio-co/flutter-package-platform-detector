import 'dart:io';

import 'lib/src/package_platform_detector_command_runner.dart';

/// This is the main function which is the entry point to the Dart program.
///
/// [arguments] is a list of command-line arguments that were passed to the app.
///
/// The function initiates the [PackagePlatformDetectorCommandRunner] class and
/// calls the `run` method, passing the command-line [arguments].
///
/// In case of an error, the error is caught and printed to the standard error.
///
/// Example usage:
/// ```bash
/// dart main.dart <command-line arguments>
/// ```
void main(List<String> arguments) async {
  try {
    await PackagePlatformDetectorCommandRunner().run(arguments);
  } catch (err) {
    stderr.writeln(err.toString());
    rethrow;
  }
}
