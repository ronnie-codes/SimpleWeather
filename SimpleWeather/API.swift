// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CityDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query CityDetails($name: String!) {
      getCityByName(name: $name) {
        __typename
        name
        weather {
          __typename
          summary {
            __typename
            title
            description
          }
          temperature {
            __typename
            actual
            feelsLike
          }
          clouds {
            __typename
            visibility
            humidity
          }
          wind {
            __typename
            speed
            deg
          }
        }
      }
    }
    """

  public let operationName: String = "CityDetails"

  public var name: String

  public init(name: String) {
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getCityByName", arguments: ["name": GraphQLVariable("name")], type: .object(GetCityByName.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getCityByName: GetCityByName? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getCityByName": getCityByName.flatMap { (value: GetCityByName) -> ResultMap in value.resultMap }])
    }

    public var getCityByName: GetCityByName? {
      get {
        return (resultMap["getCityByName"] as? ResultMap).flatMap { GetCityByName(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getCityByName")
      }
    }

    public struct GetCityByName: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["City"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("weather", type: .object(Weather.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, weather: Weather? = nil) {
        self.init(unsafeResultMap: ["__typename": "City", "name": name, "weather": weather.flatMap { (value: Weather) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var weather: Weather? {
        get {
          return (resultMap["weather"] as? ResultMap).flatMap { Weather(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "weather")
        }
      }

      public struct Weather: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Weather"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("summary", type: .object(Summary.selections)),
            GraphQLField("temperature", type: .object(Temperature.selections)),
            GraphQLField("clouds", type: .object(Cloud.selections)),
            GraphQLField("wind", type: .object(Wind.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(summary: Summary? = nil, temperature: Temperature? = nil, clouds: Cloud? = nil, wind: Wind? = nil) {
          self.init(unsafeResultMap: ["__typename": "Weather", "summary": summary.flatMap { (value: Summary) -> ResultMap in value.resultMap }, "temperature": temperature.flatMap { (value: Temperature) -> ResultMap in value.resultMap }, "clouds": clouds.flatMap { (value: Cloud) -> ResultMap in value.resultMap }, "wind": wind.flatMap { (value: Wind) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var summary: Summary? {
          get {
            return (resultMap["summary"] as? ResultMap).flatMap { Summary(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "summary")
          }
        }

        public var temperature: Temperature? {
          get {
            return (resultMap["temperature"] as? ResultMap).flatMap { Temperature(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "temperature")
          }
        }

        public var clouds: Cloud? {
          get {
            return (resultMap["clouds"] as? ResultMap).flatMap { Cloud(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "clouds")
          }
        }

        public var wind: Wind? {
          get {
            return (resultMap["wind"] as? ResultMap).flatMap { Wind(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "wind")
          }
        }

        public struct Summary: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Summary"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("description", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(title: String? = nil, description: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Summary", "title": title, "description": description])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }
        }

        public struct Temperature: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Temperature"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("actual", type: .scalar(Double.self)),
              GraphQLField("feelsLike", type: .scalar(Double.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(actual: Double? = nil, feelsLike: Double? = nil) {
            self.init(unsafeResultMap: ["__typename": "Temperature", "actual": actual, "feelsLike": feelsLike])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var actual: Double? {
            get {
              return resultMap["actual"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "actual")
            }
          }

          public var feelsLike: Double? {
            get {
              return resultMap["feelsLike"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "feelsLike")
            }
          }
        }

        public struct Cloud: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Clouds"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("visibility", type: .scalar(Int.self)),
              GraphQLField("humidity", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(visibility: Int? = nil, humidity: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Clouds", "visibility": visibility, "humidity": humidity])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var visibility: Int? {
            get {
              return resultMap["visibility"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "visibility")
            }
          }

          public var humidity: Int? {
            get {
              return resultMap["humidity"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "humidity")
            }
          }
        }

        public struct Wind: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Wind"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("speed", type: .scalar(Double.self)),
              GraphQLField("deg", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(speed: Double? = nil, deg: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Wind", "speed": speed, "deg": deg])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var speed: Double? {
            get {
              return resultMap["speed"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "speed")
            }
          }

          public var deg: Int? {
            get {
              return resultMap["deg"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "deg")
            }
          }
        }
      }
    }
  }
}
