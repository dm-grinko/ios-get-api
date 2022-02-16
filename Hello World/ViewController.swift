import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://raw.githubusercontent.com/dm-grinko/api/main/data.json"
        getData(from: url)
    }

    private func getData (from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print ("Something went wrong")
                return
            }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print ("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.name)
            print(json.age)
        })
        
        task.resume()
    }

}

struct Response: Codable {
    let name: String
    let age: Int
}

