// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Bank {
   mapping(address => uint256) private accountBalances;

   function deposit() public payable {
        accountBalances[msg.sender] += msg.value;
   }

   function getAccountBalance() public view returns(uint256) {
       return accountBalances[msg.sender];
   }

   function transferFunds(address recipient, uint256 amount) public {
       address sender = msg.sender;
       require(accountBalances[sender] >= amount, "Insufficient funds");
       accountBalances[sender] -= amount;
       accountBalances[recipient] += amount;
   }

   function withdrawFunds() public payable {
        address account = msg.sender;
        require(accountBalances[account] != 0, "No funds available or invalid account");
        accountBalances[account] = 0;
        payable(account).transfer(accountBalances[account]);
   }

   function lendMoney(uint _amount) public{
        address account = msg.sender;
        require(accountBalances[account] >= 500000000000, "No tiene liquidez");
        uint minimumGuaranteeAmount  = accountBalances[account] * 25 / 100;
        require(_amount < minimumGuaranteeAmount  , "La garantia proporcionada no es suficiente" );
        // Garantia, condiciones del prestamo, tasa de interes, ...

        accountBalances[account] += _amount;
   }
}
