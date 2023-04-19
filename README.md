# DutchRijksmuseumAPIClient
This is a test for AH selection process from Alejandro Fernández Ruiz.

# DutchRijksmuseumAPIClient#

[![N|Solid](https://www.rijksmuseum.nl/assets/e1991007-a928-4a3e-895a-fff45844a8d0?w=1920&h=984&fx=1920&fy=1080&format=webp&c=61ed0e055644c86cf8ca68ca5f93b85a6a3b6a9e47babd17b06ecfbdabfe2387)](https://www.rijksmuseum.nl/en)


### What is this repository for?

* This is a test for AH selection process from Alejandro Fernández Ruiz.

* Project has been written on XCode 14.2 and Swift 5 

#### Configuration
* The project should be stand-alone and running on a simulator must be enough.

#### Dependencies
* I prefer to not include third party libraries if possible, if not, the dependencies should be handle by the Swift Package Manager (SPM).
* I have used swiftlint as code linter, but installed it on my laptop and run it using the script provided by the creators in the Build Phases of the project.

#### How to run tests
* The unit tests have been developed with the XCTest library so they must be run using XCode.
* Comments about the tests: 
    *  I have basically focused on the Interactors and Presenters tests, although I have run some ViewController tests. 
This is because these are the classes that should contain the business logic and above all the ones that should be accessible for unit testing.
    * Currently the coverage is around 60%, if I wanted to increase or make more robust tests I would take as a strategy to run tests modifying the current Spy.
    * Example, AppServicesSpy, is a class that provides the results of api requests, currently we only have that one and it returns empty strings or simple inizialized data. To increase the quality of the tests we should have AppServiceNilSpy that returns one or both values as null, AppServiceFullSpy that returns consistent data for each response and AppServiceErrorSpy that would return an error for each request.

#### Dessign pattern.
I have used it as a VIP design pattern, the idea is that each scene of the application is able to implement 3 classes with which to develop all its functions.
V (View): All the functionalities related to the view as well as all the design and components.
I (Interactor): Executes the business logic, uses other layers (Service Layer, Data Layer) and sends the obtained data to the presenter.
P (Presenter): Collects the data from the Interactor, and processes them so that the view obtains the data that must be shown at each moment, any change that is desired to be made on the view must be processed by the presenter.

### App use
The app consists of two scenes.

The initial scene is where you can access the collection. The downloading of artworks is done in steps.
Initially the first page of artworks is loaded, if we scroll through the collection view, we can reach the end of the first page, getting a new request for the next page, which will be added to the list that we already had, and so on for the following scrolls.
With each scroll a new section is created, with its header that should tell us to which page the list of images belongs.
In each cell we see an image related to the artwork in question with the title on a translucent view, the idea is to show the white text on any background (light or dark) and to make it legible.

By tapping on any of the cells, we can go to the detail view, where we see the image of the artwork, as well as the title in the navigation bar, the author and the description of the artwork.
If the description is too long, the screen should scroll the text keeping the image still, because I think the focus should be on the image of the artwork.

### Error handling
To handle the errors I have made use of the NSError class.
This class allows me, through two keys, to include an error message and a title to provide it to the user through a UIAlertView (other methods could be snackbar, or globe message)

Error control is in two phases:
* service errors. In the ServiceNetworkSession class I perform the URLSession asynchronous task to get the response from a generic API.
If all goes well, the system should be able to download and parse it from JSON to Model objects and function normally. In case the answers are different from 200 I have created two possible controls, all the values between 400 and 499 will generate an error, while the errors from 500 to 599 will give us another different error.
We could go into much more detail on this, or instead of focusing on the http error returned by the server, try to parse an object with the error data, but I think it's enough for such a small project.

* Local errors, in the AppServices classes, I have implemented an error control at the JSON parsing level, we expect a JSON text if it's not, it will return an error that will be displayed to the user with a NSError.

### How to improve this project
If I have extra time for this project I would like to improve:
* Work on the unit test. From my point of view you have to make them more robust and if possible more extensive but always making emphasis in the different cases
* Use components for the UI: Each element must be componentized if the project were more extensive. Labels, uitexfields, must be created in independent reusable and preconfigured classes
* Reachability: Offline user scenario should be handled
