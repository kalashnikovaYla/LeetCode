//
//  ViewController.swift
//  TestUIkit
//
//  Created by Юлия Калашникова on 01.10.2025.
//

import UIKit

final class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testIsMainThread()
    }

    func testIsMainThread() {
        //true
        ///Task { ... }` по умолчанию наследует контекст и приоритет вызывающего потока, обычно это главный поток, если вызов сделал UI-элемент. Поэтому внутри такого блока `Thread.isMainThread` часто возвращает `true`.
        Task {
            print("Is Main Thread - \(Thread.isMainThread)")
            await foo()
            print("Is Main Thread - \(Thread.isMainThread)")
        }

        ///Этот вызов создает новую задачу, которая не связана с текущим контекстом выполнения или с текущим потокам. Поэтому она может быть запущена на глобальном фоновом потоке или очереди, которая не является главным интерфейсным потоком.
        Task.detached {
            print("Is Main Thread - \(Thread.isMainThread)")
            await self.foo()
            print("Is Main Thread - \(Thread.isMainThread)")
            
            /*
             Is Main Thread - false
             Is Main Thread - true
             Is Main Thread - false
             */
        }
    }
    
    func foo() async {
        print("Is Main Thread - \(Thread.isMainThread)")
        try? await Task.sleep(for: .seconds(1))
    }
}


class ViewController: UIViewController {

    var isShow = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //testFriz()
        //testFriz2()
        testFriz3()
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
    
    func testFriz(){
        if !isShow {
            isShow = true
            self.navigationController?.pushViewController(TaskExampleViewController(), animated: true)
        }
    }
    
    func testFriz2(){
        if !isShow {
            isShow = true
            self.navigationController?.pushViewController(TaskExampleViewController2(), animated: true)
        }
    }
    
    func testFriz3(){
        if !isShow {
            isShow = true
            self.navigationController?.pushViewController(TaskExampleViewController3(), animated: true)
        }
    }
}


 
//MARK: - Hit test
extension UIView {
    
    ///convert - Переводит точку касания из системы координат `self` в систему координат конкретного `subview`. Это необходимо, чтобы проверить попадание для каждого подвида в их локальных координатах.
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


extension UIView {
    func findFirstResponder(in view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.isFirstResponder {
                return subview
            }
            if let responder = findFirstResponder(in: subview) {
                return responder
            }
        }
        return nil
    }
}


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
class ViewController1: UIViewController {
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



final class TaskExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        print("TaskExampleViewController", #function)
        doHardWork()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TaskExampleViewController", #function)
    }

    deinit {
        print("TaskExampleViewController", #function)
    }

    private func doHardWork() {
        Task {
            var array = [Int]()
            (0...100_000_000).forEach {
                array.append($0)
            }
            print(array.count)
        }
    }
}

///2 решения:
///- вынести в отдельный класс
///- сделать Task.detached {}
final class HardWorkService {
    func doHardWork() {
        Task {
            var array = [Int]()
            (0...100_000_000).forEach {
                array.append($0)
            }
            print(array.count)
        }
    }
}

final class TaskExampleViewController2: UIViewController {
    
    let service = HardWorkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        print("TaskExampleViewController", #function)
        doHardWork()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TaskExampleViewController", #function)
    }
    
    deinit {
        print("TaskExampleViewController", #function)
    }
    
    private func doHardWork() {
        /// Здесь главный контекст, но когда мы обращаемся к сервису
        /// и переходим в его для исполнения кода, то код метода уже будет
        /// иметь исполнителя класса
        service.doHardWork()
    }
}

final class TaskExampleViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        print("TaskExampleViewController", #function)
        doHardWork()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TaskExampleViewController", #function)
    }

    deinit {
        print("TaskExampleViewController", #function)
    }

    private func doHardWork() {
        Task.detached {
            var array = [Int]()
            (0...100_000_000).forEach {
                array.append($0)
            }
            print(array.count)
        }
    }
}
