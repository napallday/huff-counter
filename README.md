## Summary
In this project, we use Yul & Huff to write a basic solidity smart contract.
- [Counter.sol](src/Counter.sol): Solidity implementation
- [Counter_yul.sol](src/Counter_yul.sol): Yul assembly in Solidity
- [Counter.huff](src/Counter.huff): Huff Implementation
- [Counter.yul](src/Counter.yul): Pure Yul Implementation (the tests haven't covered this file)

The implementations are covered by unit tests and fuzz tests.

### Build
```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Gas Snapshots

```shell
$ forge snapshot
```

Result:
```javascript
[PASS] testFuzz_SetHuffValue(uint256) (runs: 1001, μ: 30728, ~: 30967)
[PASS] testFuzz_SetYulValue(uint256) (runs: 1001, μ: 31046, ~: 31285)
[PASS] testHuff_AddOne() (gas: 31090)
[PASS] testHuff_Overflow() (gas: 32059)
[PASS] testHuff_ReadValue() (gas: 10232)
[PASS] testSol_AddOne() (gas: 31469)
[PASS] testSol_Overflow() (gas: 32762)
[PASS] testSol_ReadValue() (gas: 10503)
[PASS] testSol_SetValue(uint256) (runs: 1001, μ: 31084, ~: 31323)
[PASS] testStatefulFuzz_AddCompare(uint256[]) (runs: 1001, μ: 1126914, ~: 1122116)
[PASS] testYul_AddOne() (gas: 31188)
[PASS] testYul_Overflow() (gas: 32368)
[PASS] testYul_ReadValue() (gas: 10387)
```
