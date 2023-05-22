// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 荷兰拍卖：随着时间的流逝，价格变得越来越低

interface IERC721 {
    function transferForm(address _from ,address _to, uint _nftId) external;
}

contract DutchAuction {
    uint private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate;

    constructor(uint _startingPrice, uint _discountRate, address _nft, uint _nftId) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;

        require(_startingPrice >= _discountRate * DURATION, "starting price < discount");

        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt, "action expired");
        uint price = getPrice();
        require(msg.value >= price, "ETH < price");

        nft.transferForm(seller, msg.sender, nftId);
        uint refund = msg.value - price;
        if(refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }
}