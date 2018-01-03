pragma solidity ^0.4.8;

contract Remittance {
    
    address public contarctOwner;
    uint    public duration;
    
    struct  RemitStruct { 
        address depositor;
        address exchanger;
        address receiver;
        uint    depositAmount;
        bytes exchangerSecret;
        bytes receiverSecret;
        uint remitDeadline;
        //bool remitWitdrawn;
    }
    
    //RemitStruct[] public remitStructs;
    mapping(bytes => RemitStruct ) RemitStructs;
    
    event LogFundsDeposited(address depositor, uint depositAmount, uint depostiorDeadline);
    event LogFundsClaimed( address claimant, uint claimedAmount);
    
    function  Remittance(address _owner, uint _remitDuration)  
        public 
    { 
        contarctOwner = _owner;
        duration =  _remitDuration;
    }
    
    function Deposit(uint _depositAmount, address _exchanger, address _receiver,  bytes _receiverSecret)
        public 
        payable
        returns( bool success)
    {
        if(msg.value == 0 || msg.sender == 0) revert();
        
        RemitStruct memory newRemitStruct;
        
        newRemitStruct.depositor = msg.sender;
        newRemitStruct.exchanger = _exchanger;
        newRemitStruct.receiver = _receiver;
        newRemitStruct.depositAmount = _depositAmount;
        
        newRemitStruct.exchangerSecret = _receiver; //secret sent to exchanger = recepient address
        newRemitStruct.receiverSecret = _receiverSecret;
        newRemitStruct.remitDeadline = block.number + duration;
        
        RemitStructs[_receiver] = newRemitStruct;
        
        LogFundsDeposited(newRemitStruct.depositor,  newRemitStruct.depositAmount, newRemitStruct.remitDeadline );
        
        return true;
    }
    
    function claim(bytes )
        public
        returns (bool success)
    {
        
        LogFundsClaimed(msg.sender, 0);
        return true; 
    }
    
}
