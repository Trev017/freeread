# FreeRead, an Audiobook Application for iPhone

# Introduction

FreeRead is an audiobook application developed using the Dart programming language with Flutter as its primary framework for iOS mobile devices, from iOS 11 to the latest version. The application utilizes the LibriVox API to access to a wide array of audiobooks that are open and available in the Public Domain. The program also integrates the Hive dependency to access these audiobooks offline.

# Functional and Non-Functional Requirements

## Functional Requirements

<details>
<summary>Home Page</summary>

* As a user, I would like to enter the application without logging in so that I can access its contents immediately.
* As a user, I would like, to see my downloads on the home page so that I can access those audiobooks easily.
* As a user, I would like to see my favorites on the home page so that I can access those audiobooks easily.
</details>

<details>
<summary>Downloads Page</summary>

* As a system, I would like to tell the user that this page contains all books he or she has downloaded if there are no books that were downloaded yet so that users could fill this page with his or her downloads.
* As a user, I would like a page containing audiobooks and chapters that I have downloaded so that I can access these files easily.
* As a user, I would like the downloads page to have a sort setting so that I scroll through the page in an easier arrangement.
</details>

<details>
<summary>Favorites Page</summary>

* As a system, I would like to tell the user that this page contains all books he or she has marked as favorite if there are no books that were marked yet so that users could fill this page with his or her favorites.
* As a user, I would like a page containing audiobooks that I have marked as my favorite so that I can access these files easily.
* As a user, I would like the favorites page to have a sort setting so that I scroll through the page in an easier arrangement.
</details>

<details>
<summary>Catalog Page</summary>

* As a user, I would like to see recommendations on the catalog page so that I can access those audiobooks easily.
* As a user, I would like to access the browse all page so that I can view all the books that are available.
* As a user, I would like to access the browse authors page so that I can view all authors that are available.
* As a user, I would like to access the browse genres page so that I can view all listed genres.
</details>

<details>
<summary>Recommendations Page</summary>

* As a system, I would like to display a database error so that I could tell users that access to the database is currently unavailable.
* As a system, I would like to display a connection error so that I could ask the user if he or she is connected to the Internet.
* As a system, I would like to display some famous literature if the user has not marked anything as his or her favorites so that users could be given some starting recommendations to start marking as their favorites.
* As a user, I would like to be given recommendations based on my favorites so that I could listen to more books similar to what I read.
* As a user, I would like the recommendations page to have a sort setting so that I scroll through the page in an easier arrangement.
</details>

<details>
<summary>Browse All Page</summary>

* As a system, I would like to display a database error so that I could tell users that access to the database is currently unavailable.
* As a system, I would like to display a connection error so that I could ask the user if he or she is connected to the Internet.
* As a user, I would like a page containing all books available from LibriVox so that I can view any audiobook that I want.
* As a user, I would like the browse all page to have a sort setting so that I scroll through the page in an easier arrangement.
</details>

<details>
<summary>Browse Authors Page</summary>

* As a system, I would like to display a database error so that I could tell users that access to the database is currently unavailable.
* As a system, I would like to display a connection error so that I could ask the user if he or she is connected to the Internet.
* As a user, I would like a page containing all authors available from LibriVox so that I can view any of their literary works.
* As a user, I would like the browse authors page to have a sort setting so that I scroll through the page in an easier arrangement.
</details>

<details>
<summary>Author Information Page</summary>

* As a system, I would like to display a database error so that I could tell users that access to the database is currently unavailable.
* As a system, I would like to display a connection error so that I could ask the user if he or she is connected to the Internet.
* As a user, I would like a page containing all books of an author so that I can view any audiobooks made by that writer.
</details>

<details>
<summary>Browse Genres Page</summary>

* As a system, I would like to display a database error so that I could tell users that access to the database is currently unavailable.
* As a system, I would like to display a connection error so that I could ask the user if he or she is connected to the Internet.
* As a user, I would like a page containing all genres so that I can find books on a specific genre.
</details>

<details>
<summary>Browse Books by Genre Page</summary>

* As a system, I would like to display a database error so that I could tell users that access to the database is currently unavailable.
* As a system, I would like to display a connection error so that I could ask the user if he or she is connected to the Internet.
* As a user, I would like a page containing all books of an genre so that I can view any books classified under that category.
* As a user, I would like the browse books by genre page to have a sort setting so that I scroll through the page in an easier arrangement.
</details>

