<?php

	/** Класс пользовательских методов административной панели */
	class CatalogCustomMacros {

		/** @var catalog $module */
		public $module;
		public function getObjectsByFlag($type_id = 0, $limit = 5, $parent_id = '', $rnd = 0, $flag = 'is_new'){
			$p=0;
			if(getRequest('p'))$p=(int)getRequest('p');

			$cacheName = 'getObjectsNew_' . $type_id.'_'.$limit.'_'.$parent_id.'_'.$rnd.'_'.$flag.'_'.$p;
			
			$limit = (int)$limit;
			$cache = cacheFrontend::getInstance();
			$result = $cache->loadData($cacheName);
			if ($result)return $result;
			
			$mCutom = system_buildin_load('custom');
			$result = array();
			$items = array();
			$pages = new selector('pages');
			if($type_id){
				$pages->types('object-type')->id($type_id);
			}else{
				$pages->types('hierarchy-type')->name('catalog', 'object');
			}
			if(($parent_id!==false)&&($parent_id!==''))
				$pages->where('hierarchy')->page($parent_id)->childs(10);
			/*if($filedNameValue){
				$filedNameValue = explode(':',$filedNameValue);
				if(count($filedNameValue)===2){
					$pages->where($filedNameValue[0])->equals($filedNameValue[1]);
				}
			}*/
			if($flag){
				if($flag == 'novinka'){
					$pages->where($flag)->equals(2524);
				}else if($flag === 'cena_so_skidkoj'){
					$pages->where($flag)->more(0);
				}else{
					$pages->where($flag)->isnotnull(true);
				}
			}
			//$pages->where('robots_deny')->isnull(true);
			//$pages->where('inner_good')->isnull(true);
			//$pages->where('is_unindexed')->isnull(true);
			//$pages->where('common_quantity')->more(0);
			//$pages->limit($p*$limit, $limit);
			//if($rnd){
				//$pages->order('rand');
			//}
			//$products->limit($offset, $limit);
			
			$offset = $p*$limit;
			$total = $pages->length();
			$pages = $pages->result();
			
			
			//сортировка
			/*$unsorted = [];
			foreach($pages as $page){
				$kollekciya = $page->kollekciya?:'';
				$price = $page->new_price?:$page->price;
				$unsorted[$kollekciya][$price][] = $page;
			}
			$t = [];
			ksort($unsorted);
			foreach($unsorted as $unsorted_row){
				ksort($unsorted_row);
				foreach($unsorted_row as $pages){
					foreach($pages as $page){
						$t[] = $page;
					}
				}
			}*/
			$unsorted = [];
			$kollekciya_price = [];
			foreach($pages as $page){
				$kollekciya = $page->kollekciya?:'';
				$price = $page->new_price?:$page->price;
				$unsorted[$kollekciya][$price][] = $page;
				
				$pk = 0;
				if(isset($kollekciya_price[$kollekciya])){
					$pk = $kollekciya_price[$kollekciya];
				}
				if($pk< $price){
					$pk = $price;
				}
				$kollekciya_price[$kollekciya] = $pk;
			}
			$t = [];
			arsort($kollekciya_price);//сортируем коллекции по убванию максимальной цены
			foreach($kollekciya_price as $kollekciya => $pk){
				$unsorted_row = isset($unsorted[$kollekciya])?$unsorted[$kollekciya]:[];
				krsort($unsorted_row);
				foreach($unsorted_row as $pages){
					foreach($pages as $page){
						$t[] = $page;
					}
				}
			}
			$pages = $t;
			//сортировка/
			
			$pages = array_slice($pages, $offset, $limit);
			
			
			
			
			
			$hierarchy = umiHierarchy::getInstance(); 
			
			if($parent_id == 0){//главная
				foreach($pages as $page){
					//if($type_id&&(!($page->getObjectTypeId() === (int)$type_id)))continue;
					$parentId = $page->getParentId();
					$item = array();
					$item = $mCutom->getExtendedData($page, false);

					$item['attribute:id'] = $page->id;
					$item['attribute:name'] = $page->name;
					$item['attribute:alt-name'] = $page->getAltName();
					$item['attribute:link'] = $page->link;
					$item['attribute:type_id'] = $page->getObjectTypeId();
					$item['attribute:parentId'] = $parentId;
					
					
					$items['nodes:item'][] = $item;
				}//foreach
				$result['nodes:lines'][] = $items;
			}else{
				foreach($pages as $page){
					//if($type_id&&(!($page->getObjectTypeId() === (int)$type_id)))continue;
					$parentId = $page->getParentId();
					$item = array();
					$item = $mCutom->getExtendedData($page, false);

					$item['attribute:id'] = $page->id;
					$item['attribute:name'] = $page->name;
					$item['attribute:alt-name'] = $page->getAltName();
					$item['attribute:link'] = $page->link;
					$item['attribute:type_id'] = $page->getObjectTypeId();
					$item['attribute:parentId'] = $parentId;
					
					
					$items[$parentId]['nodes:item'][] = $item;
				}//foreach
				
				foreach($items as $parentId => $val){
					$parent = $hierarchy->getElement($parentId);
					$t = $val;
					$t['attribute:id'] = $parent->id;
					$t['attribute:name'] = $parent->name;
					$t['attribute:link'] = $parent->link;
					$result['nodes:lines'][] = $t;
				}
			}
			$result['nodes:total'][] = $total;
			$result['nodes:per_page'][] = $limit;
			if($flag){
				$result['flag'] = $flag;
			}
			$cache->saveData($cacheName, $result, 600);
			return $result;
		}
		

		/**
		 * Выводит данные для формирования списка объектов каталога, с учетом параметров фильтрации
		 * @param string $template имя шаблона отображения (только для tpl)
		 * @param int $categoryId ид раздела каталога, объекты которого требуется вывести
		 * @param int $limit ограничение количества выводимых объектов каталога
		 * @param bool $ignorePaging игнорировать постраничную навигацию (то есть GET параметр 'p')
		 * @param int $level уровень вложенности раздела каталога $categoryId,
		 * на котором размещены необходимые объекты каталога
		 * @param bool $fieldName поле объекта каталога, по которому необходимо произвести сортировку
		 * @param bool $isAsc порядок сортировки
		 * @return mixed
		 * @throws publicException если не удалось получить объект страницы по id = $categoryId
		 * @throws coreException
		 * @throws selectorException
		 * @throws ErrorException
		 */
		public function getSmartCatalog(
			$template = 'default',
			$categoryId,
			$limit = 0,
			$ignorePaging = false,
			$level = 1,
			$fieldName = false,
			$isAsc = true
		) {
			/** @var CatalogMacros|catalog $module */
			$module = $this->module;

			if (!is_string($template)) {
				$template = 'default';
			}
$debug = in_array(getServer('REMOTE_ADDR'), ['85.140.209.46']);
//if($debug){var_dump($categoryId);exit;}
			list(
				$itemsTemplate,
				$emptyItemsTemplate,
				$emptySearchTemplates,
				$itemTemplate
				) = def_module::loadTemplates(
				'catalog/' . $template,
				'objects_block',
				'objects_block_empty',
				'objects_block_search_empty',
				'objects_block_line'
			);

			$umiHierarchy = umiHierarchy::getInstance();
			/* @var iUmiHierarchyElement $category */
			$category = $umiHierarchy->getElement($categoryId);

			if ((!$category instanceof iUmiHierarchyElement)&&($categoryId !== '0')) {
				throw new publicException(__METHOD__ . ': cant get page by id = ' . $categoryId);
			}

			$limit = $limit ?: $module->per_page;
			$currentPage = $ignorePaging ? 0 : (int) getRequest('p');
			$offset = $currentPage * $limit;

			if (!is_numeric($level)) {
				$level = 1;
			}

			$filteredProductsIds = null;
			$queriesMaker = null;

			if ((is_array(getRequest('filter')))&&($categoryId !== '0')) {
				$emptyItemsTemplate = $emptySearchTemplates;
				$queriesMaker = $module->getCatalogQueriesMaker($category, $level);

				if (!$queriesMaker instanceof FilterQueriesMaker) {
					return $module->makeEmptyCatalogResponse($emptyItemsTemplate, $categoryId);
				}

				$filteredProductsIds = $queriesMaker->getFilteredEntitiesIds();

				if (umiCount($filteredProductsIds) == 0) {
					return $module->makeEmptyCatalogResponse($emptyItemsTemplate, $categoryId);
				}
			}

			$products = new selector('pages');
			$products->types('hierarchy-type')->name('catalog', 'object');

			if ($filteredProductsIds === null) {
				if($categoryId === '0'){
				
				}else{
					$products->where('hierarchy')->page($categoryId)->childs($level);
				}
			} else {
				$products->where('id')->equals($filteredProductsIds);
			}

			if ($fieldName) {
				if ($isAsc) {
					$products->order($fieldName)->asc();
				} else {
					$products->order($fieldName)->desc();
				}
			} else {
				$products->order('ord')->asc();
			}

			if ($queriesMaker instanceof FilterQueriesMaker) {
				if (!$queriesMaker->isPermissionsIgnored()) {
					$products->option('no-permissions')->value(true);
				}
			}

			$products->option('load-all-props')->value(true);
			//$products->limit($offset, $limit);
			$pages = $products->result();
			$total = $products->length();
			
			//сортировка
			$unsorted = [];
			$kollekciya_price = [];
			foreach($pages as $page){
				$kollekciya = $page->kollekciya?:'';
				$price = $page->new_price?:$page->price;
				$unsorted[$kollekciya][$price][] = $page;
				
				$pk = 0;
				if(isset($kollekciya_price[$kollekciya])){
					$pk = $kollekciya_price[$kollekciya];
				}
				if($pk< $price){
					$pk = $price;
				}
				$kollekciya_price[$kollekciya] = $pk;
			}
			$t = [];
			arsort($kollekciya_price);//сортируем коллекции по убванию максимальной цены
			foreach($kollekciya_price as $kollekciya => $pk){
				$unsorted_row = isset($unsorted[$kollekciya])?$unsorted[$kollekciya]:[];
				krsort($unsorted_row);
				foreach($unsorted_row as $pages){
					foreach($pages as $page){
						$t[] = $page;
					}
				}
			}
			/*
			ksort($unsorted);
			foreach($unsorted as $unsorted_row){
				ksort($unsorted_row);
				foreach($unsorted_row as $pages){
					foreach($pages as $page){
						$t[] = $page;
					}
				}
			}
			*/
			$pages = $t;
			//сортировка/
			
			$pages = array_slice($pages, $offset, $limit);
			

			if ($total == 0) {
				return $module->makeEmptyCatalogResponse($emptyItemsTemplate, $categoryId);
			}

			$result = [];
			$items = [];
			$umiLinksHelper = umiLinksHelper::getInstance();
			/* @var iUmiHierarchyElement $page */
			foreach ($pages as $page) {
				$item = [];
				$pageId = $page->getId();
				$item['attribute:id'] = $pageId;
				$item['attribute:alt_name'] = $page->getAltName();
				$item['attribute:price'] = $page->getValue('price');
				$item['attribute:link'] = $umiLinksHelper->getLinkByParts($page);
				$item['xlink:href'] = 'upage://' . $pageId;
				$item['node:text'] = $page->getName();
				$items[] = catalog::parseTemplate($itemTemplate, $item, $pageId);
				catalog::pushEditable('catalog', 'object', $pageId);
				$umiHierarchy->unloadElement($pageId);
			}

			$result['subnodes:lines'] = $items;
			$result['numpages'] = umiPagenum::generateNumPage($total, $limit);
			$result['total'] = $total;
			$result['per_page'] = $limit;
			$result['category_id'] = $categoryId;

			return catalog::parseTemplate($itemsTemplate, $result, $categoryId);
		}

	}
