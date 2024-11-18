// SPDX-Licence-Identifier: MIT
pragma solidity 0.8.28;

interface ICounter {
    function number() external view returns (uint256);
    function setNumber(uint256 _newNumber) external;
    function add(uint256 _increment) external returns (uint256);
}
