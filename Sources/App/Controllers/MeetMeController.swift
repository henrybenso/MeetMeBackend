import Fluent
import Vapor

struct MeetMeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: index)
        users.post(use: create)
        users.group(":id") { item in
            item.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [MeetMeUser] {
        try await MeetMeUser.query(on: req.db).all()
    }

    func create(req: Request) async throws -> MeetMeUser {
        let user = try req.content.decode(MeetMeUser.self)
        try await user.save(on: req.db)
        return user
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let user = try await MeetMeUser.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return .noContent
    }
}
