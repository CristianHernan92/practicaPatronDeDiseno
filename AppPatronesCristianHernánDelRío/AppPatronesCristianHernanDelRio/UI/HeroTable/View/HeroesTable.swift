import UIKit

//PROTOCOL
protocol HeroesTableProtocol:AnyObject{
    func reloadData()
    func showHeroDetailTable(data:HeroDetail)
}

final class HeroesTable: UITableViewController {
    //viewModel
    private let viewModel: HeroesTableViewModelProtocol
    
    init(viewModel: HeroesTableViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configurations()
        viewModel.onViewLoaded()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return prepareAndReturnCell(viewModel: viewModel, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRowAt(indexPatch: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height()
    }
    
    private func registerCell(){
        let nib = UINib(nibName: "Cell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    private func configurations(){
        navigationItem.hidesBackButton = true
        navigationItem.title = "Heroes"
    }
    
    private func height() -> CGFloat{
        return 125.0
    }
    
    private func prepareAndReturnCell(viewModel: HeroesTableViewModelProtocol,indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let data = viewModel.elementData(indexPatch: indexPath.row)
        cell.titleOfCell.text = data.name
        cell.descriptionOfCell.text = data.description
        cell.imageOfCell.image = viewModel.elementDataImage(indexPatch: indexPath.row)
        return cell
    }
}

//EXTENSION
extension HeroesTable:HeroesTableProtocol{
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func showHeroDetailTable(data:HeroDetail){
        let heroDetailTable = HeroDetailTable()
        let viewModel = HeroDetailTableViewModel(viewController: heroDetailTable, data: data)
        heroDetailTable.viewModel = viewModel
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(
                heroDetailTable,
                animated: true
            )
        }
    }

}
