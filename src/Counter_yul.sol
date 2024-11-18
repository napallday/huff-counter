// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./interface/ICounter.sol";

contract CounterYul is ICounter {
    uint256 public number;

    constructor(uint256 _number) {
        number = _number;
    }

    function setNumber(uint256 newNumber) public {
        assembly {
            sstore(number.slot, newNumber)
        }
    }

    function getNumber() public view returns (uint256) {
        assembly {
            let num := sload(number.slot)
            mstore(0, num)
            return(0, 0x20)
        }
    }

    function add(uint256 _increment) public returns (uint256) {
        assembly {
            let num := sload(number.slot)
            if gt(num, sub(not(0), _increment)) { revert(0, 0) }
            num := add(num, _increment)
            sstore(number.slot, num)
            mstore(0, num)
            return(0, 0x20)
        }
    }
}
