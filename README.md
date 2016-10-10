# PLCodeTest
PL Code Test


## Implementation Details
- Utils

  |- PLError
    - Here is where I define the error types. I used PLResult<T> to handle the asynchronous errors, and use its resolve() function to throw errors in order to move the error checking logic to the error file rather than controllers.
    
  |- PLAPIService
    - I created a protocol for the purpose of dependency injection which is good for testing and extending in the future. Also, it helps me to orgnize the my functions.
  
  |- MessageController
    - I used POP concept to implement this function. It might be easier to extend its functionalities.
    
- Constants
  |- PLConstants  
    - I put all the constants here.
  
- Model
  |- PLBook   
    - The book model structure is defined here. I also developed a PLValidator enum in the concerns folder, which is for attributes validation. I think it is better to move the validations into models rather than controllers or views which should only get and present the errors.
  
- Controllers
  |- Main
    |- PLMainViewController   
      -This is the main view controller with a table view. I moved the table view's dataSource and delegate into its extension. I am able to delete all books, add a book, and delete one book by sliding to left.
    
  |- PLAddBookViewController
    - I can create a book in this view controller. I developed the form as a partial view in Components folder for the purpose of reusing and making its controller lighter. I also can move the creating function into the form view in order to let the form communicate with the back-end server like VM in MVVM, but I did not because this is a small project. So just leave this creating function in the controller first to make a clean MVC.
    
  |- PLBookDetailViewController
    - Here shows a book details, and I can share the book using the built-in sharing dialogue. I developed the form as a partial view in Components folder as well to make a clean controller.
    
    
    
    
    
    
## CocoaPods
