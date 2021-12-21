当mysql执行更新操作时，需要先更新一个数据页。如果这个数据页在内存中，则会直接更新，如果
这个数据页不在内存中，InnoDB会将这个更新操作缓存在change buffer中，当下次需要查询访问这个数据页的时候，会将数据页读入内存，然后执行change buffer中和这个数据页相关的操作，这样就保证了数据的逻辑正确性change buffer 使用的是buffer bool的内存

### 什么时候将change buffer中的数据更新到磁盘中？

当下一次查询命中这个数据页的时候，会先从磁盘中读取数据页到内存中，然后先执行change buffer的merge操作，保证数据逻辑的正确性。除了查询操作外，系统有后台线程会定期merge，数据库正常关闭(shutdown)的时候，也会进行merge操作。



### change buffer 和 redo log 对于磁盘的随机IO影响。

redo log是减少 随机写磁盘IO 的消耗。每个操作先记录redo log，系统空闲时或redo log满时进行磁盘IO。

change buffer是减少 随机读磁盘IO 的消耗。更新时如果内存中不存在该数据页，也不需要马上进行磁盘IO，而是先记录在change buffer中，等待时机统一merge。

