<?php
	class custom extends def_module {
		public function cms_callMethod($method_name, $args) {
			return call_user_func_array(Array($this, $method_name), $args);
		}
		
		public function __call($method, $args) {
			throw new publicException("Method " . get_class($this) . "::" . $method . " doesn't exist");
		}
		
		public function counter($current_page_id) {
			$hierarchy = umiHierarchy::getInstance();
			$element=$hierarchy->getElement($current_page_id);
			$temp_count=$element->getValue("counter");
			++$temp_count;
			$element->setValue("counter", $temp_count);
			$element->commit();
			
			return $temp_count.' '.$this->getNoun($temp_count, 'просмотр', 'просмотра', 'просмотров');
		}
		public function sss(){return 1;
			$pages = new selector('pages');
			$pages->types('hierarchy-type')->name('catalog', 'object');
			$pages->where('is_active')->equals(array(0,1));
			foreach($pages as $element){
				$element->foto_tovara = [];
				$element->commit();
			}
		}
		public function getNoun($number = false, $one = '', $two = '', $five = '') {
			$n = $number;
			$n %= 100;
			if ($n >= 5 && $n <= 20) {
				return $five;
			}
			$n %= 10;
			if ($n === 1) {
				return $one;
			}
			if ($n >= 2 && $n <= 4) {
				return $two;
			}
			return $five;
		}
		
		
		public function dealers_have($page_id = false){
			$result = [];
			$umiObjectsCollection = umiObjectsCollection::getInstance();
			$hierarchy = umiHierarchy::getInstance();
			$element = $hierarchy->getElement($page_id);
			$items = [];
			if($element){
				$dealers_have = $element->dealers_have;
				if(is_array($dealers_have)){
					foreach($dealers_have as $dealer_id){
						$dealer = $umiObjectsCollection->getObject($dealer_id);
						$type_id = $dealer->type;
						$item = ['attribute:name' => $dealer->getName(), 'attribute:site' => $dealer->site];
						$items[$type_id]['nodes:item'][] = $item;
					}
					if(!empty($items)){
						foreach($items as $type_id => $item){
							$type = $umiObjectsCollection->getObject($type_id);
							$t = ['attribute:name' => $type->getName(), 'attribute:id' => $type_id];
							$t['nodes:item'] = $item['nodes:item'];
							$result['nodes:items'][] = $t;
						}
					}
				}
			}
			return $result;
		}
		/*
		Получить список страниц по параметрам
		*/
		public function getlastvideos($type_id = false, $limit = false, $parent_id = false){
			//date_video_change
			$result = array();
			$items = array();
			$p=0;
			if(getRequest('p'))$p=getRequest('p');
			$number = 0;
			
			$pages = new selector('pages');
			if($type_id)
				$pages->types('object-type')->id($type_id);
			if(($parent_id!==false)&&($parent_id!==''))
				$pages->where('hierarchy')->page($parent_id)->childs(1);
			$pages->where('ssylka_na_video')->isnotnull(true);
			$pages->order('date_video_change')->desc();
			
			if($limit){
				$pages->limit($p*$limit, $limit);
				$number = $p*$limit;
			}
			$count = 1;
			foreach($pages as $page){
				$number++;
				$item = $this->getExtendedData($page);
				//$item['attribute:number'] = $number;
				$item['attribute:id'] = $page->id;
				$item['attribute:date_video_change'] = $page->date_video_change;
				$item['attribute:name'] = $page->name;
				$item['attribute:link'] = $page->link;
				$item['attribute:type_id'] = $page->getObjectTypeId();
				$item['attribute:parentId'] = $page->getParentId();
				$video_link = $page->ssylka_na_video;
				
				if (preg_match('~(?:v=|youtu\.be/|youtube\.com/embed/)([a-z0-9_-]+)~i', $video_link, $matches)) {
					$item['attribute:video_id'] = $matches[1];
				}
				$items['nodes:item'][] = $item;
			}//foreach
			
			$result['nodes:items'][] = $items;
			$result['nodes:type_id'][] = $type_id;
			$result['nodes:total'][] = $pages->length;
			$result['nodes:per_page'][] = $limit;
			return $result;
		}
		
		public function getDealers($typeId = 146){
			$result = array();
			$items = array();
			$ajax = getRequest('ajax')?true:false;
			$filter = getRequest('filter');
			$umiObjectsCollection = umiObjectsCollection::getInstance();
			//для сбора фильтруемых полей
			$points = new selector('objects');
			$points->types('object-type')->id($typeId);
			$points = $points->result();
			
			$filter_fields = ['country' => 'Страна', 'city' => 'Город', 'type' => 'Тип магазина'];
			$filter_data = [];
			foreach($points as $point){
				foreach($filter_fields as $filter_field_name => $filter_field_title){
				
					$filter_field_value_id = $point->getValue($filter_field_name);
					if(!$filter_field_value_id)continue;
					$filter_field_value = $umiObjectsCollection->getObject($filter_field_value_id);
					if($filter_field_value){
						$filter_field_value = $filter_field_value->getName();
					}
					$item = ['@name' => $filter_field_name, '@title' => $filter_field_title, '@value' => $filter_field_value, '@id' => $filter_field_value_id];
					
					if($filter){
						if(isset($filter[$filter_field_name])){
							if(is_array($filter[$filter_field_name])){
								if(in_array($filter_field_value, $filter[$filter_field_name])){
									$item['@is-selected'] = 'is-selected';
								}
							}else if($filter[$filter_field_name] == $filter_field_value){
								$item['@is-selected'] = 'is-selected';
							}
						}
					}
					$filter_data[$filter_field_name][$filter_field_value_id] = $item;
				}
			}
			$r = [];
			foreach($filter_data as $filter_field_name => $filter_data_value){
				$t = [];
				foreach($filter_data_value as $filter_field_value_id => $item){
					$filter_field_title = $item['@title'];
					$filter_field_name = $item['@name'];
					
					$t['nodes:item'][] = $item;
				}
				$r['nodes:field'][] = ['@name' => $filter_field_name, '@title' => $filter_field_title, 'value' => $t];
			}
			if(!empty($r)){
				$result['nodes:filter'][] = $r;
			}
			//var_dump($r);exit;
			//сдля отображения выбранных
			$points = new selector('objects');
			$points->types('object-type')->id($typeId);
			selectorHelper::detectFilters($points);
			$points = $points->result();
            
            foreach($points as $point){
				$item = $this->getExtendedData($point);
				$item['attribute:id'] = $point->getId();
				$item['attribute:name'] = $point->getName();
				$items['nodes:item'][] = $item;
			}
			if(!empty($items)){
				$result['nodes:items'][] = $items;
			}
			return $result;
			
			$result = $this->transformData($t, 'form.xsl');
			
			$this->sendHtmlResponse($html);
 		}
 		
		public function transformData($data = [], $xsl = false){
			$result = '';
			if($xsl != false){
				$dom = new DOMDocument('1.0', 'utf-8');
				$rootNode = $dom->createElement('udata');
				$dom->appendChild($rootNode);
				$translator = new xmlTranslator($dom);
				$translator->translateToXml($rootNode, $data);
				$xml = $dom->saveXML();
				$xsltDom = new DomDocument;
				$xsltDom->resolveExternals = true;
				$xsltDom->substituteEntities = true;
				$filePath = CURRENT_WORKING_DIR . '/templates/stilfort.com/xslt/modules/content/'.$xsl;
				$xsltDom->load($filePath, DOM_LOAD_OPTIONS);
				$xslt = new xsltProcessor;
				$xslt->registerPHPFunctions();
				$xslt->importStyleSheet($xsltDom);
				$dom_new = new DOMDocument("1.0", "utf-8");
				$dom_new->loadXML($xml);
				$result = $xslt->transformToXML($dom_new);
			}
			return $result;
		}
		
		public function sendHtmlResponse($response = ''){
			$buffer = outputBuffer::current();
			$buffer->charset('utf-8');
			$buffer->contentType('text/html');
			$buffer->clear();
			$buffer->push($response);
			$buffer->end();
		}
		
		public function getInstagramInfo($code = '', $limit = 8){
			$result = [];
			$items = [];
			$url = 'https://www.instagram.com/'. $code. '/?__a=1';
			$json = umiRemoteFileGetter::get($url);
			try {
				$json = json_decode($json, true);
				if(is_array($json)){
					if(isset($json['graphql']['user']['edge_owner_to_timeline_media']['edges'])){
						$edges = $json['graphql']['user']['edge_owner_to_timeline_media']['edges'];
						if(is_array($edges)){
							foreach($edges as $edge){
								$item = [];
								if(isset($edge['node']['shortcode'])){
									$item['attribute:shortcode'] = $edge['node']['shortcode'];
								}
								if(isset($edge['node']['thumbnail_src'])){
									$item['attribute:img'] = $edge['node']['thumbnail_src'];
								}
								if(isset($edge['node']['edge_media_to_caption']['edges'][0]['node']['text'])){
									$text = $edge['node']['edge_media_to_caption']['edges'][0]['node']['text'];
									$item['attribute:text'] = $text;//mb_substr($text, 0, 1000);
								}
								$items['nodes:item'][] = $item;
								$limit--;
								if($limit <= 0 )break;
							}
						}
					}
				}
			} catch (coreException $exception) {
				//umiExceptionHandler::report($exception);
				//return '';
			}
			if(!empty($items)){
				$result['nodes:items'][] = $items;
			}
			return $result;
		}
		public function xsltCache($expire = 3600, $stream){
			$params_temp = array_slice(func_get_args(), 2);
			$params = array();
		
			foreach($params_temp as $param){
				$params[] = (strpos($param, '/') !== FALSE) ? "(" . $param . ")" : $param;
			}
		
			$domain = cmsController::getInstance()->getCurrentDomain()->getId();
			$params_str = implode('/', $params);
			$url = $stream . "://" . $params_str;
			$requestParams = array();
			$allowedParams = array('extProps', 'extGroups');
		
			foreach($_REQUEST as $param => $value) {
				if(!in_array($param, $allowedParams))
					continue;
				$requestParams[$param] = $value;
			}
		
				if(count($requestParams)) {
					$url .= '/?'. http_build_query($requestParams);
				}
		
			$folder = CURRENT_WORKING_DIR . '/sys-temp/udatacache/';
			$path = $folder . md5($domain. '_'. $url) . '.xml';
		
			if(!is_dir($folder)) mkdir($folder, 0777, true);
			if(is_file($path)) $mtime = filemtime($path);
			if(!is_file($path) || time() > ($mtime + $expire)) {
				$data = file_get_contents($url);
				file_put_contents($path, $data);
				return array('plain:result' => $data);
			}else{
				$result = file_get_contents($path);
				return array('plain:result' => $result);
			}
		
		}
		/*
		Все поля из модуля настройки
		*/
		public function getSettings($settingsId = 'settings'){
			$settings = cmsController::getInstance()->getModule('umiSettings');
			$settingsContainerId = $settings->getIdByCustomId($settingsId, 1);
			$oSettings = umiObjectsCollection::getInstance()->getObject($settingsContainerId);
			$result = array();
			if($oSettings instanceof umiObject){
				$typeId = $oSettings->getTypeId();
				$type  = umiObjectTypesCollection::getInstance()->getType($typeId);
				$groups = $type->getFieldsGroupsList();
				foreach($groups as $group){
					$groupitems = array();
					$items = array();
					$groupitems['attribute:name'] = $group->getName();
					$groupitems['attribute:title'] = $group->getTitle();
					foreach($group->getFields() as $field){
					$item = array();
					$extProp = $oSettings->getPropByName($field->getName());
					if($extProp->getValue() !== false)
						$item = $extProp;
					
						$items['nodes:property'][] = $item;
					}
					$groupitems['nodes:properties'][] = $items;
					$result['nodes:group'][] = $groupitems;
				}
			}
			return $result;
		}
		/*
		Получить список страниц по параметрам
		*/
		public function getPageByType($type_id = false, $limit = false, $parent_id = false, $filedNameValue = false, $mincount = 1, $groupBy = false){
			$mincount = (int)$mincount;
			$result = array();
			$items = array();
			$p=0;
			if(getRequest('p'))$p=getRequest('p');
			$number = 0;
			
			$pages = new selector('pages');
			if($type_id)
				$pages->types('object-type')->id($type_id);
			if(($parent_id!==false)&&($parent_id!==''))
				$pages->where('hierarchy')->page($parent_id)->childs(1);
			if($filedNameValue){
				$filedNameValue = explode(':',$filedNameValue);
				if(count($filedNameValue)===2){
					$pages->where($filedNameValue[0])->equals($filedNameValue[1]);
				}
			}
			if($limit){
				$pages->limit($p*$limit, $limit);
				$number = $p*$limit;
			}
			$count = 1;
			foreach($pages as $page){
				//if($type_id&&(!($page->getObjectTypeId() === (int)$type_id)))continue;
				$number++;
				$item = $this->getExtendedData($page);
				$item['attribute:number'] = $number;
				$item['attribute:id'] = $page->id;
				$item['attribute:name'] = $page->name;
				$item['attribute:link'] = $page->link;
				$item['attribute:type_id'] = $page->getObjectTypeId();
				$item['attribute:parentId'] = $page->getParentId();
				
				$items['nodes:item'][] = $item;
				if($groupBy){
					if($count == $groupBy){
						$result['nodes:items'][] = $items;
						$items = array();
						$count = 0;
					}
					$count++;
					continue;
				}
			}//foreach
			if($groupBy){
				$result['nodes:items'][] = $items;
			}
			if(!empty($items)&&(!$groupBy)){
				if(count($items['nodes:item']) < $mincount){
					$result = $items;
					while(count($result['nodes:item']) < $mincount){
						//var_dump(count($result['nodes:item']));
						foreach($items['nodes:item'] as $item){
							$result['nodes:item'][] = $item;
						}
					}
					$items = $result;
					$result = array();
				}
				$items['attribute:type_id'] = $type_id;
				$result['nodes:items'][] = $items;
			}
			$result['attribute:type_id'] = $type_id;
			if(($parent_id!==false)&&($parent_id!==''))
				$result['nodes:parentId'][] = $parent_id;
				
			$result['nodes:type_id'][] = $type_id;
			$result['nodes:total'][] = $pages->length;
			$result['nodes:per_page'][] = $limit;
			return $result;
		}
		/*
		Получаем поля страниц привязанных через поле типа "ссылка на дерево"
		*/
		public function getRelFieldPages($page_id = null, $fieldName = null){
			$result = array();
			$items = array();
			if($page_id&&$fieldName){
				$umiHierarchy = umiHierarchy::getInstance();
				$page = $umiHierarchy->getElement($page_id);
				if($page instanceof umiHierarchyElement){
					$pagesId = $page->$fieldName;
					if(isset($pagesId)&&is_array($pagesId)&&(!empty($pagesId))){
						foreach($pagesId as $page){
							if(!($page instanceof umiHierarchyElement))continue;
							$item = $this->getExtendedData($page);
							$item['attribute:id'] = $page->id;
							$item['attribute:name'] = $page->name;
							$item['attribute:link'] = $page->link;
							$items['nodes:page'][] = $item;
						}
						$result['nodes:pages'][] = $items;
					}
				}
			}
			return $result;
		}
		
		public function getPageByCollection($page_id = false, $count = 5){
			if(!$page_id) $page_id = cmsController::getInstance()->getCurrentElementId();
			$hierarchy = umiHierarchy::getInstance();
			$page = $hierarchy->getElement($page_id);
			$kollekciya = $page->kollekciya;
			$parent_id = $page->getparentId();
			$type_id = $page->getObjectTypeId();
			$pages = new selector('pages');
			$pages->types('hierarchy-type')->name('catalog', 'object');
			$pages->where('kollekciya')->equals($kollekciya);
			$pages->order('ord');
			
			$result = array();
			$items = array();
			$start = false;
			$i=1;
			foreach($pages as $page){
				
				if($count === 0) break;
				
				if($page->id == $page_id){
					$start=true;
					
					continue;
				}
				if(!$start){$i++;;continue;}
				//if(!($type_id&&$page->getObjectTypeId()==$type_id))continue;
				$item = $this->getExtendedData($page);
				$item['attribute:id'] = $page->id;
				$item['attribute:name'] = $page->name;
				$item['attribute:link'] = $page->link;

				$items['nodes:item'][] = $item;
				$count--;
			}//foreach
			//добавляем из начала если не хватило
			if($count>0){
			foreach($pages as $page){
				if($count === 0) break;
				if($page->id == $page_id)break;
				if(!$start)continue;
				//if(!($type_id&&$page->getObjectTypeId()==$type_id))continue;
				$item = $this->getExtendedData($page);
				$item['attribute:id'] = $page->id;
				$item['attribute:name'] = $page->name;
				$item['attribute:link'] = $page->link;
				$items['nodes:item'][] = $item;
				$count--;
			}//foreach
			}
			if(!empty($items)){
				/*if(count($items['nodes:item'] < $mincount)){
					$result = $items;
					while(count($result['nodes:item']) < $mincount){
						//var_dump(count($result['nodes:item']));
						foreach($items['nodes:item'] as $item){
							$result['nodes:item'][] = $item;
						}
					}
					$items = $result;
					$result = array();
				}*/
				$items['attribute:type_id'] = $type_id;
				$result['nodes:items'][] = $items;
			}
			$result['nodes:type_id'][] = $type_id;
			$result['nodes:position'][] = $i;
			$result['nodes:total'][] = $pages->length;
			return $result;
		}
		
		public function getOtherPage($page_id = false, $count = 5){
			if(!$page_id) $page_id = cmsController::getInstance()->getCurrentElementId();
			$hierarchy = umiHierarchy::getInstance();
			$page = $hierarchy->getElement($page_id);
			$parent_id = $page->getparentId();
			$type_id = $page->getObjectTypeId();
			if($parent_id!==false){
				$pages = new selector('pages');
				$pages->types('object-type')->id($type_id);
				$pages->where('hierarchy')->page($parent_id)->childs(1);
				//$pages->where('kategoriya')->equals($parent_id);
				//$pages->where('id')->notequals($page_id);
				$pages->order('ord');
				//$parent_id =$hierarchy->getElement($parent_id)->getObjectId();
			}
			
			$result = array();
			$items = array();
			$start = false;
			$i=1;
			foreach($pages as $page){
				
				if($count === 0) break;
				
				if($page->id == $page_id){
					$start=true;
					
					continue;
				}
				if(!$start){$i++;;continue;}
				if(!($type_id&&$page->getObjectTypeId()==$type_id))continue;
				$item = $this->getExtendedData($page);
				$item['attribute:id'] = $page->id;
				$item['attribute:name'] = $page->name;
				$item['attribute:link'] = $page->link;

				$items['nodes:item'][] = $item;
				$count--;
			}//foreach
			//добавляем из начала если не хватило
			if($count>0){
			foreach($pages as $page){
				if($count === 0) break;
				if($page->id == $page_id)break;
				if(!$start)continue;
				if(!($type_id&&$page->getObjectTypeId()==$type_id))continue;
				$item = $this->getExtendedData($page);
				$item['attribute:id'] = $page->id;
				$item['attribute:name'] = $page->name;
				$item['attribute:link'] = $page->link;
				$items['nodes:item'][] = $item;
				$count--;
			}//foreach
			}
			if(!empty($items)){
				/*if(count($items['nodes:item'] < $mincount)){
					$result = $items;
					while(count($result['nodes:item']) < $mincount){
						//var_dump(count($result['nodes:item']));
						foreach($items['nodes:item'] as $item){
							$result['nodes:item'][] = $item;
						}
					}
					$items = $result;
					$result = array();
				}*/
				$items['attribute:type_id'] = $type_id;
				$result['nodes:items'][] = $items;
			}
			$result['nodes:type_id'][] = $type_id;
			$result['nodes:position'][] = $i;
			$result['nodes:total'][] = $pages->length;
			return $result;
		}

		/*
		Получаем поля объектов привязанных через поле типа "Выпадающий справочник со множественным выбором"
		*/
		public function getRelFieldObjects($page_id = null, $fieldName = null){
			$result = array();
			$items = array();
			if($page_id&&$fieldName){
				$result['attribute:pageId'] = $page_id;
				$result['attribute:field'] = $fieldName;
				$items['attribute:id'] = $page_id.$fieldName;
				$umiHierarchy = umiHierarchy::getInstance();
				$objectsCollection = umiObjectsCollection::getInstance();
				$page = $umiHierarchy->getElement($page_id);
				if($page instanceof umiHierarchyElement){
					$ObjectsId = $page->$fieldName;
					if(isset($ObjectsId)&&is_array($ObjectsId)&&(!empty($ObjectsId))){
						foreach($ObjectsId as $objectId){
							$object = $objectsCollection->getObject($objectId);
							$item = $this->getExtendedData($object);
							$item['attribute:id'] = $object->id;
							$item['attribute:name'] = $object->getName();
							$item['attribute:type_id'] = $object->getTypeId();
							$items['nodes:item'][] = $item;
						}
						$result['nodes:items'][] = $items;
					}
				}
			}
			return $result;
		}
		
		public function getSiblings($page_id = null){
			$result = array();
			$hierarchy = umiHierarchy::getInstance();
			$pageCurrent = $hierarchy->getElement($page_id);
			$parent_id = $pageCurrent->getparentId();
			$type_id = $pageCurrent->getObjectTypeId();
			if($parent_id!==false){
				$pages = new selector('pages');
				$pages->types('object-type')->id($type_id);
				$pages->where('hierarchy')->page($parent_id)->childs(1);
				$pages->order('ord');
				$pages = $pages->result;
				$ar_ElementID = array();
				foreach($pages as $page){
					$ar_ElementID[] = $page->id;
				}
				// находим текущий ключ
				$i_KeyCurrent =	array_search($page_id, $ar_ElementID);
				// кол-во элементов в массиве
				$i_CountElement = count($ar_ElementID);
				// слудеющий ID	
				if($i_KeyCurrent !== ($i_CountElement -1) )
				{
					$nextPage = $pages[ $i_KeyCurrent + 1 ];
				}	
				else 
				{
					$nextPage = $pages[0];
				}	
					
				// предыдущий ID
				if($i_KeyCurrent == 0 )
				{
					$prevPage = $pages[$i_CountElement - 1];
				}	
				else
				{
					$prevPage = $pages[$i_KeyCurrent - 1];
				}
				if($page_id != $prevPage->id){
					$item = array();
					$item['attribute:id'] = $prevPage->id;
					$item['attribute:name'] = $prevPage->name;
					$item['attribute:link'] = $prevPage->link;
					$result['nodes:prev'][] = $item;
				}
				if($page_id != $nextPage->id){
					$item = array();
					$item['attribute:id'] = $nextPage->id;
					$item['attribute:name'] = $nextPage->name;
					$item['attribute:link'] = $nextPage->link;
					$result['nodes:next'][] = $item;
				}
			}
			return $result;
		}
		
		public function getExtendedData($entity = false, $arr = false){
			$result = array();
			$extProps = explode(",", getRequest('extProps'));
			$extGroups = explode(",", getRequest('extGroups'));
			if (is_array($arr)) {
				$result = $arr;
			}
			if($entity instanceof umiObject){
				//nothing
			}else if($entity instanceof umiHierarchyElement){
				$entity = $entity->getObject();
			}else{
				$entity = false;
			}
			if($entity){
				//def_module::parseTemplate
				$extPropsInfo = [];
				foreach ($extProps as $fieldName) {
					if (strlen($fieldName) < 2) continue;
					if ($fieldName == 'name' && !isset($result['attribute:name'], $result['@name'])) {
						$result['@name'] = $entity->getName();
					} elseif ($extProp = $entity->getPropByName($fieldName)) {
						$val = $extProp->getValue();
						if ($val === null || $val === false || $val === '') {
							continue;
						}
						$extPropsInfo[] = $extProp;
					}
				}
				if(!empty($extPropsInfo))$result['extended']['properties']['nodes:property'] = $extPropsInfo;
				$extPropsInfo = [];
				foreach ($extGroups as $groupName) {
					if (strlen($groupName) < 2) continue;
					if($extGroup = $entity->getPropGroupByName($groupName)) {
						foreach($extGroup as $fieldId){
							$extProp = $entity->getPropById($fieldId);
							$val = $extProp->getValue();
							if ($val === null || $val === false || $val === '') {
								continue;
							}
							$extPropsInfo[] = $extProp;
						}
						$extGroupsInfo['attribute:name'] = $groupName;
						$extGroupsInfo['nodes:property'] = $extPropsInfo;
					}
					if(!empty($extGroupsInfo)) $result['extended']['groups']['nodes:group'][] = $extGroupsInfo;
				}
			}
			return $result;
		}
		
		/*
		*	Превью, которое ставит картинку по ценру, а фон заливает белым
		*/
		public function makeThumbnailNew($path, $width = 'auto', $height = 'auto', $template = "default", $returnArrayOnly = false, $flags = 0, $quality = 75, $logo = false) {
			if(!$template) $template = "default";
			$flags = (int)$flags;
			$image = new umiImageFile($path);


			$file_name = $image->getFileName();
			$file_ext = strtolower($image->getExt());
			$file_ext = ($file_ext=='bmp'?'jpg':$file_ext);

			$thumbPath = sha1($image->getDirName());
			//$thumbPath = substr($thumbPath, 0, 2) . '/'. substr($thumbPath, 2, 2) .'/'. $thumbPath;//Добавляем вложенность чтобы не копилось в одной папке
			
			if (!is_dir($_SERVER['DOCUMENT_ROOT'].'/images/thumbs/'.$thumbPath)) {
				mkdir($_SERVER['DOCUMENT_ROOT'].'/images/thumbs/'.$thumbPath, 0755, true);
			}

			$allowedExts = Array('gif', 'jpeg', 'jpg', 'png', 'bmp');
			//var_dump($path); exit;
			if(!in_array($file_ext, $allowedExts)) return "";

			$file_name = substr($file_name, 0, (strlen($file_name) - (strlen($file_ext) + 1)) );
			$file_name_new = $file_name . "_" . $width . "_" . $height . "_" .$image->getExt(). "." . $file_ext;
			$path_new = $_SERVER['DOCUMENT_ROOT'].'/images/thumbs/' .$thumbPath."/". $file_name_new;
			//if(!file_exists($path_new) || filemtime($path_new) < filemtime($path)) {
			if(true) {
				if(file_exists($path_new)) {
					unlink($path_new);
				}
				$width_src = $image->getWidth();
				$height_src = $image->getHeight();

				if(!($width_src && $height_src)) {
					throw new coreException(getLabel('error-image-corrupted', null, $path));
				}

				if(!$width_src) return false;

				
				$size = getimagesize($path);//узнаем размеры картинки (дает нам масив size)

				if($width == 'auto'){
					$width = (int)($height*$width_src)/$height_src;//$size[0];
				}

				if($height == 'auto'){
					$height = (int)($width*$height_src)/$width_src;//$size[1];
				}
				
				
				$format = strtolower(substr($size['mime'], strpos($size['mime'], '/')+1)); //определяем тип файла
				$icfunc = "imagecreatefrom" . $format;   //определение функции соответственно типу файла
				if($format == "x-ms-bmp"){
					$icfunc = "imagecreatefromxbm";
				}
				//var_dump($icfunc); exit;
				if (!function_exists($icfunc)) return false;  //если нет такой функции прекращаем работу скрипта
				
				$x_ratio = $width / $size[0]; //пропорция ширины будущего превью
				$y_ratio = $height / $size[1]; //пропорция высоты будущего превью
				
				$ratio       = min($x_ratio, $y_ratio);
				$use_x_ratio = ($x_ratio == $ratio); //соотношения ширины к высоте
				
				$new_width   = $use_x_ratio  ? $width  : floor($size[0] * $ratio); //ширина превью
				$new_height  = !$use_x_ratio ? $height : floor($size[1] * $ratio); //высота превью
				
				$new_left    = $use_x_ratio  ? 0 : floor(($width - $new_width) / 2); //расхождение с заданными параметрами по ширине
				$new_top     = !$use_x_ratio ? 0 : floor(($height - $new_height) / 2); //расхождение с заданными параметрами по высоте
				
				//$new_left=0;
				//$new_top=0;
				//$new_width   = floor($size[0] * $ratio); //ширина превью
				//$new_height  = floor($size[1] * $ratio); //высота превью
				
				$img = imagecreatetruecolor($width, $height); //создаем вспомогательное изображение пропорциональное превью
				//$rgb=0xffffff; //цвет заливки несоответствия
				$transparent = imagecolorallocatealpha($img, 255, 255, 255, 127);
				//imagefill($img, 0, 0, $rgb); //заливаем его…
				imagefill($img, 0, 0, $transparent);
 				imagesavealpha($img, true); // save alphablending setting (important);
				$photo = $icfunc($path); //достаем наш исходник
				imagecopyresampled($img, $photo, $new_left, $new_top, 0, 0, $new_width, $new_height, $size[0], $size[1]); //копируем на него нашу превью с учетом расхождений
				switch($format){
					case 'gif':
						$res = imagegif($img, $path_new);
						break;
					case 'png':
						$res = imagepng($img, $path_new);
						break;
					default:
						$res = imagejpeg($img, $path_new, $quality);
				}
				//imagejpeg($img); //выводим результат (превью картинки)
				// Очищаем память после выполнения скрипта
				imagedestroy($img);
				imagedestroy($photo);
			}

			//Parsing
			$value = new umiImageFile($path_new);
			if($logo){
				umiImageFile::addWatermark($path_new);
			}
			$arr = Array();
			$arr['size'] = $value->getSize();
			$arr['filename'] = $value->getFileName();
			$arr['filepath'] = $value->getFilePath();
			$arr['src'] = $value->getFilePath(true);
			$arr['ext'] = $value->getExt();
			$arr['original'] = $image->getFilePath(true);
			$arr['width'] = $value->getWidth();
			$arr['height'] = $value->getHeight();

			$arr['void:template'] = $template;

			if(cmsController::getInstance()->getCurrentMode() == "admin") {
				$arr['src'] = str_replace("&", "&amp;", $arr['src']);
			}

			if($returnArrayOnly) {
				return $arr;
			} else {
				list($tpl) = def_module::loadTemplates("thumbs/".$template, "image");
				return def_module::parseTemplate($tpl, $arr);
			}
		}
		

	}
