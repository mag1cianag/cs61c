# cache

两个核心问题:  

1. 怎样知道一个数据项是否在cache中?
2. 如果数据项在cache中如何找到它.

## 直接映射(direct mapped)

根据字的主存地址
(**块地址**)mod(cache中的块数)

cache不仅储存数据也储存标记位,cache所需的总位数是cache大小和地址位数的函数  
ex:
  假设cache大小为$2^{n}$  

* 32位地址.
* 直接映射cache.
* cache大小为$2^{n}$个块,因此n位被用来索引.
* 块大小为$2^{m}$个字,因此m位用来查找块中的字,两位是字节偏移信息.  

所以标记位的大小$$32-(n+m+2)$$
直接映射的总位数为$$2^{n}*(块大小+标记域大小+有效位域大小)$$  

字节地址映射到cache中的某一块  

1. 计算块地址,即将主存划分成块
2. 再将块映射到cache中的某一块

## 全相连(fully associative)

Each memory block can map anywhere in the cache.

* Most efficient use of space
* Least efficient to check

Offset field: Lowest bits of memory address can be used to index to specific (**bytes**) within a block.  
Tag field: Leftovr upper bits of memory address determine which portion of memory the block came from (identifier)  

To check a fully associative cache:

1. Look at ALL cache slots in sequence
2. If Valid bit is 0,then ignore
3. If Valid bit is 1 and Tag matches,then return that data

Cache must store valid and tag bits.  

## 组相联(set associative)

Hit rate(HR): Percentage of memory accesses in a program or set of instructions
that result in a cache hit  
Miss rate(MR): Like hit rate,but for cache misses  

Hit time (HT): Time to access cache(including Tag comparsion)  
Miss penalty(MP): Time to replace a block in the cache from a lower level in the memory hierarchy  
