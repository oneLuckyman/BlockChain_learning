# Solidity constant

constant、view 和 pure 三个修饰词有什么区别和联系？简单来说，在 Solidity v4.17 之前，只有 constant，后来有人嫌 constant 这个词本身代表变量中的常量，不适合用来修饰函数，所以讲 constant 拆成了 view 和 pure 。view 的作用和 constant 一模一样，可以读取状态变量但是不能改；pure 则更为严格，pure 修饰的函数不能改也不能读取状态变量，否则编译通不过。

constant、view、pure 三个函数修饰词的作用是告诉编译器，函数不改变/不读取状态变量，这样函数执行就可以不消耗 gas 了，因为不需要矿工来验证。所以用好这几个关键词很重要，不言而喻，省 gas 就是省钱！

## 为什么使用 constant

首先，我们要明白为什么用 constant？

```txt
Functions can be declared constant in which case they promise not to modify the state.
```

也就是说，当执行函数时不会去修改区块中的数据状态时，那么这个函数就可以被声明成 constant 的，比如 getter 类的方法。

同时，当函数被 constant 修饰时也是提示 web3js (或其他 json-rpc 客户端) 调用此方法时要使用 eth_call 函数而不是 eth_sendTransaction。

constant 需要编程时明确指定，即使状态不会改变，编译器也不会自动添加。一般情况下调用 constant 声明的方法不需要花费 gas，如果未使用 constant 修饰的函数在调用的过程中可能会生成一笔交易并且产生交易费用。

## constant 与 view 的区别

在 Solidity 0.4.16 中介绍 view 和 constant 时，文档是这样描述的：

```txt
constant for functions: Same as view.
```

也就是说，view 和 constant 效果是一样的。

在最新版本的 Solidity 中是这样描述的：

```txt
constant on functions is an alias to view, but this is deprecated and will be dropped in version 0.5.0.
Getter methods are marked view.
```

constant 是 view 的别名，不过 constant 在 0.5.0 以上版本中已经被去掉。这也是我们在写智能合约时需要注意的事项。目前网络上的示例基本上还都采用 constant 来进行修饰。

那么，文档中已经描述这两者是相同的，那么为什么要用 view 来替代 constant 呢？基本上原因是这样的，使用 constant 有一定的误导性，比如用 constant 修饰的方法返回的结果并不是常量，而是根据一定的情况有所变化。而且，用 constant 来修饰并不是那么细致入微。因此，引入了更有意义和更有用的 view 和 pure 来代替 constant。

## 替换前后的变化

替换之前：

- constant 修饰的函数不应该修改状态；
- constant 修饰的变量（类中的变量而不是方法）每次调用时都会被重新计算；

替换之后：

- 关键词 view 用来修饰函数，替换掉 constant。调用 view 修饰的函数不能改变未来与任何合约交互的行为。这意味着被修饰的函数不能使用 SSTORE，不能发送或接收以太币，只能调用其他 view 或 pure 修饰的函数。
- 关键词 pure 用来修饰函数，是在 view 修饰函数上附加了一些限制，pure 修饰的函数不能改也不能读状态变量，否则编译通不过。这意味着它不能使用 SSTORE，不能发送或接收以太币，不能使用 msg 或 block 而只能调用其他 pure 函数。
- 关键词 constant 针对函数无效。
- 任何用 constant 修饰的变量将不能被修改。
