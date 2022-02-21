1.什么是AppAsset::register($this);
	引入js和css文件

2.命名空间多级记得参数一一对应
http://127.0.0.1/mancando/master/admin/web/channel/merchants/merchants/index

3.如何输出原生sql

```php
echo $query->createCommand()->getRawSql();die;
```

4.with和joinWith的区别

```
with相当于在查一次，joinWith是进行联合查询
```

5.计算变量所占的内存	

```php
$start_memory = memory_get_usage();
$foo = $query->asArray()->all();
echo memory_get_usage() - $start_memory;
```

6.批量增加的两种方式

```php
public function actionDetailAdd(){
  $cabinetService = new CabinetService();
  $garages = $cabinetService->getGarages();
  $product_ids = (Product::find())->select(['id','name'])->where(['status' => 4000])->asArray()->all();
  $cabinet_ids  = (Cabinet::find())->select(['id'])->where(['status' => 10])->asArray()->all();
  $cabinet_ids = array_column($cabinet_ids,'id');
  $garages = array_keys($garages);
  $products = array_column($product_ids,'id');

  $_model = new CabinetStockoutItem();
  $currentData = date("Y-m-d");
  for($i = 0; $i<100; $i++){
    $model = clone $_model;
    $model->distribution_id = 1;
    $model->cabinet_id = $cabinet_ids[array_rand($cabinet_ids,1)];
    $model->garage_id  = $garages[array_rand($garages,1)];
    $model->product_id = $products[array_rand($products,1)];
    $model->quantity   = mt_rand(1,1000);
    $model->note       = '';
    $model->create_time = $currentData;
    $model->update_time = $currentData;
    if($model->save()){
      echo '成功'.'<br>';
    }
  }
}
//在AR模型里面
public static function batchInsert($type, $contents) {
  $table = self::tableName();
  $db = self::getDb();

  $type = intval($type);
  $values = [];
  $createTime = $updateTime =  self::expressionNow();
  foreach ($contents as $content) {
    $values[] = [null, $type, $content, $createTime, $updateTime];
  }

  $command = $db->createCommand();
  $command->batchInsert($table, ['id', 'type', 'content','create_time', 'update_time'], $values);
  return $command->execute();
}
```

7.sum条件求和

```mysql
        $query = CabinetStockoutItem::find();
        $table = CabinetStockoutItem::tableName();
        $query->innerJoinWith(['cabinet']);
        $query->select([
          $table.'.id',
          $table.'.cabinet_id',
          "count(DISTINCT $table.product_id) as count_category",
          "sum(IF($table.quantity>0,$table.quantity,0)) as total",  //小于零按零计算
          $table.".create_time",
        ]);
        $query->andwhere([$table.'.status' => CabinetStockoutItem::STATUS_NORMAL]);
        $query->andwhere([$table.'.distribution_id' => $this->getDistributionId()]);
        $query->groupBy([$table.'.cabinet_id']);
```

5.弹窗关闭和页面跳转

```js
ui.navigate("<?= \app\helpers\Url::to(['bill/reconciliation-bill/index']) ?>")
//弹窗
ui.contentWindow().find('#distribution-list').data('dataTable').load();
ui.closeModal();
```

6.生成时间

```php
$model->expressionNow()
```

7.设置表单input右侧提醒

```php
<?php

namespace app\models\robot;
use app\models\FormModel;


class IgnoreAddForm extends FormModel
{
    ···
    public function attributeHints() {
        return [
            'content' => '设置多条消息忽略时，使用换行符(enter键)进行分割',
        ];
    }
  	···
}
```

8.图片上传

