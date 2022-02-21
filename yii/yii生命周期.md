### yii2生命周期

1.从/web/index.php开始
	

```php
defined('YII_DEBUG') or define('YII_DEBUG', true);
defined('YII_ENV') or define('YII_ENV', 'dev');

require __DIR__ . '/../vendor/autoload.php';	   //注册composer的自动加载机制
require __DIR__ . '/../vendor/yiisoft/yii2/Yii.php'; //1.注册yii自动加载，2.引入类映射文件(命名空间和文件路径的之间的映射) 3.实例化容器 

$config = require __DIR__ . '/../config/web.php';

(new yii\web\Application($config))->run();//应用执行
```



2.应用执行的过程

```php
public function run()
{
  try {
    $this->state = self::STATE_BEFORE_REQUEST;	//状态请求前
    $this->trigger(self::EVENT_BEFORE_REQUEST);	//触发请求事件

    $this->state = self::STATE_HANDLING_REQUEST;	//请求中
    $response = $this->handleRequest($this->getRequest()); //生成请求结果
		//$this->getRequest()返回一个对象--请求对象
    $this->state = self::STATE_AFTER_REQUEST;		//请求后
    $this->trigger(self::EVENT_AFTER_REQUEST);	//触发请求后事件

    $this->state = self::STATE_SENDING_RESPONSE;	//响应前
    $response->send();	//发送响应

    $this->state = self::STATE_END;	//响应结束

    return $response->exitStatus;	//退出
  } catch (ExitException $e) {
    $this->end($e->statusCode, isset($response) ? $response : null);
    return $e->statusCode;
  }
}



//返回一个请求对象
public function getRequest()
{
  return $this->get('request');
}

```





```php
//  /vendor/yiisoft/yii2/web/Application
public function handleRequest($request)
{
  if (empty($this->catchAll)) {
    try {
      list($route, $params) = $request->resolve();
    } catch (UrlNormalizerRedirectException $e) {
      $url = $e->url;
      if (is_array($url)) {
        if (isset($url[0])) {
          // ensure the route is absolute
          $url[0] = '/' . ltrim($url[0], '/');
        }
        $url += $request->getQueryParams();
      }

      return $this->getResponse()->redirect(Url::to($url, $e->scheme), $e->statusCode);
    }
  } else {
    $route = $this->catchAll[0];
    $params = $this->catchAll;
    unset($params[0]);
  }
  //使用request组件对请求信息进行处理，得到路由和参数
  try {
    Yii::debug("Route requested: '$route'", __METHOD__);
    $this->requestedRoute = $route;
    $result = $this->runAction($route, $params);	//将路由和参数传入，进行行为处理
    if ($result instanceof Response) {
      return $result;
    }

    $response = $this->getResponse();
    if ($result !== null) {
      $response->data = $result;
    }

    return $response;
  } catch (InvalidRouteException $e) {
    throw new NotFoundHttpException(Yii::t('yii', 'Page not found.'), $e->getCode(), $e);
  }
}
```



```php
// /vendor/yiisoft/yii2/web/Application
    public function resolve()
    {
        $result = Yii::$app->getUrlManager()->parseRequest($this);
        if ($result !== false) {
            list($route, $params) = $result;
            if ($this->_queryParams === null) {
                $_GET = $params + $_GET; // preserve numeric keys
            } else {
                $this->_queryParams = $params + $this->_queryParams;
            }

            return [$route, $this->getQueryParams()];
        }

        throw new NotFoundHttpException(Yii::t('yii', 'Page not found.'));
    }
```



```php
// /vendor/yiisoft/yii2/web/Application
public function runAction($route, $params = [])
{
  $parts = $this->createController($route);
  if (is_array($parts)) {
    /* @var $controller Controller */
    list($controller, $actionID) = $parts;
    $oldController = Yii::$app->controller;
    Yii::$app->controller = $controller;
    $result = $controller->runAction($actionID, $params);
    if ($oldController !== null) {
      Yii::$app->controller = $oldController;
    }

    return $result;
  }

  $id = $this->getUniqueId();
  throw new InvalidRouteException('Unable to resolve the request "' . ($id === '' ? $route : $id . '/' . $route) . '".');
}
```



```php
// 实例化控制器类
public function createController($route)
{
  if ($route === '') {
    $route = $this->defaultRoute;
  }

  // double slashes or leading/ending slashes may cause substr problem
  $route = trim($route, '/');
  if (strpos($route, '//') !== false) {
    return false;
  }

  if (strpos($route, '/') !== false) {
    list($id, $route) = explode('/', $route, 2);
  } else {
    $id = $route;
    $route = '';
  }

  // module and controller map take precedence
  if (isset($this->controllerMap[$id])) {
    $controller = Yii::createObject($this->controllerMap[$id], [$id, $this]);
    return [$controller, $route];
  }
  //容器实现依赖注入
  $module = $this->getModule($id);
  if ($module !== null) {
    return $module->createController($route);
  }

  if (($pos = strrpos($route, '/')) !== false) {
    $id .= '/' . substr($route, 0, $pos);
    $route = substr($route, $pos + 1);
  }

  $controller = $this->createControllerByID($id);
  if ($controller === null && $route !== '') {
    $controller = $this->createControllerByID($id . '/' . $route);
    $route = '';
  }

  return $controller === null ? false : [$controller, $route];
}

alt="5A0692A8DF36465DEC614D537D9FDBDD.gif"
```

