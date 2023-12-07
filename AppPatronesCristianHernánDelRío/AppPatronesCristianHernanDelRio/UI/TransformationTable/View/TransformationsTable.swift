import UIKit

//PROTOCOL
protocol TransformationsTableProtocol{
    func reloadData()
    func showTransformationDetailTable(data: TransformationDetail)
}

final class TransformationsTable: UITableViewController {
    //viewModel
    var viewModel: TransformationsTableViewModelProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configurations()
        viewModel?.onViewLoaded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.dataCount() ?? 0
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
        navigationItem.title = "Transformations"
    }
    
    private func prepareAndReturnCell(indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        if let data = self.viewModel?.getCellData(indexPatch: indexPath.row){
            cell.titleOfCell.text = data.name
            cell.descriptionOfCell.text = data.description
            cell.imageOfCell.image = data.image
        }
        else{
            cell.titleOfCell.text = ""
            cell.descriptionOfCell.text = ""
            cell.imageOfCell.image = UIImage()
        }
        return cell
    }
    
    private func height() -> CGFloat{
        return 125.0
    }
}

//EXTENSION
extension TransformationsTable:TransformationsTableProtocol{
    func reloadData() {
        self.tableView.reloadData()
    }
    func showTransformationDetailTable(data: TransformationDetail){
        DispatchQueue.main.async {
            self.navigationController?.showTransformationDetailTable(with: data)
        }
    }
}
