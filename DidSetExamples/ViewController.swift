//
//  ViewController.swift
//  DidSetExamples
//
//  Created by daanff on 2021-09-30.
//https://www.youtube.com/watch?v=MyYV65boqec  with problems

import UIKit

class Observer<T> {
    var value: T?{
        didSet{
          observerBlock?(value)
        }
    }
    
    init(value: T?){
        self.value = value
    }
    
    required init(){
        fatalError()
    }
    
    private var observerBlock:((T?) -> Void)?
    
    func add(_ observer: @escaping(T?) -> Void){
        self.observerBlock = observer
    }
}


class ViewController: UIViewController ,UITableViewDataSource{
    private var fruits = Observer(value: ["Apple", "Oranges", "Grapes"])
    
    private let table: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let custom = CustomLabelView()
//        custom.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//        custom.center = view.center
//        view.addSubview(custom)
//        let more = ["watermelon", "cherry", "Peaches"]
//        for x in 0..<100{
//        DispatchQueue.main.asyncAfter(deadline: .now() + (1 * TimeInterval(x))){
//            custom.score = more.randomElement() ?? "Something"
//        }
//        }
        
        view.addSubview(table)
        table.frame = view.bounds
        table.dataSource = self
        
        fruits.add{[weak self] fruits in
            print("updated fruits: \(fruits ?? [])\n\n")

            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }

        let more = ["watermelon", "cherry", "Peaches"]
        for x in 0..<100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (1 * TimeInterval(x))){
                self.fruits.value?.append(more.randomElement() ?? "Something else")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fruits.value?[indexPath.row]
        return cell
    }
}

