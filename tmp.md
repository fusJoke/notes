https://pan.baidu.com/s/1aFXOfo72oMCOJ4XFC4NGnQ 提取码：zimw 解压密码：ps2020cc

https://justcode.ikeepstudying.com/2020/09/photoshop-2020-for-mac-%E5%AE%89%E8%A3%85%E7%A0%B4%E8%A7%A3%E7%89%88%EF%BC%81%EF%BC%882020-09-14-%E4%BA%B2%E6%B5%8B%E5%8F%AF%E7%94%A8%EF%BC%89/





```
public function checkStock($id) {
    $model = $this->getModel($id);
    if (!$model) {
        return false;
    }
    $activityOrder = $model->getData();
    $query = ActivityOrderItem::find();
    $query->where(['order_id' => $activityOrder->id]);

    $res = [];
    foreach ($query->all() as $item) {
        $data = $this->getProductInfo($item->product);
        $data['quantity'] = $item->quantity;
        if ($data['stockQuantity'] < $item->quantity) {
            $res[] = $data;
        }
    }

    return $res;
}

    public function actionCheckComplete() {
        $id = $this->getId();

        $service = new ActivityOrderService();
        $res = $service->checkStock($id);
        if ($res === false) {
            return $this->jsonError($service->getError());
        }

        return $this->jsonSuccess($res);
    }
    
    
    
```