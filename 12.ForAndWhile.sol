// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// PS:智能合约中需要控制循环次数，因为变量越大，gas费用越多
contract ForAndWhile {
    function loops() external pure {
        for(uint i = 0; i < 10; i++) {
            // code
            if(i == 3) {
                continue;
            }
            // more code
            break;
        }
        uint j = 0;
        while(j < 10) {
            // code
            j++;
        }
    }

    function sum(uint _n) external pure returns (uint) {

        uint s;
        for(uint i = 1; i <= _n; i++) {
            s += i;
        }
        return s;
    }
}