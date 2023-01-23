# Solidity mapping delete 

## mapping 

一种键值对的映射关系存储结构。语法：mapping(_Key => _Value)，键值对类型，键是唯一的，其赋值方式为：map[a] = test;意思是键为 a，值为 test；

注意：

- 1.键的类型允许除映射外的所有类型，如数组，合约，枚举，结构体。值的类型无限制。
- 2.在映射表里没有长度，键集合，值集合这样的概念，同时映射并没有做迭代的方法，可以自行实现：https://github.com/ethereum/dapp-bin/blob/master/library/iterable_mapping.sol 这是git上的一个实现方法。