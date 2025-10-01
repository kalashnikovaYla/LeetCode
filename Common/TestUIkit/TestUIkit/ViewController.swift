//
//  ViewController.swift
//  TestUIkit
//
//  Created by Юлия Калашникова on 01.10.2025.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - Layer
    func testLayer() {
        var view1 = UIView(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        view1.backgroundColor = .red
        view.addSubview(view1)
        
         let view2 = UIView()
         view2.backgroundColor = .green
         view2.frame = view1.bounds
         view1.addSubview(view2)
         
         let layer = CALayer()
         layer.frame = view1.bounds
         layer.backgroundColor = UIColor.blue.cgColor
         view1.layer.addSublayer(layer)
        
        //будет голубой по итогу
        /*
         На этом этапе, в iOS у `UIView` есть свойство `layer`, которое управляет отрисовкой этой представления. Когда вы добавляете сабслой (`addSublayer`) к `view1.layer`, вы добавляете новый слой, начиная сверху.

         */
    }
    
    func testLayer2() {
        let view1 = UIView()
        view1.frame = view.bounds
        view1.backgroundColor = UIColor.green
        view1.layer.backgroundColor = UIColor.red.cgColor
        
        view.addSubview(view1)
        /*
         1) будет красный
         view1.backgroundColor = UIColor.green
         view1.layer.backgroundColor = UIColor.red.cgColor
         
         2) будет зеленый
         view1.layer.backgroundColor = UIColor.red.cgColor
         view1.backgroundColor = UIColor.green
         
         - Когда вы явно задаете `view1.backgroundColor`, это устанавливает `view1.layer.backgroundColor` и также влияет на отображение.
         - Однако, если впоследствии вы напрямую устанавливаете `view1.layer.backgroundColor`, она переопределяет эффект `backgroundColor`.

         */
    }
    
    
    //MARK: - Offset
    func testOffset() {
        let view1 = UIView()
        view1.frame = view.bounds
        view1.layer.backgroundColor = UIColor.red.cgColor
        
        view.addSubview(view1)
        view1.frame.origin.y += 100 //сьедит вниз на 100
    }
    
    
    func testOffset2() {
        let view1 = UIView()
        view1.frame = view.bounds
        view1.layer.backgroundColor = UIColor.red.cgColor
        
        view.addSubview(view1)
        view1.frame.origin.y -= 100 //сьедит вверх на 100 (для клавы такое делали раньше)
    }
}


 
//MARK: - Hit test
extension UIView {
    
    func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled, !isHidden, alpha > 0.01 else {
            return nil
        }
        
        if self.point(inside: point, with: event) {
            for subview in self.subviews.reversed() {
                let convertedPoint = subview.convert(point, from: self)
                if let hitView = subview.hitTest(convertedPoint, with: event) {
                    return hitView
                }
            }
           
            return self
        }

        return nil
    }
}

/*
 В SwiftUI системе для обработки нажатий и взаимодействий используются механизмы, основанные на модификаторах и событиях, таких как `.onTapGesture`, `.gesture()`, и тому подобных. В отличие от UIKit, где используется метод `hitTest(_:with:)` для определения, на какое представление было нажато, в SwiftUI взаимодействия работают через декларативные указания.
 Как SwiftUI понимает, что на нее нажали:

 1. Модификаторы взаимодействия:
    Вы добавляете к вашему представлению модификаторы, например `.onTapGesture` или `.gesture()`, чтобы реагировать на касания.

 2. Обнаружение касания:
    Когда пользователь нажимает на представление, SwiftUI инициирует систему распознавания жестов.
    - Модификаторы жестов добавляют к представлениям системы, отвечающей за распознавание касаний, их "области" и правил.

 */


//MARK: - Point override
class EnlargedButton: UIButton {
    
    var hitTestEdgeInsets = UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20)

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let relativeFrame = self.bounds
        let hitFrame = relativeFrame.inset(by: UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20))
        return hitFrame.contains(point)
    }
}


//MARK: ARC
class Network {
    var onLoad: ((String) -> ())?
}

/*
 
 class ViewController2: UIViewController {
     weak var label: UILabel?
     weak var arr: [UIView]? //'weak' may only be applied to class and class-bound protocol types, not '[UIView]'
     unowned var client = Network() //Instance will be immediately deallocated because property 'client' is 'unowned'
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         label = UILabel(frame: .zero) //Instance will be immediately deallocated because property 'client' is 'unowned'
         label?.text = "text"
         view.addSubview(label!)
         
         DispatchQueue.global().async {
             self.client.onLoad = { val in
                 self.label?.text = val
             }
         }
     }
 }
 */
//Желтый варнинг не обязательный к устранению
class ViewController: UIViewController {
    var label: UILabel?
    var arr: [UIView]? //'weak' may only be applied to class and class-bound protocol types, not '[UIView]' -  weak var arr: [UIView]?
    var client = Network() ///Instance will be immediately deallocated because property 'client' is 'unowned'
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel(frame: .zero) ///Instance will be immediately deallocated because property 'client' is 'unowned'
        label?.text = "text"
        view.addSubview(label!) //краш если weak
        
        DispatchQueue.global().async {
            self.client.onLoad = { val in
                DispatchQueue.main.async {
                    self.label?.text = val
                }
            }
        }
    }
}
