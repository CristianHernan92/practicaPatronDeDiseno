import UIKit

//PROTOCOL
protocol HeroDetailTableProtocol{
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = prepareAndReturnCell(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height()
    }
    
    private func registerCell(){
        let nib = UINib(nibName: "DetailCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailCell")
    }
    
    private func configurations(){
        navigationItem.title = viewModel?.getData().name
    }
    
    private func prepareAndReturnCell(indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        if let data = self.viewModel?.getData(){
            cell.titleOfCell.text = data.name
            cell.descriptionOfCell.text = data.description
            cell.imageOfCell.image = data.image
            
            if (self.viewModel?.getTransformationsList() == []){
                cell.transformationsButton.isHidden = true
                cell.transformationsButton.isEnabled = false
            }else{
                //agregamos la función para el evento "touchUpInside" del botón "transformationsButton" de la celda
                cell.transformationsButton.addTarget(
                                self,
                                action: #selector(self.transformationsButtonTapped(_:)),
                                for: .touchUpInside
                )
            }
        }
        else{
            cell.titleOfCell.text = ""
            cell.descriptionOfCell.text = ""
            cell.imageOfCell.image = UIImage()
            cell.transformationsButton.isHidden = true
            cell.transformationsButton.isEnabled = false
        }
        return cell
    }
    
    private func height() -> CGFloat{
        return 725.0
    }
    
    @objc private func transformationsButtonTapped(_ sender: UIButton) {
        self.navigationController?.showTransformationTable(with: self.viewModel?.getTransformationsList() ?? [])
    }
}

//EXTENSION
extension HeroDetailTable:HeroDetailTableProtocol{
    func reloadData() {
        self.tableView.reloadData()
    }
}
