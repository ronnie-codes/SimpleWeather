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
from being intercepted or functionality from being swapped out at runtime (method swizzling).

https://way2security4u.blogspot.com/2013/08/ios-application-security-part-8-method.html

### Responsive Design (UI)
Layout is responsive to all device sizes. Appearance is responsive to both dark and light modes. Units of measurement are responsive to locale. Depending on the region you'll see either metric or imperial units and their appropriate formats. None of this is hard coded either. System formatters are leveraged for this localization. The infrastructure for language localization has also been set.

I've built apps that support every iPhone and iPad in every orientation and in every country and time zone in the world and all the best practices and standard conventions were employed to get this app going in that direction.

### Performance
Building our pods as static libraries is worth mentioning as a performance boost to the runtime. There are also some imperfections / inefficiences in the app that are worth mentioning. The entire set of saved locations is being read into memory and written back to disk for every operation. It would be more optimal to work with a single location at a time but right now all locations are tied to the same key in UserDefaults. See DataManager.swift.
