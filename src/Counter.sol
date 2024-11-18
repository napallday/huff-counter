// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./interface/ICounter.sol";

contract Counter is ICounter {
    uint256 public number;

    constructor(uint256 _number) {
        number = _number;
    }

    function setNumber(uint256 _newNumber) public {
        number = _newNumber;
    }

    function add(uint256 _increment) public returns (uint256) {
        number += _increment;
        return number;
    }
}
