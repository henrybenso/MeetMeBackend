import Fluent

struct CreateMeetMeUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("email", .string, .required)
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
            //.field("birth_date", .date, .required)
            .field("birth_date", .datetime)
            .field("age", .int, .required)
            .field("gender_type", .string, .required)
            .field("religion_type", .string)
            .field("orientation_type", .string)
            .field("smoke", .bool)
            .field("marijuana", .bool)
            .field("alcohol", .bool)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("image_one", .data, .required)
            .field("image_two", .data, .required)
            .field("image_three", .data, .required)
            .field("image_four", .data, .required)
            .field("image_five", .data, .required)
            .field("image_six", .data, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
