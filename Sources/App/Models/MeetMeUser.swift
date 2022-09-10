import Fluent
import Vapor

enum Gender: String, Codable {
    case male, female
}

enum Religion: String, Codable {
    case agnostic, christian, buddhist, none
}

enum Orientation: String, Codable {
    case men, women, everyone
}

final class MeetMeUser: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "first_name")
    var firstName: String
    
    @Field(key: "last_name")
    var lastName: String
    
//    @Field(key: "birth_date")
//    var birthDate: Date
    
    @Field(key: "birth_date")
    var birthDate: Date?
    
    @Field(key: "age")
    var age: Int
    
    @Enum(key: "gender_type")
    var genderType: Gender
    
    @OptionalEnum(key: "religion_type")
    var religionType: Religion?
    
    @OptionalEnum(key: "orientation_type")
    var orientationType: Orientation?
    
    @OptionalField(key: "smoke")
    var smoke: Bool?
    
    @OptionalField(key: "marijuana")
    var marijuana: Bool?
    
    @OptionalField(key: "alcohol")
    var alcohol: Bool?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
 
    @Field(key: "image_one")
    var imageOne: Data
    
    @Field(key: "image_two")
    var imageTwo: Data
    
    @Field(key: "image_three")
    var imageThree: Data
    
    @Field(key: "image_four")
    var imageFour: Data
    
    @Field(key: "image_five")
    var imageFive: Data
    
    @Field(key: "image_six")
    var imageSix: Data
     
    init() { }

    init(id: UUID? = nil, email: String, firstName: String, lastName: String, birthDate: Date?, age: Int, genderType: Gender, religionType: Religion? = nil, orientationType: Orientation? = nil, smoke: Bool? = nil, marijuana: Bool? = nil, alcohol: Bool? = nil, createdAt: Date? = nil, updatedAt: Date? = nil, imageOne: Data, imageTwo: Data, imageThree: Data, imageFour: Data, imageFive: Data, imageSix: Data) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.age = age
        self.genderType = genderType
        self.religionType = religionType
        self.orientationType = orientationType
        self.smoke = smoke
        self.marijuana = marijuana
        self.alcohol = alcohol
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.imageOne = imageOne
        self.imageOne = imageTwo
        self.imageThree = imageThree
        self.imageFour = imageFour
        self.imageFive = imageFive
        self.imageSix = imageSix
    }
}
 

/*
struct MeetMeMiddleware: ModelMiddleware {
    func create(model: MeetMeUser, on db: Database, next: AnyModelResponder) async throws {
        model.name = model.name.capitalized()
        try await next.create(model, on: db)
        
        print("MeetMeUser \(model.name) was created")
    }
    
    func update(model: MeetMe, on db: Database, next: AnyModelResponder) async throws {
        guard let user = try await User.find(model.name)
    }
}
*/
