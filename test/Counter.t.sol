// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {ICounter} from "../src/interface/ICounter.sol";
import {Counter} from "../src/Counter.sol";
import {CounterYul} from "../src/Counter_yul.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

contract CounterTest is Test {
    ICounter public counterSol;
    ICounter public counterHuff;
    ICounter public counterYul;
    string public constant HUFF_LOCATION = "Counter";

    function setUp() public {
        counterSol = new Counter(0);
        counterYul = new CounterYul(0);
        counterHuff = ICounter(HuffDeployer.config().with_args(abi.encode(uint256(0))).deploy(HUFF_LOCATION));
    }

    /* READ VALUE */
    function testSol_ReadValue() public view {
        assertEq(counterSol.number(), 0);
    }

    function testHuff_ReadValue() public view {
        assertEq(counterHuff.number(), 0);
    }

    function testYul_ReadValue() public view {
        assertEq(counterYul.number(), 0);
    }

    /* SET VALUE */
    function testSol_SetValue(uint256 _value) public {
        counterSol.setNumber(_value);
        assertEq(counterSol.number(), _value);
    }

    function testFuzz_SetHuffValue(uint256 _value) public {
        counterHuff.setNumber(_value);
        assertEq(counterHuff.number(), _value);
    }

    function testFuzz_SetYulValue(uint256 _value) public {
        counterYul.setNumber(_value);
        assertEq(counterYul.number(), _value);
    }

    /* ADD ONE */
    function testSol_AddOne() public {
        counterSol.add(1);
        assertEq(counterSol.number(), 1);
    }

    function testHuff_AddOne() public {
        counterHuff.add(1);
        assertEq(counterHuff.number(), 1);
    }

    function testYul_AddOne() public {
        counterYul.add(1);
        assertEq(counterYul.number(), 1);
    }

    /* Overflow */
    function testSol_Overflow() public {
        counterSol.add(type(uint256).max);
        assertEq(counterSol.number(), type(uint256).max);
        vm.expectRevert();
        counterSol.add(1);
    }

    function testHuff_Overflow() public {
        counterHuff.add(type(uint256).max);
        assertEq(counterHuff.number(), type(uint256).max);
        vm.expectRevert();
        counterHuff.add(1);
    }

    function testYul_Overflow() public {
        counterYul.add(type(uint256).max);
        assertEq(counterYul.number(), type(uint256).max);
        vm.expectRevert();
        counterYul.add(1);
    }

    /* Stateful Fuzz Tests */
    function testStatefulFuzz_AddCompare(uint256[] memory _values) public {
        counterSol.setNumber(0);
        counterYul.setNumber(0);
        counterHuff.setNumber(0);

        for (uint256 i = 0; i < _values.length; i++) {
            uint256 val = bound(_values[i], 1, 1_000_000_000_000_000_000);
            counterSol.add(val);
            counterYul.add(val);
            counterHuff.add(val);

            assertEq(counterSol.number(), counterYul.number());
            assertEq(counterYul.number(), counterHuff.number());
        }
    }
}