```php
/*单张图片上传*/
//html
<?= $form->fieldResourceImg('转款回执上传', $model->transfer_receipt_pic) ?>
//php
  
  
/* 多张图片上传*/
  $resourceUrl = $this->context->getResourceUrl();
$this->registerCssFile($resourceUrl.'/css/multiUpload.css');
<?= $form->field($model, 'businessLicensePic')->resourceFile([
            'resource' => new licenseResource(),
            'height' => '100px',
            'buttonContent' => '上传图片',
            'tip' => '图片建议尺寸：750*300，图片支持JPG、PNG、GIF格式，文件不可大于2MB。',
        ]) ?>
        <?= $form->field($model, 'contract')->multiResourceFile([
			'resource' => new contractResource(),
			'width' => '100%',
			'tip' => '支持JPG、PNG、GIF格式，并且文件不大于2MB。',
		]) ?>
```

9.设置左曹导航栏

```php

['label' => '渠道管理', 'i'=>'fa fa-user', 'items' => [
  ['label' => '渠道管理', 'items'=>[
    ['label' => '渠道列表', 'url' => ['channel/merchants/merchants/index']],
    ['label' => '新增渠道', 'url' => ['channel/merchants/merchants/add']],
    ['label' => '渠道等级设置', 'url' => ['channel/merchants/merchants-level/index']],
    ['label' => '接口配置', 'url' => ['channel/merchants/interface-config/index']],
    ['label' => '用户列表', 'url' => ['channel/merchants/user/index']],
  ]],
]],
['label' => '业务员管理', 'i'=>'fa fa-user', 'items' => [
  ['label' => '业务员列表', 'url' => ['salesman/salesman/index']],
  ['label' => '新增业务员', 'url' => ['salesman/salesman/add']],
 ]],
```

10.下拉列表

```php
<?= $form->field($model, 'typeId')->selectDropDownList($typeId) ?>
```

11.日期	

```php
//html层代码
<?= $form->field($model,'date')->dateRangePicker() ?>
//service层代码
$conditions = QueryHelper::timeRange('create_time', $form->createTime);
```

12.导出excel表格

```php
//html里面如何写
<?= Html::exporterA('导出Excel', ['cabinet/stock/export']) ?>
//控制器写法
public function actionExport() {
        $model = new OrderSearchForm();
        $model->loadGet();

        $exporter = new OrderExporter();
        $exporter->render($model);
}

//导出execl的模型
<?php
namespace app\models\channel\price;		//修改命名空间

use common\models\LogicModel;
use mylibs\CSVExporter;

class GuidePriceExporter extends LogicModel 
{
    public function render(GuidePriceSearchForm $form /*搜索表单	*/) {
        $service = new GuidePriceService();
        CSVExporter::header('渠道指导价');

        CSVExporter::line([
            '定价规则',
            '产品编号',
            '修理厂价',
            '渠道价',
            '返利',
        ]);

        $dataProvider = $service->search($form);
        $query = $dataProvider->query;
        foreach ($query->each() as $row) {
            $data = [
                CSVExporter::formatText($row->rule->name),
                CSVExporter::formatText($row->product->number),
                $row->garage_price,
                $row->channel_price,
                $row->distribution_rebate,
            ];

            CSVExporter::line($data);
        }

        CSVExporter::end();
    }
}

```

13.input hiddent 写法

```php
<?= Html::activeHiddenInput($model, 'id') ?>
```

14.设置返回的错误方式

```php
return $this->addErrors($model->getErrors()); //数组 一般在model层里面使用
return new Error('未知的配件柜型号status值');	//返回错误对象，在静态方法里面使用
return $this->setError($model->getError()); //设置错误信息，一般在service层
```

15.返回信息的几种方式

```php
//渲染模型的返回
return $this->renderError($service->getError());
```

16.操作一览，弹窗

```php
<?php if($category->isEnable()):?>
     <?= Html::confirmA('停用', ['product/category/disable', 'id' => $category->id],'确认停用吗',[
         'title'=>'确认停用',
         'success' => new JsExpression("function() {\$('#category-list').data('dataTable').load();}")
                ]) ?>
 <?php endif;?>
```

17.搜索弹框

```php
<?= $form->field($model, 'distributionId')->queryInput([
                    'size' => 10 ,
                    'url' => ['distribution/distribution/query'] ,
                ]) ?>
```

18.产品品类，产品品牌，产品品牌如何查询

