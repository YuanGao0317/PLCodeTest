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
  |- PLConstants  I put all the constants here.
  
- Model
  |- PLBook   The book model structure is defined here. I also developed a PLValidator enum in the concerns folder, which is for attributes validation. I think it is better to move the validations into models rather than controllers or views which should only get and present the errors.

## CocoaPods
