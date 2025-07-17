# 🌦️ Weather App

This is a Flutter-based weather application developed for the course **1DV535** at Linnaeus University.  
It uses the [OpenWeatherMap API](https://openweathermap.org/api) to display your current weather conditions and a 5-day forecast (with 3-hour intervals).

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- An Android/iOS emulator or physical device with developer mode enabled
- OpenWeatherMap API key 

### Steps
1. Clone the repository and go to root:
   ```bash
   git clone https://github.com/your-username/flutter-weather-app.git
   cd flutter-weather-app
2. Get the required dependencies:
   ```bash
   flutter pub get
3. Create a file named '.env' in your root directory and add your key with the followinf line:
   ```ini
   OPENWEATHERMAP_API_KEY=your_api_key_here
3. Run the app:
   ```bash
   flutter run
