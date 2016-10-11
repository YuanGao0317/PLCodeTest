## How to use
- change server attribute to http://localhost:3000 in iOS PLConstants of |-Constants folder.
- Also you need to change the iOS lastCheckedOut format to dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz" in |-Controllers |-BookDetail |-concerns PLDateFormatter function: func formatted(from string: String) -> String.
- In terminal, get to local-api-backend directory, run: 'bundle'
- Then run: 'rails s' to start the api server
