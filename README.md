# Form Builder Flutter App

This is a Flutter application that allows generating forms dynamically from a JSON file. Users can define the structure of the form and its fields using a JSON file, providing flexibility and extensibility to the application.

## Features

- **Dynamic Form Generation:** The application automatically creates form fields based on the provided JSON input.
- **Conditional Visibility:** Fields can be shown or hidden based on visibility rules defined in the JSON.
- **State Management:** Utilizes Riverpod to manage the state of the form, including field visibility and values.
- **Widget Build Optimization:** The application is optimized to rebuild only the necessary widgets based on user interaction and changing visibility conditions.

## Project Structure

- **`assets/`:** Contains the JSON file defining the form structure.
- **`lib/`:** Contains the source code of the application.
  - **`models/`:** Contains the data model to represent form fields.
  - **`providers/`:** Contains Riverpod providers for managing the form state.
  - **`widgets/`:** Contains custom widgets used in the application.
  - **`main.dart`:** Entry point of the application.

## Installation

1. Clone this repository on your local machine.
2. Open the project in your code editor.
3. Run `flutter pub get` to install the dependencies.

## Usage

1. Make sure you have the JSON file with the form structure in the `assets/` folder.
2. Run the application on a Flutter emulator or device.

## Example JSON

Here's an example of how the JSON file structure should be:

```json
[
  { "field_name": "name", "widget": "textfield", "visible": null },
  { "field_name": "email", "widget": "textfield", "visible": null },
  { "field_name": "age", "widget": "textfield", "visible": "name=='John'" }
]
```

This JSON defines a form with fields for name, email, and age. The visibility of the age field is conditioned on the value of the name field being "John".

Contribution
Contributions are welcome! If you have any ideas to improve this application, please open an issue or send a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for details.
