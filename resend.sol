// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Deployed on Talka for traffic.
// 0x8181DeE11E3E4BF8aDeD436EE499bE7132151bd5

// And Bera also
// 0x3916cecADbAA33531a5BbdF85f6244Db41FC2315

contract SendBack {
 address payable constant feeAddress = payable(0xD13Cf36b646aDcaD473523F7B32bAa74F4F8F502);

 // Event to log the transfer of Ether
 event EtherTransfer(address indexed sender, uint256 totalAmount, uint256 fee);

 function handleIncomingEther() public payable {
   uint256 amount = msg.value;
   require(amount > 0, "No Ether received");

   // Deduct the fee
   uint256 fee = 1 wei;
   require(amount >= fee, "Not enough Ether to cover the fee");

   // Calculate the remaining amount
   uint256 remaining = amount - fee;

   // Send the fee to the fee address
   feeAddress.transfer(fee);

   // Send the rest of the Ether back to the sender
   payable(msg.sender).transfer(remaining);

   // Emit the event
   emit EtherTransfer(msg.sender, amount, fee);
 }

 // Fallback function to receive Ether
 fallback() external payable {}

 // Receive function to handle plain Ether transfers
 receive() external payable {
   handleIncomingEther();
 }
}
