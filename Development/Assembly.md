[TOC]

### Assembly（汇编） 


### X86
#### gcc x86 Assembly Quick Reference ("Cheat Sheet")

- [gcc x86 Assembly](https://www.cs.uaf.edu/2005/fall/cs301/support/x86/index.html)
- [Security-Course/PC-Assembly-Language.pdf](https://github.com/lizhi16/Security-Course/blob/master/buffer-overflow/supplyments/PC-Assembly-Language.pdf)

##### Instructions（指令）

|  Mnemonic（助记符） |  Purpose（用途） | Examples（示例）  |
|---|---|---|
| `mov src,dest`  | Move data between registers, load immediate data into registers, move data between registers and memory.  | `mov $4,%eax`  # Load constant into eax <br>`mov %eax,%ebx`  # Copy eax into ebx <br>`mov %ebx,123`  # Copy ebx to memory address 123  |
| `push src`  | Insert a value onto the stack.  Useful for passing arguments, saving registers, etc.  | `push %ebp`  |
| `pop dest` |  Remove topmost value from the stack.  Equivalent to "`mov (%esp),dest; add $4,%esp`" | `pop %ebp` |
| `call func` | Push the address of the next instruction and start executing func.  |  `call print_int` |
| `ret`  | Pop the return program counter, and jump there.  Ends a subroutine.  |  `ret` |
| `add src,dest`  | `dest=dest+src`  | `add %ebx,%eax` # Add ebx to eax  |
| `mul src` |  Multiply eax and src as unsigned integers, and put the result in eax.  High 32 bits of product go into eax. | `mul %ebx` #Multiply eax by ebx  |
| `jmp label`  |  Goto the instruction label:.  Skips anything else in the way. | `jmp post_mem` <br>`mov %eax,0` # Write to NULL! <br>post_mem: # OK here...  |
| `cmp a,b` | Compare two values.  Sets flags that are used by the conditional jumps (below).  WARNING: compare is relative to *last* argument, so `jl` jumps if b<a!  | `cmp $10,%eax` |
| `jl label` | Goto label if previous comparison came out as less-than.  Other conditionals available are: `jle` (<=), `je` (==), `jge` (>=), `jg` (>), `jne` (!=), and many others.  | `jl loop_start`  # Jump if eax<10  |


##### Stack Frame（栈帧）

(example without %ebp or local variables)

| Contents  | off esp  |
|---|---|
| caller's variables  | 12(%esp)  |
| Argument 2  | 8(%esp)  |
| Argument 1  | 4(%esp)  |
| Caller Return Address  | 0(%esp)  |

```assembly
my_sub: # Returns first argument
  mov 4(%esp), %eax
  ret
```

(example when using %ebp and two local variables)

|  Contents | off ebp  | off esp  |
|---|---|---|
| caller's variables  | 16(%ebp)  | 24(%esp)  |
| Argument 2  | 12(%ebp)  | 20(%esp)  |
| Argument 1  | 8(%ebp)  | 16(%esp)  |
| Caller Return Address  | 4(%ebp)  | 12(%esp)  |
| Saved ebp  | 0(%ebp)  | 8(%esp)  |
| Local variable 1  | -4(%ebp)  | 4(%esp)  |
| Local variable 2  | -8(%ebp) | 0(%esp)  |

```assembly
my_sub2: # Returns first argument
  push %ebp  # Prologue
  mov %esp, %ebp
  mov 8(%ebp), %eax
  mov %ebp, %esp  # Epilogue
  pop %ebp
  ret
```


##### Constants, Registers, Memory（常量，寄存器，内存）
Constants MUST be preceeded with `$`.  `$12` means decimal 12; `$0xF0` is hex.
`$some_function` is the address of the first instruction of the function.
WARNING: a bare "12", "0xF0", or "some_function" dereferences the expression like it was a pointer!
Registers MUST be preceeded with `%`.  `%eax` means register eax.
Memory access (use register as pointer): `(%esp)`.  Same as C "*esp".
Memory access with offset (use register + offset as pointer): `4(%esp)`.  Same as C "*(esp+4)".
Memory access with scaled index (register + another register * scale): `(%eax, %ebx, 4)`.  Same as C "*(eax+ebx*4)".


##### Registers（寄存器）
`%esp` is the stack pointer
`%ebp` is the stack frame pointer
Return value in `%eax`
Arguments are on the stack
Free for use (no save needed):
```
   %eax, %ebx, %ecx, %edx
```
Must be saved:
```
   %esp, %ebp, %esi, %edi
```

##### Common Errors（常见错误）

Segfault on innocent-looking code.
*    Do you need to add "$" in front of a constant?
*    Did you clean up the stack properly?


### Linux
#### Linux 进程内存布局

```
+——————————————+ 0xFFFFFFFF (high address)
| kernel space | 1GB/4GB
+——————————————+ 0xC0000000 == TASK_SIZE
|    stack     |
+——————————————+<——— stack pointer (%esp)
|      |       |
|      v       |
|      ^       |
|      |       |
+——————————————+
|memory mapping|<——— dynamically linked lib (*.so)
+——————————————+ 0x40000000
|      ^       |
|      |       |
+——————————————+<——— brk() point
|     heap     |<——— malloc(), free()
+——————————————+ 
|   bss seg    |<——— uninitialized data (Block Started by Symbol)
+——————————————+ 
|  data seg    |<——— initialized static data
+——————————————+ 
|  text seg    |<——- binary code (*.o), static lib (*.a)
+——————————————+ 0x08048000
|    unused    |
+——————————————+ 0x00000000 (low address)
```

字节序 `little-endian`：低字节在前，32比特值B3B2B1B0

```
  +——+——+——+——+
  |B0|B1|B2|B3|
  +——+——+——+——+
low  —————>  high address
```

栈帧（stack frame）：函数调用数据结构单元

```
+———————————————————————-+    caller’s stack pointer (old %esp) 
|        arguments       |               |                   
+———————————————————————-+               |                  
|     return address     | (old %eip)    v                
+———————————————————————-+<——— callee’s sf (new %ebp)                              
|  caller’s sf pointer   |———> caller’s sf (old %ebp)
+———————————————————————-+
|    local variables     |
+————————————————————————+
|                        |<——— callee’s stack pointer (new %esp)
+———————————————————————-+
|           |            |
|           v            |
```


* caller调用者；callee被调用者，即子函数
* arguments：子函数参数，调用前入栈
* return address： 子函数调用前将待执行下一条指令地址保存在返回地址中，待函数调用结束后，返回到调用者继续执行
* `eip` 指令指针指向下一条指令地址
* stack frame pointer 栈帧指针指向调用者的栈帧基址`ebp`
* `ebp` 基址指针指向栈帧底（高地址）
* `esp` 栈指针指向栈顶（低地址）
* `e` 表示32位，`%` 表示寄存器

* caller（调用者）规则：
    1. 子函数参数入栈，从右向左
    2. `call`指令，将下一条指令地址入栈（`push %eip`），并无条件跳转
    3. 子函数返回，返回值在`eax`中


* callee（被调用者）规则：

    1. 保存caller的栈基址，设定callee新的栈基址为当前栈指针（`push %ebp`; `mov %esp, %ebp`）
    2. 为局部变量分配栈空间（`sub 123,%esp`）
    3. 执行函数，结果保存在`eax`中
    4. 执行`leave`复合指令，清除当前栈帧，恢复到调用者栈帧（`mov %ebp, %esp`; `pop %ebp`）
    5. 执行`ret`指令（`pop %eip`）


- [Security-Course/buffer-overflow-1.md - 缓冲区溢出：原理与实验](https://github.com/lizhi16/Security-Course/blob/master/buffer-overflow/buffer-overflow-1.md)












