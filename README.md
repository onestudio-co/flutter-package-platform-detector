# Flutter Package Platform Detector

This Dart CLI application helps you identify the platform support of every dependency in a Flutter
project's `pubspec.yaml` file. It fetches information from `pub.dev` about each package, determines
whether it's a Flutter plugin, and identifies which platforms are supported. The result is a CSV
file that provides an overview of all your dependencies.

## Installation

Use the following command to globally activate this package:

```shell
dart pub global activate package_platform_detector
```

## Commands

This CLI application includes the following commands:

### Detect

This command detects the platform support for each dependency in your `pubspec.yaml` file and
generates a CSV file.

```shell
package_platform_detector detect
```

### Version

This command displays the current version of `package_platform_detector`. Additionally, it checks
for available updates on `pub.dev` and prompts the user for an optional update.

```shell
package_platform_detector version
```

## Usage

Navigate to your Flutter project's root directory where the `pubspec.yaml` file is located. Run the
detect command as shown above. This will generate a CSV file named `dependencies.csv` in the same
directory.

<img width="1434" alt="image" src="https://github.com/onestudio-co/flutter-package-platform-detector/assets/17902030/f71583d8-7282-49f9-83f8-fe960f2a0510">


## Changelog

Please see the `CHANGELOG.md` file for more information on what has changed recently.

## License

Please see the `LICENSE.md` file for more information on the license.

## Contributing

Contributions are always welcome!
