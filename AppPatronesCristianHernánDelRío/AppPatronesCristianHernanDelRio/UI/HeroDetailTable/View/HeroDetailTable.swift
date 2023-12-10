import UIKit

//PROTOCOL
protocol HeroDetailTableProtocol:AnyObject{
    func reloadData()
}

final class HeroDetailTable: UITableViewController {
    //viewModel
    var viewModel: HeroDetailTableViewModelProtocol? = nil
    
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
            return prepareAndReturnCell(viewModel: viewModel,indexPath: indexPath)
        }else{
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height()
    }
    
    private func registerCell(){
        let nib = UINib(nibName: "DetailCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailCell")
    }
    
    private func configurations(){
        if let viewModel {
            navigationItem.title = viewModel.elementData.name
        }
    }
    
    private func prepareAndReturnCell(viewModel: HeroDetailTableViewModelProtocol, indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        let data = viewModel.elementData
        cell.titleOfCell.text = data.name
        cell.descriptionOfCell.text = data.description
        cell.imageOfCell.image = data.image
        if (viewModel.listData == []){
            if(!cell.transformationsButton.isHidden){
                cell.transformationsButton.isHidden = true
                cell.transformationsButton.isEnabled = false
            }
        }else{
            if(cell.transformationsButton.isHidden){
                cell.transformationsButton.isHidden = false
                cell.transformationsButton.isEnabled = true
            }
            //agregamos la función para el evento "touchUpInside" del botón "transformationsButton" de la celda
            cell.transformationsButton.addTarget(
                            self,
                            action: #selector(self.transformationsButtonTapped(_:)),
                            for: .touchUpInside
            )
        }
        return cell
    }
    
    private func height() -> CGFloat{
        return 725.0
    }
    
    @objc private func transformationsButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            if let viewModel = self.viewModel {
                let transformationsTable = TransformationsTable()
                let viewModel = TransformationsTableViewModel(viewController: transformationsTable, data: viewModel.listData)
                transformationsTable.viewModel = viewModel
                self.navigationController?.pushViewController(
                    transformationsTable,
                    animated: true
                )
            }
        }
    }
}

//EXTENSION
extension HeroDetailTable:HeroDetailTableProtocol{
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
