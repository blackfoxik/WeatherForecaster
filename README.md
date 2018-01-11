# WeatherForecaster

- built-in cities(through csv file parsing)
- internet connection checking (reachability)
- offline mode supporting (persistent data through CoreData)
- DarkSky API weather provider

| Main screen  | Detail screen |
| ------------- | ------------- |
| <a href="url"><img src="AdditionalFiles/main.png" align="left" height="432" width="244" ></a>  | <a href="url"><img src="AdditionalFiles/detail.png" align="left" height="432" width="244" ></a>  |
|Reachability | Selecting city|
| <a href="url"><img src="AdditionalFiles/reachability.png" align="left" height="432" width="244" ></a>  | <a href="url"><img src="AdditionalFiles/selectingCity.png" align="left" height="432" width="244" ></a> |

app implemented with MVP pattern, for app "as is" enough CocoaMVC, but quite often while app grows CocoaMVC becomes MassiveVC. During implementation, I tried to achieve max flexible (app's modules interact by protocols, dependency injection by setters and constructors) this makes app to be quite redundant but allows to add future functionality and testing in a more convenient way.