<details>
<summary>Search Page</summary>

* As a user, I would like a search bar for a book so that I could find a book.
* As a user, I would like a search filter so that I could search for a book in a specific genre.
* As a user, I would like the search filter to have a sort setting so that I scroll through results in an easier arrangement.
* As a user, I would like a search bar for an author so that I could find an author and his or her works.
* As a system, I would like to display a database error so that I could tell users that access to the database is currently unavailable.
* As a system, I would like to display a connection error so that I could ask the user if he or she is connected to the Internet.
* As a system, I would like to display no results so that the user can revise his or her search.
</details>

<details>
<summary>Settings Page</summary>

* As a user, I would like to know how to contact the administrators of the application so that I could report bugs found in the application.
* As a user, I would like to access the language settings so that I can configure what languages of a book reading should appear.
* As a user, I would like to access the appearance settings so that I can configure the theme of the application.
</details>

<details>
<summary>Language Settings Page</summary>

* As a user, I would like to configure what languages of a book reading should appear so that I could listen to an audiobook in whichever language I can understand it.
* As a user, I would like to have the option to select all languages so that I could conveniently enable all language options for my audiobook recordings.
* As a system, I would like to have all languages to currently be selected initially as default so that users could configure if they want specific languages filtered.
</details>

<details>
<summary>Appearance Settings Page</summary>

* As a user, I would like to change the appearance of the application to light mode so that I can view the application during day time.
* As a user, I would like to change the appearance of the application to dark mode so that I can view the application during night time.
* As a user, I would like to have the application's appearance to synchronize with my iPhone's appearance so that I can view the application without needing to change its settings all the time.
</details>

<details>
<summary>Book Information Page</summary>

* As a user, I would like to see the information of a book so that I could know what the book is about.
* As a user, I would like to download a chapter of an audiobook so that I can access that specific chapter offline.
* As a user, I would like to download all chapters of an audiobook so that I can access the entire book offline.
* As a user, I would like to mark a book as a favorite so that I could come back to it when I want to.
* As a user, I would like to have all chapters ready to listen so that downloading them is an option when needed.
* As a user, I would like to have the time of reading the chapter displayed so that I could know how long it takes to complete the chapter reading.
</details>

<details>
<summary>Book Reading Page</summary>

* As a user, I would like to bookmark a chapter so that I could know where I left off.
* As a user, I would like to skip through a couple of seconds so that I could get through parts of a chapter faster.
* As a user, I would like to skip the chapter so that I could get through the book faster.
* As a user, I would like a playback slider so that I could adjust what part of a chapter reading to listen to.
* As a user, I would like a pause button so that I could pause a part of the chapter reading.
* As a user, I would like a play button so that I could continue the chapter reading.
* As a user, I would like a playback speed slider so that I could adjust the speed of the chapter reading.
* As a user, I would like the name of the chapter to display so that I could know where I currently am.
</details>

## Non-Functional Requirements

<details>
<summary>Adaptability</summary>

* As a user, I would like to have the application available on iPhone, from iOS 11 to iOS 17 so that I can listen to stories with a small portable device.
</details>

# Technologies Utilized

1. Dart - Dart is utilized in the project as its primary programming language throughout its development. The decision to use Dart is it is one of many languages that can be used for developing applications on iOS mobile devices.
2. Flutter - Flutter is utilized in the project to develop its user interface. The framework can only be utilized in Dart. 
3. Hive - Hive is utilized in the project as a method to allow users to store data in their devices. The dependency allows the saved data to be accessed offline.
4. Visual Studio Code - Visual Studio Code is utilized in the project as an integrated development environment during the development of the program. This IDE also has an access to the terminal to execute commands when needed.
5. Android Studio - Android Studio code is utilized in the project as an integrated development environment during the development of the program. This IDE features an emulator of Android devices, which allows the developer to test the application and comprehend how it will appear in as a mobile application.
6. FlutLab.io - FlutLab.io is an online service that allows developers to create code for Flutter. Though sparingly, this service is utilized for creating iOS builds of the application.
7. Appetize.io - Appetize.io is an online service that allows the emulation of mobile applications for iOS and Android. Though sparingly, this service is utilized for its purpose.

