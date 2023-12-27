//
//  PathDataModel.swift
//  AdventOfCode2023Day8
//
//  Created by Robert Faist on 12/23/23.
//

import Foundation

struct MapPaths: Codable {
    let left: String
    let right: String
}

struct Path: Codable {
    let path: String
    let connections: [String]
}

struct PathDataModel: Codable {
    let directions: [String]
    let paths: [String: MapPaths]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let allDirections = try container.decode(String.self, forKey: .directions)
        self.directions = allDirections.split(separator: "").map({ String($0) })
        let jsonpaths = try container.decode([Path].self, forKey: .paths)
        var pathsDecoded: [String: MapPaths] = [:]
        jsonpaths.forEach { path in
            pathsDecoded[path.path] = MapPaths(left: path.connections[0],
                                              right: path.connections[1])
        }
        self.paths = pathsDecoded
    }
}
