
# Project Report: Smart Plant Care Application

## Abstract
This project involves the development of a mobile application, "Smart Plant Care," designed to assist users in managing their plants efficiently. Built using Flutter for frontend development, Node.js for backend APIs, and Firebase Datastore for database management, the application provides features like plant identification, weather integration, plant reminders, and secure user authentication. APIs like OpenWeatherMap and PlantNet are leveraged to enhance functionality. The app ensures secure data handling through JWT-based authentication.

---

## Table of Contents
1. Introduction
2. Objectives
3. System Architecture
4. Features
5. Technologies Used
6. Implementation
7. Results and Testing
8. Future Enhancements
9. Conclusion

---

## 1. Introduction
The "Smart Plant Care" application was created to simplify plant management for users by integrating modern technology. Users can monitor weather conditions, identify plant species through images, set up plant watering reminders, and securely access the application.

---

## 2. Objectives
- Provide users with tools to identify plant species through image recognition.
- Allow users to track weather updates for better plant care.
- Enable users to add plants to a database and set reminders for plant care activities.
- Ensure secure user access through JWT authentication.

---

## 3. System Architecture

The architecture consists of three primary layers:
- **Frontend:** Flutter for UI/UX development and integration of device-specific features like geolocation.
- **Backend:** Node.js for managing APIs and business logic.
- **Database:** Firebase Datastore for storing user data, plant details, and reminders.

---

## 4. Features

### 4.1 Plant Identification
- **API Used:** PlantNet
- **Functionality:** Users upload an image of a plant, and the app identifies the plant species and provides details.

### 4.2 Location-based Weather Details
- **API Used:** OpenWeatherMap
- **Functionality:** The app fetches the user’s current location and displays temperature and weather updates for better plant care decisions.

### 4.3 Plant Management
- **Create Plant:** Users can add plant details (e.g., name, type) to the database.
- **Display Plants:** A list of added plants is displayed in the app for easy management.

### 4.4 Plant Care Reminders
- **Feature:** Users receive notifications for watering or other care activities based on pre-set schedules.

### 4.5 User Authentication
- **Method:** JWT-based authentication.
- **Functionality:** Secure login and session management for user accounts.

---

## 5. Technologies Used

### 5.1 Frontend
- **Framework:** Flutter
- **Libraries:**
  - flutter_secure_storage (for JWT storage)
  - geolocator (for fetching location)

### 5.2 Backend
- **Framework:** Node.js
- **Libraries:**
  - Express.js (for API development)
  - jsonwebtoken (for secure authentication)

### 5.3 Database
- **Platform:** Firebase Datastore
- **Purpose:** Store user data, plant information, and reminders.

### 5.4 APIs
- **PlantNet:** Plant identification through image processing.
- **OpenWeatherMap:** Fetch weather details using geolocation.

---

## 6. Implementation

### 6.1 Frontend Development
- Flutter was used to build a responsive and user-friendly interface.
- The `geolocator` package was integrated to fetch user locations for weather details.
- A structured UI was developed to manage plant lists, add new plants, and display reminders.

### 6.2 Backend Development
- Node.js and Express.js were used to create RESTful APIs for communication between the app and the database.
- JWT was implemented for secure user authentication.
- APIs were developed to manage CRUD operations for plants and reminders.

### 6.3 Database Integration
- Firebase Datastore was chosen for its real-time synchronization and scalability.
- Data models were created for users, plants, and reminders.

### 6.4 API Integration
- **PlantNet API:** Integrated for plant identification by sending image data and receiving plant details.
- **OpenWeatherMap API:** Integrated to fetch weather updates based on the user’s location.

---

## 7. Results and Testing

- **Functional Testing:** All features, including plant addition, reminders, and authentication, were tested for correctness.
- **Performance Testing:** The app performed efficiently, with minimal delays in API responses and database interactions.
- **User Testing:** Users found the interface intuitive and the features useful for managing plant care.

---

## 8. Future Enhancements

- **Enhanced Notifications:** Add voice alerts for reminders.
- **Social Sharing:** Enable users to share plant information on social media.
- **Advanced Plant Analytics:** Provide detailed insights into plant growth and care.
- **Multi-language Support:** Extend the app’s accessibility to non-English-speaking users.

---

## 9. Conclusion

The "Smart Plant Care" application successfully integrates Flutter, Node.js, Firebase Datastore, and external APIs to provide a comprehensive solution for plant management. The app’s secure authentication, intuitive UI, and advanced features make it a valuable tool for plant enthusiasts.

APPLICATION APK LINK: https://drive.google.com/drive/folders/1-Oora51B7cBAIfF9DQHk-1P7AKl4RY7A

SOME INSTRUCTIONS FOR THE APPLICATION:
Please only input any of the following plant types to get personalized suggestions:
- Succulent
- Fern
- Orchid
- Pothos
- Snake Plant
- Monstera
- Peace Lily
- Aloe Vera
- Spider Plant
- Cactus
