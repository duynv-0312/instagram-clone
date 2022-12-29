//
//  StorageManager.swift
//  Instagram
//
//  Created by Duy Nguyễn on 19/11/2022.
//
import FirebaseStorage
import Foundation

public class StorageManager {
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: {url, error in
            guard  let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
    
    public enum UserPostType {
        case photo, video
    }
    
    public struct UserPost {
        let postType: UserPostType
        let thumbnailImage: URL
        let postURl: URL //either video url or full resolution photo
        let caption: String?
        let likeCount: [PostLikes]
        let comments: [PostComment]
        let createdDate: Date
    }
    
    struct PostLikes {
        let username: String
        let postIdentifier: String
    }
   
    struct CommentLikes {
        let username: String
        let commentdentifier: String
    }
    
    struct PostComment {
        let username: String
        let text: String
        let createdDate: Date
        let likes: [CommentLikes]
    }
}
