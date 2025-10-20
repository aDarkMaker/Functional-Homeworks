# 泛函程序设计原理 作业三 - 基数转换问题

## 问题描述

数字可以表示为不同基数的形式（如十进制5410，二进制102）。给定基数b和数字字符串dₙdₙ₋₁...d₁，其值计算公式为：

\[ \sum_{i=1}^{n} b^{i-1} \cdot d_i \]

任意数可表示为基数b的int list形式（如11002 = [0,0,1,1]，5410 = [4,5]）

## 实现要求

### 1. 高阶函数 toInt

```ocaml
toInt : int -> int list -> int
```

对所有b>1和L:int list（b进制数表示），返回对应的整数值

**示例：**
```ocaml
val base2ToInt = toInt 2;
val 2 = base2ToInt [0,1];  (* 1*2¹ + 0*2⁰ = 2 *)
```

### 2. 高阶函数 toBase

```ocaml
toBase : int -> int -> int list
```

将十进制数n转换为b进制数的int list形式（b>1, n≥0）

**示例：**
4210 → 1325 的转换示例

### 3. 高阶函数 convert

```ocaml
convert : int * int -> int list -> int list
```

满足：
\[ \text{toInt}_{b_2}(\text{convert}(b_1, b_2) L) = \text{toInt}_{b_1} L \]

即实现任意基数b1到b2的转换，保持数值等价性

## 实现说明

### toInt 函数
- 使用递归和累加器模式
- 从最低位开始计算，每次乘以基数的幂次
- 包含输入验证，确保数字在有效范围内

### toBase 函数
- 使用除法和取余运算
- 递归地将十进制数转换为目标基数
- 处理特殊情况（如n=0）

### convert 函数
- 先使用toInt将源基数转换为十进制
- 再使用toBase将十进制转换为目标基数
- 保证数值等价性

## 运行方式

```bash
# 编译并运行
ocamlc -o base_conversion base_conversion.ml
./base_conversion

# 或者直接使用解释器
ocaml base_conversion.ml
```

## 测试用例

程序包含完整的测试用例，验证：
1. toInt函数的正确性
2. toBase函数的正确性  
3. convert函数的正确性
4. 数值等价性验证

## 数学原理

基数转换的核心是位置记数法：
- 每个位置的值 = 数字 × 基数的位置次幂
- 转换时先转换为十进制（通用中间表示）
- 再从十进制转换为目标基数
