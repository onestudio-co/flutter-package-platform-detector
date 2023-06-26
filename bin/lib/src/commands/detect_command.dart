import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

/// `DetectCommand` is a subclass of the `Command` class and represents
/// a command-line command that is used to detect the platforms supported
/// by each package in the `pubspec.yaml` file.
///
/// The `run` method loads the `pubspec.yaml` file, reads the dependencies,
/// fetches the information for each dependency from the Pub.dev API, checks the
/// platforms that each package supports, and writes this information into a
/// CSV file named `dependencies.csv`.
///
/// Example usage:
/// ```bash
/// dart main.dart detect
/// ```
///
class DetectCommand extends Command<void> {
  @override
  String get description =>
      'Detect supported platform for each package on pubspec file.';

  @override
  String get name => 'detect';

  @override
  Future<void> run() async {
    final doc = await loadYaml(File('pubspec.yaml').readAsStringSync());

    if (doc == null) {
      print('Failed to load pubspec.yaml ⚠️');
      return;
    }

    final dependencies = doc['dependencies']?.keys ?? [];
    final devDependencies = doc['dev_dependencies']?.keys ?? [];

    var allDependencies = [...dependencies, ...devDependencies];

    final rows = <List<String>>[];

    rows.add([
      'Package',
      'Is plugin',
      'Android',
      'iOS',
      'macOS',
      'Windows',
      'Linux',
      'Web',
      'Notes',
    ]);
    for (final package in allDependencies) {
      final response =
          await http.get(Uri.parse('https://pub.dev/api/packages/$package'));

      print('Load Package info for $package ...');
      if (response.statusCode != 200) {
        print('Failed to load package info for $package');
        continue;
      }

      final data = json.decode(response.body);
      final pubspec = data['latest']['pubspec'];
      final flutter = pubspec['flutter'];
      final platforms = flutter?['plugin']?['platforms'];

      final isPlugin = platforms != null;
      final android =
          platforms?['android'] != null ? '✅' : (isPlugin ? '❌' : '✅');
      final ios = platforms?['ios'] != null ? '✅' : (isPlugin ? '❌' : '✅');
      final web = platforms?['web'] != null ? '✅' : (isPlugin ? '❌' : '✅');
      final windows =
          platforms?['windows'] != null ? '✅' : (isPlugin ? '❌' : '✅');
      final macos = platforms?['macos'] != null ? '✅' : (isPlugin ? '❌' : '✅');
      final linux = platforms?['linux'] != null ? '✅' : (isPlugin ? '❌' : '✅');

      var notes = [];
      if (platforms?.containsKey('macos') == false) {
        notes.add('macOS not supported ⚠️');
      }
      if (platforms?.containsKey('web') == false) {
        notes.add('Web not supported ⚠️');
      }

      rows.add([
        package,
        isPlugin.toString(),
        android,
        ios,
        macos,
        windows,
        linux,
        web,
        notes.join(' '),
      ]);
    }

    var csv = const ListToCsvConverter().convert(rows);

    final file = File('dependencies.csv')..writeAsStringSync(csv);

    print('generate dependence.csv file done on path ${file.path}  🎉');
  }
}
