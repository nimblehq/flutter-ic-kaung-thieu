# Survey Flutter
A simple mobile application written in Flutter allows users to take surveys.

## Prerequisite

- [FVM (Flutter Version Manager)](https://fvm.app/) helps with the need for consistent app builds by referencing the Flutter SDK version used on a per-project basis. It also allows you to have multiple Flutter versions installed to quickly validate and test upcoming Flutter releases with your apps without waiting for Flutter installation every time.
  ```bash
  brew tap leoafarias/fvm
  brew install fvm
  ```

## Getting Started
1. Checkout this repository
```bash
git clone https://github.com/nimblehq/flutter-ic-kaung-thieu.git
```

2. Setup
- Create these `.env` files in the root directory according to the flavors and add the required environment variables into them. The example environment variable is in `.env.sample`.
  - Staging: `.env.staging`
  - Production: `.env`
- Run code generator
  ```bash
  fvm flutter packages pub run build_runner build --delete-conflicting-outputs
  ```

3. Run the app with the desire app flavor
- Staging:
  ```bash
  fvm flutter run --flavor staging
  ```
- Production:
  ```bash
  fvm flutter run --flavor production
  ```

4. Test
- Run unit testing:
  ```bash
  fvm flutter test
  ```
- Run integration testing:
  ```bash
  fvm flutter drive --driver=test_driver/integration_test.dart --target=integration_test/{test_file}.dart --flavor staging
  ```

## License

This project is Copyright (c) 2014 and onwards. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
