import UIKit

//PROTOCOL
protocol TransformationsTableProtocol:AnyObject{
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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel{
            return viewModel.dataCount
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel{
            return prepareAndReturnCell(viewModel: viewModel,indexPath: indexPath)
        }else{
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel{
            viewModel.selectRowAt(indexPatch: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height()
    }
    
    private func registerCell(){
        let nib = UINib(nibName: "Cell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    private func configurations(){
        navigationItem.title = "Transformations"
    }
    
    private func prepareAndReturnCell(viewModel: TransformationsTableViewModelProtocol, indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let data = viewModel.elementData(indexPatch: indexPath.row)
        cell.titleOfCell.text = data.name
        cell.descriptionOfCell.text = data.description
        cell.imageOfCell.image = viewModel.elementDataImage(indexPatch: indexPath.row)
        return cell
    }
    
    private func height() -> CGFloat{
        return 125.0
    }
}

//EXTENSION
extension TransformationsTable:TransformationsTableProtocol{
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func showTransformationDetailTable(data: TransformationDetail){
        DispatchQueue.main.async {
            let transformationDetailTable = TransformationDetailTable()
            let viewModel = TransformationDetailTableViewModel(viewController: transformationDetailTable,data: data)
            transformationDetailTable.viewModel = viewModel
            self.navigationController?.pushViewController(
                transformationDetailTable,
                animated: true
            )
        }
    }
}
