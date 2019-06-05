import Foundation

class NetworkService {
  let session = URLSession.shared
  let baseUrlString = "https://translate.yandex.net/api/v1.5/tr.json/translate"
  let personalKey = "trnsl.1.1.20190604T220326Z.59144defd360023f.2603149a5ca4c9b23d70e3d47575b6f30d845cc1"

  func translateText(text:String, lang:String, completion: @escaping (Result<TextResponse, Error>)-> Void) {

    var urlComponents = URLComponents(string: baseUrlString)!
    urlComponents.queryItems = [URLQueryItem(name: "key", value: personalKey),
                      URLQueryItem(name: "text", value: text),
                      URLQueryItem(name: "lang", value: lang),
                      URLQueryItem(name: "format", value: "plain")]

    let request = URLRequest(url: urlComponents.url!)
    let task = session.dataTask(with: request) { data, response, error in

      if let responseError = error {
        completion(Result.failure(error: responseError))
        return
      }

      guard let httpResponse = response as? HTTPURLResponse else {
        completion(Result.failure(error: NetworkError.connectionError))
        return
      }

      guard (200...299).contains(httpResponse.statusCode) else {
        completion(Result.failure(error: NetworkError.getErrorFor(statusCode: httpResponse.statusCode)!))
        return
      }

      guard let recievedData = data else {
        completion(Result.failure(error: NetworkError.invalidData))
        return
      }

      guard let recievedResponse: TextResponse = try? JSONDecoder().decode(TextResponse.self, from: recievedData) else {
        completion(Result.failure(error: NetworkError.couldNotParseJSON))
        return
      }

      completion(Result.success(result: recievedResponse))
    }

    task.resume()
  }

}
