import UIKit
import CoreData

class EditViewController: UIViewController {
    
    // TextFieldを用意
    var memoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyanColor()
        self.title = "Edit"
        
        // text field
        memoField = UITextField(frame: CGRectMake(100, 100, 200, 30))
        memoField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(memoField)
        
        // write button
        let writeBtn: UIButton = UIButton(frame: CGRectMake(100, 150, 200, 30))
        writeBtn.backgroundColor = UIColor.magentaColor()
        writeBtn.setTitle("メモを保存", forState: UIControlState.Normal)
        writeBtn.addTarget(self, action: "writeData", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(writeBtn)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // CoreDataへの書き込み処理（writeBtnのアクション）
    func writeData() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let toDoContext: NSManagedObjectContext = appDel.managedObjectContext
        let toDoEntity: NSEntityDescription! = NSEntityDescription.entityForName("ToDoStore", inManagedObjectContext: toDoContext)
        let newData = ToDoStore(entity: toDoEntity, insertIntoManagedObjectContext: toDoContext)
        newData.memo = memoField.text!
        newData.date = NSDate()
        print(newData)
    }
}