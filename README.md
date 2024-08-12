# BookApp

Welcome to **BookApp**, a book management application that lets users browse, favorite, and save books. This README will guide you through setting up, running, and contributing to the project.

## Features

- **Browse Books**: Fetch and display a list of books from an API.
- **Favorite Books**: Mark books as favorites and persist these favorites using UserDefaults.
- **Save Books Locally**: Save and retrieve books from a local database.
- **View Details**: View detailed information about a selected book.
- **Image Handling**: Display book cover images correctly within the app.

## Screenshot
List Book Page

![Simulator Screenshot - iPhone 15 Pro - 2024-08-12 at 22 01 33](https://github.com/user-attachments/assets/2ff47840-9063-45af-995b-aab6fb7c7070)

Book Detail Page

![Simulator Screenshot - iPhone 15 Pro - 2024-08-12 at 22 10 50](https://github.com/user-attachments/assets/cbde1919-78ce-4d38-a55c-7a8d890dbc31)

Add Book Page

![Simulator Screenshot - iPhone 15 Pro - 2024-08-12 at 22 01 39](https://github.com/user-attachments/assets/e9f11019-78b3-4d31-b5e2-7c608bd3c1fa)



## Getting Started

### Prerequisites

- **Xcode**: This project is built with Xcode 15.4.
- **Swift**: Ensure you have a compatible version of Swift installed.

### Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/bookapp.git
  
2. **Navigate to the Project Directory:**

   ```bash
   cd bookapp

3. **Open the Project in Xcode:**:
   ```bash
   open BookApp.xcodeproj

4. **Build and Run:**:

   Select the desired scheme and device/simulator, then build and run the project using Xcode.

### Usage

Browse Books:
   - The main screen displays a list of books fetched from an API.
   
Favorite a Book:
   - Tap the favorite button on a book to mark it as a favorite. This state will be saved and persisted across app sessions.
   
View Book Details:
   - Tap on a book to view detailed information including title, author, publication date, and cover image.

Save Books Locally:
   - Books can be saved to and retrieved from a local database for offline access.

### General Architecture

- This project use storyboard and xib for view and layout.
- This project use MVVM architecture
- Most of the code had unit test and been build using SOLID Principle

### Future Improvement
- Book Id should have saved in UUID to make sure book added won't have same id.
- Book Detail page and Add Book Page still using block and pure MVC pattern, can be improved using MVVM so that the logic can be tested
- The design is still simple and can still be improved.
- Error handling should return specific enum error case for better understanding
- Can add snapshot test for UI Testing

### Contributing
We welcome contributions to enhance BookApp. If you'd like to contribute, please follow these steps:

1. **Fork the Repository**: Create your own fork of the repository.
2. **Create a Branch**: Create a feature branch for your changes.
3. **Make Your Changes**: Implement your feature or bug fix.
4. **Submit a Pull Request**: Open a pull request from your branch to the main repository.

### Contact
For questions or suggestions, please contact us at [kevin9huang1994@gmail.com].
