import UIKit

//PROTOCOL
protocol HeroesTableProtocol{
    func reloadData()
    func showHeroDetailTable(data:HeroDetail)
}

final class HeroesTable: UITableViewController {
    //viewModel
    var viewModel: HeroesTableViewModelProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configurations()
        viewModel?.onViewLoaded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = prepareAndReturnCell(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectRowAt(indexPatch: indexPath.row)
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
    
    private func prepareAndReturnCell(indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        if let data = viewModel?.getCellData(indexPatch: indexPath.row){
            cell.titleOfCell.text = data.name
            cell.descriptionOfCell.text = data.description
            cell.imageOfCell.image = data.image
        }else{
            cell.titleOfCell.text = ""
            cell.descriptionOfCell.text = ""
            cell.imageOfCell.image = UIImage()
        }
        return cell
    }
}

//EXTENSION
extension HeroesTable:HeroesTableProtocol{
    func reloadData() {
        self.tableView.reloadData()
    }
    func showHeroDetailTable(data:HeroDetail){
        DispatchQueue.main.async {
            self.navigationController?.showHeroDetailTable(with: data)
        }
    }
}
