import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let users = app.grouped("users")
    
    
    struct User: Content {
        var id: UUID?
        var email: String
        var firstName: String
        var lastName: String
//        var birthDate: Date
        var birthDate: Date?
        var age: Int
        var genderType: Gender
        var religionType: Religion?
        var orientationType: Orientation?
        var smoke: Bool?
        var marijuana: Bool?
        var alcohol: Bool?
        var createdAt: Date?
        var updatedAt: Date?
        
        var imageOne: Data
        var imageTwo: Data
        var imageThree: Data
        var imageFour: Data
        var imageFive: Data
        var imageSix: Data
        
    }
    
    
    // GET REQUEST TO RETRIEVE ALL USERS
    users.get { req async throws -> [MeetMeUser] in
        let users = try await MeetMeUser.query(on: req.db).all()
        return try users.map { user in
            try MeetMeUser(
                id: user.requireID(),
                email: user.email,
                firstName: user.firstName,
                lastName: user.lastName,
                birthDate: user.birthDate,
                age: user.age,
                genderType: user.genderType,
                religionType: user.religionType,
                orientationType: user.orientationType,
                smoke: user.smoke,
                marijuana: user.marijuana,
                alcohol: user.alcohol,
                createdAt: user.createdAt,
                updatedAt: user.updatedAt,
                imageOne: user.imageOne,
                imageTwo: user.imageTwo,
                imageThree: user.imageThree,
                imageFour: user.imageFour,
                imageFive: user.imageFive,
                imageSix: user.imageSix
                )
        }
    }
    
    

    
    
    
    struct userID: Content {
        var userID: UUID?
    }
    
    // GET REQUEST TO RETRIEVE SINGLE USER
    users.get(":id") { req async throws -> [MeetMeUser] in
        guard let userID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let user = MeetMeUser.query(on: req.db).filter(\.$id == userID)
        
        return try await user.all()
        
    }
    
    // POST REQUEST TO ADD USER
    users.post { req async throws -> MeetMeUser in
        let user = try req.content.decode(MeetMeUser.self)
        // Writes buffer to file.
        //try await req.fileio.writeFile(ByteBuffer(string: "Hello, world"), at: "/Users/henrybenso/Documents/MeetMe/Public")
        try await user.create(on: req.db)

        print("user post success")
        return user
    }
    
    struct PatchUser: Decodable {
        var firstName: String?
        var lastName: String?
        var genderType: Gender?
        var religionType: Religion?
        var orientationType: Orientation?
        var smoke: Bool?
        var marijuana: Bool?
        var alcohol: Bool?
    }
    
    // PATCH REQUEST TO UPDATE USER
    users.patch(":id") { req async throws -> MeetMeUser in
        let patch = try req.content.decode(PatchUser.self)
        
        guard let user = try await MeetMeUser.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        if let firstName = patch.firstName {
            user.firstName = firstName
        }
        
        if let lastName = patch.lastName {
            user.lastName = lastName
        }
        
        if let genderType = patch.genderType {
            user.genderType = genderType
        }
        
        if let religionType = patch.religionType {
            user.religionType = religionType
        }
        
        if let orientationType = patch.orientationType {
            user.orientationType = orientationType
        }
        
        if let smoke = patch.smoke {
            user.smoke = smoke
        }
        
        if let marijuana = patch.marijuana {
            user.marijuana = marijuana
        }
        
        if let alcohol = patch.alcohol {
            user.alcohol = alcohol
        }
        
        try await user.save(on: req.db)
        return user
        
    }
    
    // DELETE REQUEST TO DELETE USER
    users.delete(":id") { req async throws -> HTTPStatus in
        guard let user = try await MeetMeUser.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        print("Successfully deleted user")
        
        return HTTPStatus.ok
    }
    
    
    
    
    
    //try app.register(collection: MeetMeController())
}

extension MeetMeUser: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email, customFailureDescription: "Provided email is not valid!")
        validations.add("first_name", as: String.self, is: .alphanumeric, customFailureDescription: "Provided first name is not valid!")
        validations.add("last_name", as: String.self, is: .alphanumeric, customFailureDescription: "Provided last name is not valid!")
        validations.add("age", as: Int.self, is: .range(18...), customFailureDescription: "You must be 18 or older to use this app.")
    }
}
