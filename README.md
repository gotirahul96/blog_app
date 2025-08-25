# 📖 Flutter Blog App  

A modern **Blog Application** built with **Flutter Clean Architecture** using **BLoC**, **Supabase**, **GetIt**, and an **Internet Connectivity Checker**.  
This app follows scalable and testable architecture patterns, making it production-ready and developer-friendly. 🚀  

---

## ✨ Features  

- 🔑 **Authentication** – User signup & login powered by [Supabase](https://supabase.com/)  
- 📝 **Create & Read Blogs** – Users can publish and explore blogs  
- 💾 **Clean Architecture** – Organized into `Data`, `Domain`, and `Presentation` layers  
- 🎯 **BLoC State Management** – Reactive, testable, and scalable  
- 📡 **Internet Checker** – Handles online/offline states gracefully  
- 🛠 **Dependency Injection** – Powered by [GetIt](https://pub.dev/packages/get_it)  
- 🌗 **Dark/Light Theme** – Adaptive UI for better UX  

---

## 🏛️ Architecture Overview  

This app is built using **Flutter Clean Architecture** principles:  


**Layers**:  
- **Data Layer** → Remote datasources (Supabase) & repositories  
- **Domain Layer** → Entities & UseCases  
- **Presentation Layer** → UI + BLoC state management  

---

## 🖥️ Tech Stack  

- [Flutter](https://flutter.dev/) – Cross-platform framework  
- [BLoC](https://pub.dev/packages/flutter_bloc) – State management  
- [Supabase](https://supabase.com/) – Backend as a service  
- [GetIt](https://pub.dev/packages/get_it) – Dependency Injection  
- [Connectivity Plus](https://pub.dev/packages/connectivity_plus) – Internet checker  

---

## 📸 Screenshots  

| Home Screen | Blog Details | Create Blog |
|-------------|--------------|-------------|
| ![Home](https://via.placeholder.com/200x400?text=Home) | ![Details](https://via.placeholder.com/200x400?text=Details) | ![Create](https://via.placeholder.com/200x400?text=Create) |

---

## 🚀 Getting Started  

### Prerequisites  
- Flutter SDK (>=3.0)  
- Supabase project with `auth` and `blogs` table configured  

### Installation  

```bash
# Clone the repository
git clone https://github.com/your-username/flutter_blog_app.git

# Navigate into the project
cd flutter_blog_app

# Install dependencies
flutter pub get

# Run the app
flutter run
