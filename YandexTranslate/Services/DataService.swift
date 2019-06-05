import CoreData
import UIKit

class DataService {
  let appDelegate = UIApplication.shared.delegate as! AppDelegate

  func save(text: String, lang: String, translate: String) {
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Translation", in: managedContext)!

    let translation = NSManagedObject(entity: entity, insertInto: managedContext)
    translation.setValue(lang, forKey: "lang")
    translation.setValue(text, forKey: "text")
    translation.setValue(translate, forKey: "translate")

    do {
      try managedContext.save()
      print("text saved!")
    } catch let error as NSError {
      print("Could not save. \(error). \(error.userInfo)")
    }
  }

  func fetchTranslations() -> [Translate] {
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Translation")

      let fetchedTranslations = try! managedContext.fetch(fetchRequest)

      var objects = [Translate]()

      for object in fetchedTranslations {
        let text = object.value(forKey: "text") as! String
        let lang = object.value(forKey: "lang") as! String
        let translate = object.value(forKey: "translate") as! String
        let trans = Translate(name: text, translation: translate, lang: lang)
        objects.append(trans)
      }
      return(objects)
  }

  func fetchObjectBy(word: String) -> Translate? {
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Translation")
    fetchRequest.predicate = NSPredicate(format: "text == %@", word)

    guard let fetchedTranslations = try?  managedContext.fetch(fetchRequest) else {
      return nil
    }

    var objects = [Translate]()

    for object in fetchedTranslations {
      let text = object.value(forKey: "text") as! String
      let lang = object.value(forKey: "lang") as! String
      let translate = object.value(forKey: "translate") as! String
      let trans = Translate(name: text, translation: translate, lang: lang)
      objects.append(trans)
    }
    return(objects.first)
  }

}


