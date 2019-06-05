import Foundation

enum Result<TResult, TError> {
  case success(result: TResult)
  case failure(error: TError)
}
