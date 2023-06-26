import 'package:args/command_runner.dart';
import 'package:interact/interact.dart' as interact;

import 'package:pub_updater/pub_updater.dart';

/// `VersionCommand` is a subclass of the `Command` class and represents
/// a command-line command that is used to print the current version
/// of the `package_platform_detector` tool.
///
/// The `run` method prints the current version of the tool and checks if there is a newer version available.
/// If a newer version is found, the user is asked if they want to update to the latest version.
///
/// Example usage:
/// ```bash
/// dart main.dart version
/// ```
/// or using an alias:
/// ```bash
/// dart main.dart v
/// ```
///
const cliVersion = '0.0.0+4';

class VersionCommand extends Command<void> {
  @override
  String get description => 'Print the version of package_platform_detector.';

  @override
  String get name => 'version';

  @override
  List<String> get aliases => ['v'];

  @override
  Future<void> run() async {
    print(cliVersion);
    final pubUpdater = PubUpdater();
    const packageName = 'package_platform_detector';
    final isUpToDate = await pubUpdater.isUpToDate(
      packageName: packageName,
      currentVersion: cliVersion,
    );
    if (!isUpToDate) {
      final latestVersion = await pubUpdater.getLatestVersion(packageName);
      final shouldUpdate = interact.Confirm(
        prompt:
            'There is a new version of $packageName available ($latestVersion). '
            'Would you like to update?',
        defaultValue: false,
      ).interact();
      if (shouldUpdate) {
        await pubUpdater.update(packageName: packageName);
        print('$packageName has been updated to version $latestVersion.');
      }
    }
  }
}
