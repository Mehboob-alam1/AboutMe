# My Profile App - Flutter Portfolio Application

A modern, interactive Flutter mobile application showcasing personal profile information with a clean Material Design interface. This app demonstrates core Flutter concepts including widgets, layouts, navigation, and external URL handling.

## 📱 Project Overview

**My Profile App** is a personal portfolio application built with Flutter that displays professional information, contact details, skills, education, and social media links. The app features three main screens with smooth navigation and a dark mode toggle.

## ✨ Features

### Screen 1: Welcome Screen
- Beautiful gradient background
- Centered app title: "Welcome to My Profile"
- Dark mode toggle switch (top-right corner)
- "View Profile" button for navigation
- Smooth transitions to Profile Screen

### Screen 2: Profile Screen
- Circular profile picture (from assets)
- Name and profession display
- Professional biography (2-3 lines)
- Contact information card with:
  - Email address
  - Phone number
  - Location
- Social media icons (LinkedIn, GitHub, Twitter/X) - all clickable
- Floating Action Button (FAB) to navigate to About Me page

### Screen 3: About Me Page
- ListView with organized sections:
  - **About Me**: Professional introduction and background
  - **Education**: Academic qualifications
  - **Skills**: Technical skills displayed as chips
  - **Hobbies**: Personal interests and activities
- Back button to return to Profile Screen

### Additional Features
- **Dark Mode Toggle**: Switch between light and dark themes
- **External URL Launching**: Social media icons open links in external browser
- **Responsive Design**: Works on different screen sizes
- **Material Design 3**: Modern UI following Material Design principles

## 🛠️ Technologies Used

- **Flutter SDK**: ^3.9.2
- **Dart**: Latest stable version
- **Packages**:
  - `url_launcher: ^6.2.5` - For opening external URLs
  - `iconsax: ^0.0.8` - Additional icon set
  - `cupertino_icons: ^1.0.8` - iOS-style icons

## 📂 Project Structure

```
faiz_portfolio/
├── lib/
│   └── main.dart              # Main application file with all screens
├── assets/
│   └── images/
│       ├── faiz.jpeg         # Profile picture
│       ├── github.png        # GitHub icon
│       ├── linkedin.png      # LinkedIn icon
│       └── twitter.png       # Twitter/X icon
├── android/                   # Android-specific configuration
├── ios/                       # iOS-specific configuration
└── pubspec.yaml              # Dependencies and assets configuration
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android Emulator or physical device / iOS Simulator

### Installation Steps

1. **Clone or download the project**
   ```bash
   cd faiz_portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Building APK

To build a release APK:
```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## 🎨 Design Choices

### UI/UX Design
- **Material Design 3**: Modern, clean interface following Google's Material Design guidelines
- **Color Scheme**: Teal-based color palette for a professional look
- **Typography**: Roboto font family for consistency
- **Layout**: Card-based design for better information hierarchy
- **Navigation**: Intuitive navigation flow between screens

### Widget Usage
- **Layout Widgets**: Column, Row, Container, Padding, Align
- **Material Widgets**: Scaffold, AppBar, Card, ListTile, Chip, FloatingActionButton
- **Navigation**: Navigator with MaterialPageRoute
- **Images**: AssetImage for profile picture and social icons
- **Icons**: Material Icons and Iconsax for variety

### Responsive Design
- Uses `LayoutBuilder` and `ConstrainedBox` for responsive layouts
- `SingleChildScrollView` ensures content is accessible on smaller screens
- Proper spacing and padding for different screen sizes

## 📋 Assignment Requirements Coverage

### ✅ Basic Requirements
- [x] Three screens (Welcome, Profile, About Me)
- [x] Basic Flutter widgets (Text, Image, Column, Row, Container)
- [x] Layout widgets (Padding, Align, Card, ListView)
- [x] Navigation between screens
- [x] Custom widgets for UI reusability
- [x] Material Design principles

### ✅ Bonus Features
- [x] Dark Mode toggle
- [x] External URL launching for social media
- [x] Professional UI/UX design

## 🔧 Configuration

### Android Configuration
The `AndroidManifest.xml` includes necessary queries for URL launching:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="http" />
    </intent>
</queries>
```

### Assets Configuration
Assets are declared in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/faiz.jpeg
    - assets/images/github.png
    - assets/images/linkedin.png
    - assets/images/twitter.png
```

## 📝 Personal Information

- **Name**: Mehboob Alam Lone
- **Profession**: Software Engineer
- **Email**: mehboobcodes@gmail.com
- **Location**: Gilgit, Pakistan
- **GitHub**:https://github.com/Mehboob-alam1/(https://github.com/Mehboob-alam1/)

## 🎯 Learning Outcomes

This project demonstrates understanding of:
- Flutter widget tree and composition
- State management (StatefulWidget for theme toggle)
- Navigation and routing
- Asset management
- External package integration
- Material Design implementation
- Responsive UI design

## 📸 Screenshots

*Note: Add screenshots of all three screens here for submission*

## 🐛 Known Issues

None at the moment. The app is fully functional.

## 🔮 Future Enhancements

Potential improvements:
- Add animations and transitions
- Implement local data storage
- Add more social media platforms
- Create editable profile feature
- Add portfolio projects section
- Implement contact form

## 📄 License

This project is created for educational purposes as part of Mobile Application Development course.

## 👨‍💻 Developer

**Mehboob Alam Lone**
- IT Graduate with specialization in Mobile Application Development
- Passionate about Flutter and mobile development
- GitHub: [@Mehboob Alam](https://github.com/Mehboob-alam1/)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design guidelines
- Course instructors for guidance and requirements

---

**Course**: Mobile Application Development  
**Assignment**: Assignment II - Personal Profile App  
**Semester Project**: Mobile Application Development Portfolio