```php
//html这么写
<?= $form->field($model, 'number')->textInput(['placeholder'=>'产品编号/供应商编号']) ?>
<?= $form->field($model, 'categoryId')->productCategorySelectTree(['change'=>[
  'url' => ['channel/price/guide-price/get-brands'],
  'update' => '#guidepricesearchform-brandid',	
  'name' 	=> 'categoryId',
]]) ?>
<?= $form->field($model, 'brandId')->searchDropDownList($brands) ?>
  
  
//表单类这么写
namespace app\models\stock;
use common\models\FormModel;
class StockSearchForm extends FormModel
{
	public $number;
	public $productCategory;
	public $productBrand;
	public $stockShelves;
	public $stockNumStart;
	public $stockNumEnd;

	public $hasSetShelves;
	public $notSetShelves;

	/**
	 * @inheritdoc
	 */
	public function rules() {
		return [
			[['number', 'stockNumStart', 'stockNumEnd', 'productCategory', 'productBrand' , 'stockShelves', 'notSetShelves', 'hasSetShelves'], 'safe'],
			[['number'], 'filter', 'filter'=>'strtoupper'],
			[['stockNumStart', 'stockNumEnd'], 'number', 'integerOnly'=>true, 'min'=>0],
		];
	}
	public function attributeLabels() {
		return [
			'number'		=> '产品编号',
			'productCategory' => '产品品类',
			'productBrand' => '产品品牌',
			'stockShelves' => '仓位',
			'stockNumStart' => '库存数量',
			'stockNumEnd' => '~',
			'hasSetShelves' => '有仓位',
			'notSetShelves' => '无仓位'
		];
	}
}

//控制器ajax
public function actionGetBrands() {
  $categoryId = \Yii::$app->request->post('categoryId');

  $service = new StockService();
  $brands = $service->getBrands($categoryId);
  if ($brands === false) {
    return $this->jsonError($service->getError());
  }

  return $this->jsonSuccess(Html::toDropDownListAjaxOptions($brands));
}

//add或者modify使用表单的注意事项css增加
    .three-level-tree-select {
        width: 96%;
        left: 15px !important
    }
    #fullreductionactivitymodifyform-categoryid_show_name_id{
        width: 100% !important;
    }
```

19.给表单赋值

```php
$model->load($typeModel->attributes, '');
```

20.如何起一个事务

```php
$transaction = new Transaction();
$transaction->rollback();
$transaction->commit();
```

21.批量更新

```php
使用ar模型updateAll()
public static function updateStatusByAccountId($newStatus,$accountId) {
        $attributes['status']      = $newStatus;
        $attributes['update_time'] = self::expressionNow();
        $condition = ['account_id' => $accountId];
        return self::updateAll($attributes, $condition);
    }
//返回值是int
```

22.jsonTable传参数

```php
public function jsonTable($view, $dataProvider, $emptyText=null, $viewData=[], $additional=[]) {
		return DataTableData::widget([
			'dataProvider' 	=> $dataProvider,
			'itemView'		=> $view,
			'emptyText'		=> $emptyText,
			'viewData'		=> $viewData,
			'controller'	=> $this,
			'additionalData'=> $additional,
		]);
	}

return $this->jsonTable('_view_list', $dataProvider,'',[
            'coupon' => $rowspan['coupon'],
            'count'  => $rowspan['count']
        ]);

```

23.设置序号

```php
$pagination = $dataProvider->getPagination();
$pageSize = $pagination->getPageSize();

return [
    'data' => $dataProvider,
    'pageSize' => $pageSize,
];

$page = intval(\Yii::$app->request->get('page', 1));

        return $this->jsonTable('_view_list', $dataProvider['data'], null, [
            'offset' => ($page-1)*$dataProvider['pageSize'],
        ]);
        
        <td><?= ($offset + $index + 1) ?></td>
```

24.权限设置问题

```php
namespace common\models\system;

class Permission extends \mylibs\api\cas\Permission
{
	public function __construct($userId) {
		parent::__construct($userId, 9000); //cas表里面的appid
	}
}
```



