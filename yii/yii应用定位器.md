### yii应用定位器

/vendor/yii2/yiisoft/di/ServiceLocator.php

1.两个私有属性$`_`components和$`_`definitions
	$`_`components是个数组，键是应用的id，值是应用的对象实例
	$`_`definitions是个数组，键是应用的id，值是创建对象需要用到配置信息
2.成员方法

```php
	publi function get($id, $throwException = true)
	//先去$_components找，有实例直接返回；没有则去$_definitions找对应的对象配置信息，创建实例添加$`_`components并返回；如果也没有实例化对象的配置信息，则返回null
```

```php
	public function set($id, $definition)
	//参数$id基本上就是和应用名一致，$definition则是实例化对象时需要配置信息。每一次调用set()方法的时候，都会先unset$`_`components和$`_`definitions中先前保存键值对。
```

```php
public function clear($id) {
    unset($this->_definitions[$id], $this->_components[$id]);
}
	//清除指定id
```

```php
public function setComponents($components)
{
    foreach ($components as $id => $component) {
        $this->set($id, $component);
    }
}
//批量设置应用
```

```php
public function getComponents($returnDefinitions = true)
{
    return $returnDefinitions ? $this->_definitions : $this->_components;
}
//返回应用
```

