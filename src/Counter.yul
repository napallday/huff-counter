object "CounterYul" {
    // contract deployment code
    code {
       datacopy(0, dataoffset("runtime"), datasize("runtime"))
       return(0, datasize("runtime"))
    }

    object "runtime" {
       code {
           // function dispatcher
           switch getFuncSelector()
           // setNumber(uint256)
           case 0x3fb5c1cb {
                if lt(calldatasize(), add(0x04, 0x20)) {
                    revert(0, 0)
                }
                let num := calldataload(0x04)
                sstore(0, num)
           }

           // number()
           case 0x8381f58a {
                let num := sload(0)
                mstore(0, num)
                return(0, 0x20)
           }

           // add(uint256)
           case 0x1003e2d2 {
                let num1 := sload(0)
                if lt(calldatasize(), add(0x04, 0x20)) {
                    revert(0, 0)
                }
                let num2 := calldataload(0x4)
                let sum := add(num1, num2)
                sstore(0, sum)
                mstore(0, sum)
                return(0, 0x20)
           }

           // no fallback function
           default {
               revert(0, 0)
           }

           
           function getFuncSelector() -> s {
                // retrive first 8 bytes
               s := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
           }
       }
    }
}