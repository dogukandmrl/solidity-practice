pragma solidity ^0.5.7;

contract Will {
    address owner;
    uint fortune;
    bool deceased;

    constructor()payable public{
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;

    }
    //create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    //create modifier so that we only allocate funds if friend's gramps deceased
modifier mustBeDeceased {
        require(deceased = true);
        _;
    }
    // list of familywallets
   address payable [] familyWallets;
    // map throught inheritance 
   mapping (address => uint) inheritance;
   // set inheritance for each address

   function setInheritance(address payable wallet, uint amount) public{
       // to add wallets to the family wallets .push
       familyWallets.push(wallet);
       inheritance[wallet] = amount; 
   }
   // pay each family member based on their wallet address
   function payout() private mustBeDeceased {
       for(uint i=0; i<familyWallets.length; i++){
           familyWallets[i].transfer(inheritance[familyWallets[i]]);
           // transfering the funds from contract address to receiver address

       }
   }
   // oracle switch simulation
   function hasDeceased() public onlyOwner{
       deceased = true;
       payout();
   }

}
