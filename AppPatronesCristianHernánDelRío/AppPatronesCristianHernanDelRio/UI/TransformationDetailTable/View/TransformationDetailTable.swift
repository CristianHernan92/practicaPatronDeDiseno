import UIKit

//PROTOCOL
protocol TransformationDetailTableProtocol:AnyObject{
    func reloadData()
}

final class TransformationDetailTable: UITableViewController {
    //viewModel
    var viewModel: TransformationDetailTableViewModelProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configurations()
        viewModel?.onViewLoaded()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel{
            return prepareAndReturnCell(viewModel: viewModel, indexPath: indexPath)
        }else{
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        height()
    }
    
    private func registerCell(){
        let nib = UINib(nibName: "DetailCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailCell")
    }
    
    private func configurations(){
        if let viewModel{
            navigationItem.title = viewModel.elementData.name
        }
    }
    
    private func prepareAndReturnCell(viewModel: TransformationDetailTableViewModelProtocol, indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        let data = viewModel.elementData
        cell.titleOfCell.text = data.name
        cell.descriptionOfCell.text = data.description
        cell.imageOfCell.image = data.image
        cell.transformationsButton.isHidden = true
        cell.transformationsButton.isEnabled = false
        return cell
    }
    
    private func height() -> CGFloat{
        return 725.0
    }

}

//EXTENSION
extension TransformationDetailTable:TransformationDetailTableProtocol{
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
