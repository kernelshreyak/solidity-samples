pragma solidity ^0.5.11;

contract FundRaiser{
    
    mapping(address => uint) donations;

    uint constant minimumDonation = 100000;
    address payable owner;
    uint goal;

    constructor(uint _goal) public {
        goal = _goal;
        owner = msg.sender;
     }

    function donate() public payable{
        if(msg.value < minimumDonation){
            revert("Donation amount too low!");
        }

        donations[msg.sender] = donations[msg.sender] + msg.value;
    }

    function totalRaised() public view returns (uint){
        return address(this).balance;
    }

    function getDonationAmount(address donor) public view returns (uint){
        return donations[donor];
    }

    function withdrawOwner() public {
        require(msg.sender == owner, "You must be the owner");
        owner.transfer(address(this).balance);
    }

    function percentageComplete() public view returns (uint) {
        require(goal != 0, "goal is 0, cannot divide by 0");
        return 100 * (address(this).balance / goal);
  }
}