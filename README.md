# SimpleWeather iOS
A simple weather application built from the ground up with the following primary functions:
- View list of saved cities (with current weather for each)
- Ability to add / remove a city from the list
- Ability to view further details of the cities weather
- Should retain preferences after close by caching

A connection to a GraphQL API is leveraged to gather weather information.

### Architecture
The architecture I adopted is very conventional. Typically I'm more inclined towards reactive, 
declarative MVVM style patterns however imperative MVC is the most traditional on iOS. 

Apollo generates the model layer, and on top of that you'll find standard view controllers,
managers (also considered controllers), views and swift extensions.

MapKit is leveraged for autocompletion of search locations.

### Security
There's no authentication because the weather API is public. If I did have to store a token or any API secrets 
I would store them in the iOS Keychain and/or Secure Enclave. Even a third party service would be acceptable.
As long as the token or keys are stored outside of the app bundle so that they aren't compromised by decompilation.

https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_secure_enclave

Obfuscation tools could also be leveraged to make decompilation more difficult.

Additionally, what might be worth doing is encrypting the SQLite database which serves as the store for the GraphQL cache.

What I did manage to accomplish on the security side, though minor but also improves performance as a side effect, 
is building the project's pods as static libraries. This locks function implementations at compile time preventing any data 
from being intercepted or functionality from being swapped out from the intended library at runtime (method swizzling).

https://way2security4u.blogspot.com/2013/08/ios-application-security-part-8-method.html

### Responsive Design
...

### Performance
...
