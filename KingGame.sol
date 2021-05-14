// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract KingGame {
    
    // library usage

    // state variables
    mapping(address => uint256) private _balances;
    address private _owner;
    uint256 private _pot;
    
    

    // events
    event Deposited(address sender, uint256 amount);
    event Withdrew(address recipient, uint256);

    // constructor
    constructor(address owner_, uint256 pot_) payable potStart {
        _owner = owner_;
        _pot = pot_;
    }
  

    // modifiers
    // Mettre au min 1 finney pr lancer le jeu
    modifier potStart(){
        require(msg.value >= 1e15,"KingGame: Pay for deploy the game");
        _;
    } 
    //Mettre obligatoirement le double du pot
    modifier doubleMise(){
        require(msg.value >= _balances[account], "KingGame: Double the bet");
        _;
    }
    
    // functions
    //Voir le pot actuel
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    
    //Envoyer le double de la mise ds le pot
    function sendMoney(address sender, uint256 amount) public payable doubleMise {
    _balances[sender] += amount;
    emit Deposited(sender, amount);
}
}