# Palapa Inspeksi - Vehicle Inspection Platform

<p align="center">
  <img src="https://raw.githubusercontent.com/CAR-dano/form-app/main/assets/images/icon.png" alt="Palapa Inspeksi App Icon" width="128"/>
</p>

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Build Status](https://img.shields.io/github/actions/workflow/status/CAR-dano/form-app/release.yml?branch=main&style=for-the-badge&logo=githubactions&logoColor=white&label=Build%26Release)](https://github.com/CAR-dano/form-app/actions/workflows/release.yml)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/CAR-dano/form-app)

**Palapa Inspeksi** is a robust, enterprise-grade mobile application built with Flutter, designed to streamline and standardize the vehicle inspection process for **PT. Inspeksi Mobil Jogja**. The app provides a guided, multi-step workflow that enables inspectors to meticulously document vehicle status, capture high-quality photographic evidence, and generate comprehensive reports with exceptional accuracy and efficiency.

---

## ✨ Features

The application is structured as an intuitive, step-by-step form that covers all facets of a professional vehicle inspection.

#### 📝 Comprehensive Inspection Workflow
- **Guided Data Entry:** A multi-page form that logically flows from inspector/customer details, vehicle data, and legal documents to detailed assessments and finalization.
- **Dynamic Data Fetching:** Inspector names and inspection branch locations are fetched dynamically from the backend API, ensuring data consistency and reducing manual entry.
- **Detailed Assessments:** In-depth scoring (1-10) for dozens of sub-categories across Features, Engine, Interior, Exterior, Undercarriage, and more.
- **Paint Thickness Grid:** A dedicated, visual interface for inputting paint thickness measurements across all major body panels.
- **Test Drive & Diagnostics:** Sections to log vehicle performance during a test drive and results from diagnostic tools (OBD Scanner, AC temperature, etc.).
- **Kelengkapan Checklist:** A simple toggle-based checklist for standard items like service books, spare keys, legal documents (BPKB), and tools.
- **Expandable Note Fields:** Smart text fields that support automatic bulleted lists for clear and detailed note-taking in every section.
- **Repair Cost Estimation:** A dynamic list for adding parts and estimated repair costs, with automatic thousand-separator formatting.

#### 📸 Advanced Image Management
- **Integrated Multi-Shot Camera:** A custom camera interface featuring zoom, flash control, and lens switching, designed for rapid, uninterrupted photo capture.
- **Mandatory & Additional Photos:** Clearly defined photo requirements for all major sections (General, Exterior, Interior, etc.), with the flexibility to add unlimited additional photos for detailed documentation.
- **Automatic Image Processing:** All captured images are automatically cropped to a 4:3 aspect ratio and resized to optimize for storage and upload speed, without sacrificing necessary detail.
- **In-App Photo Labeling:** Inspectors can label every photo, providing crucial context for the final report. Labels are mandatory for "additional" and "document" photos.
- **Gallery & Persistence:** Original, high-resolution photos are automatically saved to the device's gallery for backup, while processed images are persisted locally for the inspection report.

#### 💾 Intelligent Data Handling
- **Robust Local Persistence:** All form data and image references are saved locally on the device as JSON, allowing inspectors to safely pause and resume inspections at any time without data loss.
- **Seamless API Submission:** Completed inspection data and all associated images are efficiently batched and uploaded to the backend server.
- **Submission Caching:** Caches the last successful form data submission to prevent duplicate entries and intelligently resume image uploads if the network is interrupted.

#### 🔄 In-App Updates & UI
- **Automatic Update Check:** The app checks for new releases from the configured GitHub repository upon startup. It prioritizes downloading the `arm64-v8a` APK for optimal performance, with a fallback to a universal APK.
- **Seamless Installation:** Once downloaded, the app prompts the user to install the update directly, leveraging Android's `FileProvider` and `REQUEST_INSTALL_PACKAGES` permission for a smooth experience.
- **Branded User Interface:** Custom-styled widgets, inputs, and navigation elements create a consistent and professional user experience aligned with the brand.
- **Intuitive Navigation:** Smooth page transitions via swipe gestures and persistent navigation buttons (Next/Back).
- **Real-time Feedback:** Visual feedback for loading states, image processing, and data submission progress ensures the user is always informed.

**Update Feature Configuration:**
To enable and customize the update feature, ensure the following constants in `lib/services/update_service.dart` are set correctly:
- `githubOwner`: Set to your GitHub username or organization (e.g., `CAR-dano`).
- `githubRepo`: Set to your repository name (e.g., `form-app`).

**Required Android Permissions:**
The in-app update feature requires the following additions in `android/app/src/main/AndroidManifest.xml`:
- A `<provider>` entry for `androidx.core.content.FileProvider` within the `<application>` tag, pointing to `@xml/provider_paths`.
- The `<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />` permission.
- A `provider_paths.xml` file in `android/app/src/main/res/xml/` defining the shared paths.

## 🛠️ Tech Stack & Architecture

The application leverages a modern, scalable tech stack to ensure performance and maintainability.

| Category               | Technology / Package                                                                                                                              |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Core Framework**     | `Flutter`                                                                                                                                         |
| **State Management**   | `Riverpod` for robust, scalable, and testable state management.                                                                                   |
| **Networking**         | `Dio` for robust API communication, request cancellation, and interceptors.                                                                       |
| **Image Handling**     | `camera`, `image_picker` (Capture), `image` (Processing/Manipulation), `gal` (Gallery Save)                                                       |
| **Local Storage**      | `path_provider` for file system access to persist form data and image metadata as JSON.                                                           |
| **App Updates**        | `package_info_plus`, `permission_handler`, `open_file` for checking and installing new versions.                                                  |
| **UI & Styling**       | `google_fonts` (Rubik), `flutter_svg` for vector graphics, `flutter_markdown_plus` for release notes.                                             |
| **Utilities**          | `flutter_dotenv` for environment variable management, `uuid` for unique identifiers.                                                              |
| **Build & Deployment** | `flutter_launcher_icons`, `flutter_native_splash`, GitHub Actions for CI/CD.                                                                      |

### Project Architecture

The codebase is organized into a clean, feature-driven structure that promotes separation of concerns.

-   `lib/main.dart`: Application entry point, theme configuration, and portrait orientation lock.
-   `lib/models/`: Defines the core data structures (`FormData`, `ImageData`, `Inspector`) that model the application's domain.
-   `lib/pages/`: Contains the UI for each screen/page of the multi-step form.
-   `lib/providers/`: Manages all application state using Riverpod, cleanly separating UI from business logic (e.g., `form_provider`, `image_data_provider`, `update_service_provider`).
-   `lib/services/`: Houses business logic services like `api_service.dart` and `update_service.dart`.
-   `lib/utils/`: Contains reusable helper classes and functions for tasks like image processing (`image_capture_and_processing_util.dart`) and calculations.
-   `lib/widgets/`: Stores reusable, custom UI components (e.g., `LabeledTextField`, `NavigationButtonRow`, `MultiShotCameraScreen`).
-   `lib/formatters/`: Custom `TextInputFormatter` classes for specialized user input like dates, thousands separators, and bulleted lists.

## 🚀 Getting Started

Follow these steps to get the project running on your local machine.

### Prerequisites
-   [Flutter SDK](https://docs.flutter.dev/get-started/install) (version specified in `pubspec.yaml`)
-   An editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/CAR-dano/form-app.git
    cd form-app
    ```

2.  **Create the Environment File:**
    Copy the `.env.example` file to a new file named `.env` in the project root.
    ```bash
    cp .env.example .env
    ```
    Update the `.env` file with the actual API URLs:
    ```env
    # For production/release builds
    API_BASE_URL=https://your-production-api.com/api/v1

    # For staging/debug builds
    API_BASE_URL_DEBUG=https://your-staging-api.com/api/v1
    ```

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Run the application:**
    ```bash
    flutter run
    ```

## 📦 Building the App

To create a release build for Android, use the following command. The build name and number are derived from `pubspec.yaml` and the CI workflow.

```bash
flutter build apk --release
```

For more advanced build options, such as splitting the APK per ABI (as done in our CI pipeline):

```bash
flutter build apk --split-per-abi --release
```

## ⚙️ CI/CD

This project is equipped with GitHub Actions for automated quality checks and releases:

-   **PR Checks (`pr-checks.yml`):** On every pull request to `main`, this workflow runs:
    -   `flutter analyze` to enforce code quality.
    -   `flutter test` to run all unit and widget tests.
-   **Build & Release (`release.yml`):** On every push to the `main` branch, this workflow:
    -   Builds, signs, and versions the Android APKs (debug, release-universal, release-abi-specific).
    -   Automatically creates a new GitHub Release with a descriptive changelog.
    -   Uploads the generated APKs to the GitHub Release as assets.

## ⚖️ License
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
