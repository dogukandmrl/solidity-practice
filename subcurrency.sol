pragma solidity >=0.7.0 <0.9.0;

// the contract allows only its creator to create new coins
// anyone can send coins to each other without a need for registering with a username and password, all you need is ethereum keypair.

contract Coin{
// the keyword public it's making the variables
// here accessible from other contracts

    address public minter;
    mapping (address=> uint) public balances;

    event Sent (address form, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }

    // make new coins and send them to on address
    // only the owner can send these coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }
    
    error insufficientBalance(uint requested, uint available);

    function send(address receiver , uint amount ) public {
        if(amount> balances[msg.sender])
        revert insufficientBalance(
            {
                requested: amount,
                available: balances[msg.sender]
            }
        );
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }
    
}
