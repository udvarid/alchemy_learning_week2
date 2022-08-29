// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

//deployed to Goerli at 0x29dE2eBb7a7f188D48C3cD38383A9215B8a4ec0C

contract BuyMeACoffe {
    // Event to emit
    event NewMemo(
        address indexed from, 
        uint256 timestamp,
        string name,
        string message
    );

    //Memmo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos received from friends
    Memo[] memos;

    //Address of contract deployer
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /**
     @dev buy a coffer for contract owner
     */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffe with 0 eth");
        
        // Add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        //Emit a log event when a new memo is created!
        emit NewMemo(msg.sender,
            block.timestamp,
            _name,
            _message);
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns(Memo[] memory) {    
        return memos;
    }
    
}