# Learning Technologies

In search of a Capstone Project to carry out, the individual took interest in wanting to develop an application that do not come from programming languages that he had learned throughout his education in Grand Canyon University. It was when the individual was suggested Flutter that he embarked on discerning how this framework and its accompanying primary programming language functioned. Learning these technologies allowed the individual to gain better understanding on how mobile applications are developed.

## Dart

The individual chose to learn Dart for developing applications for mobile devices, such as Android and iPhone. The individual also wants to broaden his understanding of developing software for different programming languages and different devices, as he had been learning extensively to develop applications on desktop and websites.

## Flutter

The individual chose to learn Flutter to develop the user interface of the application. Front-end development is a skill the individual believes he is not adept at, so experiencing the use of this framework definitely helps him attain more knowledge about this aspect of coding. The individual believes that having an studying Flutter even further would help him to become better with creating mobile applications and user interfaces.

# Technical Approaches

## Sitemap Diagram

The diagram that is provided illustrates the sitemap of the project. The home page, the catalog page, the search page, and the settings page are all accessible through the program's navigation bar. The book reading page is accessible through the mini player, which appears throughout the application whenever a user opens a different page.
![Sitemap (CST-452 Milestone 6)](https://github.com/Trev017/freeread/assets/90469669/a23f6c14-d9ad-4468-91d4-b78a4a7ebde9)

## Logical Solution Diagram

The diagram that is provided illustrates the logical solution design of the project. The design contains the presentation layer, the application layer, the data layer, and the primary technologies used in the development of the program. The presentation layer contains the view classes that would construct the pages of the application and the widgets that appear in the program. The application layer contains the model classes that construct objects used for offline storage and the service classes help the application perform HTTP GET requests from the LibriVox API. The data layer contains the offline database storage that the application will use to store data. The coding language and framework that the program will be using are Dart, Flutter, and Hive.
![Logical Software Architecture Diagram (CST-452 Milestone 6)](https://github.com/Trev017/freeread/assets/90469669/130df454-30cd-4876-9efa-30f133e78737)

## Physical Solution Diagram

The diagram that is provided illustrates the physical solution design of the project. The design depicts the local development environment running the application. The program utilizes Hive as a database to store offline data within the emulator available to the local development environment. It also connects to the LibriVox API to make API GET requests to get all audiobooks in the database’s catalog. The integrated development environments that are utilized for the project’s development are Visual Studio Code, Android SDK, and FlutLab.io. Currently, the individual has no plans on releasing the application to Apple’s App Store, which explains why the application’s physical solution is depicted in a local development environment.
![Physical Solution Architecture Diagram (CST-452 Milestone 6)](https://github.com/Trev017/freeread/assets/90469669/772275e9-0370-4b64-acea-beeeab829ff6)

## Screenshots

The following images display screenshots of the application. The pages that are displayed are the search page, the book information page, the favorites page, and the book reading page.

![Search Page Screenshot (CST-452 Milestone 6)](https://github.com/Trev017/freeread/assets/90469669/f8239fe0-1148-49d2-9ff8-2f8c0b79b9d3)
![Book Information Page Screenshot (CST-452 Milestone 6)](https://github.com/Trev017/freeread/assets/90469669/d8a70488-028f-412a-bbd5-f3c04c7ddeb8)
![Favorites Page Screenshot (CST-452 Milestone 6)](https://github.com/Trev017/freeread/assets/90469669/c381127c-26b9-4f2e-ae48-b67cefac0483)
![Book Reading Page Screenshot (CST-452 Milestone 6)](https://github.com/Trev017/freeread/assets/90469669/4f35a8f5-af63-4a31-aae3-fb0ba2246926)

# Challenges in Development

There are numerous challenges when it comes to developing this project. One constraint the individual had to face is the emulation of iPhone, as Apple does not allow the emulation of their devices. The solution for this problem was to use an online emulator, such as FlutLab.io and Appetize.io. Utilizing these services had some problems, such as the limited number of builds that could be created in a day, preventing constant testing of the application, and obtaining specific files to upload for the emulator.

Another challenged faced during development of the program is the limitations provided by the third-party API. The LibriVox API contains has certain parameters that seemingly only work in one type of query and is limited to what could be searched. This results in some features being unable to be implemented or causing problems in the program itself.
