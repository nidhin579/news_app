# News App

## Getting Started :rocket:

**News App** is a hybrid application (Android and iOS) that provides users with paginated news highlights on the home page. Clicking on a news highlight opens the detailed news page, from which users can navigate to the original news source. The project is hosted on GitHub at [https://github.com/nidhin579/news_app](https://github.com/nidhin579/news_app).

### Features

The application is capable of:
- Displaying paginated news highlights on the home page.
- Allowing users to click on a news highlight to view detailed information on a dedicated news detail page.
- Providing a navigation option from the detailed news page to the source of the news article.


### Technical Features and Implementation

- The project uses the News API to pull news data.
- The code is organized with a clear, consistent package of Stacked with MVVM architecture.
- The application uses stacked for state management, ensuring the code is scalable and maintainable.
- The app runs smoothly on both iOS and Android platforms.
- The application has unit and widget tests to ensure stability and maintainability.

### Demo

- Demo:
https://youtube.com/shorts/FqfPHSzbcts



### How to Run the Project

- Clone the project using:
  ```sh
  git clone https://github.com/nidhin579/news_app
  ```
- Download the .env file attached in the email.
- Place the .env file inside the project folder.

- Install dependencies and build the project:
```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```
- Run the code after selecting the appropriate Android emulator or iOS simulator.

### How to run tests

- Inside the project terminal ```flutter test --coverage```
- To view coverage using lcov:
```sh
  brew install lcov
  genhtml -o coverage coverage/lcov.info
```

## The Code Structure and elements :abcd:
The application is capable of running in Android and iOS devices and built using Flutter. The code uses STACKED as the state management tool.
The following packages are used in the development:
* stacked: ^3.4.0
* stacked_services: ^1.1.0
* envied: ^0.5.4+1
* http: ^1.2.1
* cached_network_image: ^3.3.1
* url_launcher: ^6.3.0
* intl: ^0.19.0

# Also the dev dependencies:

* build_runner: ^2.4.5
* flutter_lints: ^2.0.0
* mockito: ^5.4.1
* stacked_generator: ^1.3.3
* envied_generator: ^0.5.4+1
* mocktail: ^1.0.4
