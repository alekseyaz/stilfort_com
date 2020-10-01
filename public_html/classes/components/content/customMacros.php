<?php
	
	use UmiCms\Service;
	
	/** Класс пользовательских макросов */
	class ContentCustomMacros {

		/** @var content $module */
		public $module;
		
		public function getMarkets(){
			$cacheName = 'getMarkets';
			$cache = cacheFrontend::getInstance();
			//$result = $cache->loadData($cacheName);
			//if ($result)return $result;
			$result = [];
			$guideId_1 = 172;//онлайн
			$guideId_2 = 173;//розница
			/*$guides = [
				$guideId_1 => ['nazvanie_onlajn_magazin', 'logotip_onlajn_magazin', 'ssylka_onlajn_magazin', 'vyvodit_v_nachale_spiska'];
			]*/
			$umiObjectsCollection = umiObjectsCollection::getInstance();
			$custom_module = system_buildin_load('custom');
			
			$markets = new selector('objects');
			$markets->types('object-type')->id($guideId_1);
			$items = [];
			
			foreach($markets as $market){
				$item = $custom_module->getExtendedData($market);
				$item['attribute:id'] = $market->getId();
				$item['attribute:name'] = $market->getName();
				$items['nodes:item'][] = $item;
			}
			//var_dump($items);exit;
			if(!empty($items)){
				$items['attribute:name'] = 'Онлайн магазины';
				$result['nodes:online'][] = $items;
			}
			
			
			$markets = new selector('objects');
			$markets->types('object-type')->id($guideId_2);
			$items = [];
			$goroda = [];
			
			foreach($markets as $market){
				$gorod = $market->gorod;
				$goroda[] = $gorod;
				$item = $custom_module->getExtendedData($market);
				$item['attribute:id'] = $market->getId();
				$item['attribute:name'] = $market->getName();
				$item['attribute:letter'] = mb_substr($gorod, 0, 1);;
				$items['nodes:item'][] = $item;
			}
			if(!empty($items)){
				$items['attribute:name'] = 'Розничные магазины';
				$result['nodes:retail'][] = $items;
			}


			$goroda = array_unique($goroda);
			$t = [];
			foreach($goroda as $gorod){
				$letter = mb_substr($gorod, 0, 1);
				$t[$letter][] = $gorod;
			}
			
			
			foreach($t as $letter => $goroda){
				$items = [];
				$items['attribute:name'] = $letter;
				foreach($goroda as $gorod){
					$items['nodes:gorod'][] = ['attribute:name' => $gorod];
				}
				//var_dump($items);exit;
				$result['nodes:retail'][0]['nodes:letters'][0]['nodes:letter'][] = $items;
			}
			


			
			
			//$cache->saveData($cacheName, $result, 600);
			return $result;
		}
		
		/**
		 * Возвращает список последних просмотренных страниц
		 * @param string $template Шаблон для вывода
		 * @param string $scope Тэг(группировка страниц), без пробелов и запятых
		 * @param bool $showCurrentElement Если false - текущая страница не будет включена в результат
		 * @param int|null $limit Количество выводимых элементов
		 * @return mixed
		 */
		public function jsonGetFaforiteList($template = "default", $scope = "favorit", $showCurrentElement = false, $limit = null) {
			if (!$scope) {
				$scope = "favorit";
			}

			$hierarchy = umiHierarchy::getInstance();
			$currentElementId = cmsController::getInstance()->getCurrentElementId();
			$recentPages = \UmiCms\Service::Session()->get('content:recent_pages');
			$recentPages = (is_array($recentPages)) ? $recentPages : [];
			$items = [];

			if (!isset($recentPages[$scope])) {
				return content::parseTemplate($itemsTemplate, ["subnodes:items" => []]);
			}

			$pageIdList = [];

			foreach ($recentPages[$scope] as $pageId => $time) {
				$pageIdList[] = $pageId;
			}

			$hierarchy->loadElements($pageIdList);

			foreach ($recentPages[$scope] as $pageId => $time) {
				$element = $hierarchy->getElement($pageId, true);

				if (!($element instanceOf umiHierarchyElement)) {
					continue;
				}

				if (!$showCurrentElement && $element->getId() == $currentElementId) {
					continue;
				}

				if (!is_null($limit) && $limit <= 0) {
					break;
				}

				if (!is_null($limit)) {
					$limit--;
				}

				$items['item'][] = [
						'id' => $element->getId(),
						'link' => $element->link,
						'name' => $element->getName(),
						'alt-name' => $element->getAltName()
				];
			}
			$result = array();
			if(!empty($items)){
				$result['items'] = $items;
				$result['count'] = count($items['item']);
			}
			echo json_encode($result);exit;
			//return content::parseTemplate($itemsTemplate, ["subnodes:items" => $items]);
		}

		/**
		 * Добавляет страницу к списку последних просмотреных страниц
		 * @param int $elementId Текущая страница
		 * @param string $scope Тэг(группировка страниц)
		 * @return null
		 */
		public function jsonAddToFaforiteList($elementId, $scope = "favorit") {
			if (!$scope) {
				$scope = "favorit";
			}
//

			/*if ($elementId != cmsController::getInstance()->getCurrentElementId()) {
				return null;
			}*/

			$limit = mainConfiguration::getInstance()->get("modules", "content.recent-pages.max-items");
			$limit = $limit ? $limit : 100;

			$session = \UmiCms\Service::Session();
			$recentPages = $session->get('content:recent_pages');
			$recentPages = (is_array($recentPages)) ? $recentPages : [];

			if (!isset($recentPages[$scope])) {
				$recentPages[$scope] = [];
			}

			$recentPages[$scope][$elementId] = time();
			asort($recentPages[$scope]);
			$recentPages[$scope] = array_reverse($recentPages[$scope], true);
			$recentPages[$scope] = array_slice($recentPages[$scope], 0, $limit, true);

			$session->set('content:recent_pages', $recentPages);
			
			$this->module->jsonGetFaforiteList();
			return null;
		}

		/**
		 * Удаляет страницу из списка последних использований
		 * @param int|bool $elementId Id страницы
		 * @param string $scope Тэг
		 * @return bool
		 */
		public function jsonRemoveFromFaforite($elementId = false, $scope = "favorit") {
			if ($elementId === false) {
				$elementId = getRequest('param0');
			}

			if (!$scope) {
				$scope = "favorit";
			}

			$session = \UmiCms\Service::Session();
			$recentPages = $session->get('content:recent_pages');
			$recentPages = (is_array($recentPages)) ? $recentPages : [];

			if (isset($recentPages[$scope][$elementId])) {
				unset($recentPages[$scope][$elementId]);
				$session->set('content:recent_pages', $recentPages);

			}
			$this->module->jsonGetFaforiteList();
			//$this->module->redirect(getServer('HTTP_REFERER'));
		}
		
		/**
		 * Удаляет страницу из списка последних использований
		 * @param int|bool $elementId Id страницы
		 * @param string $scope Тэг
		 * @return bool
		 */
		public function delFavoriteAll($elementId = false, $scope = "favorit") {
			if ($elementId === false) {
				$elementId = getRequest('param0');
			}

			if (!$scope) {
				$scope = "favorit";
			}

			$session = \UmiCms\Service::Session();
			$recentPages = $session->get('content:recent_pages');
			$recentPages = (is_array($recentPages)) ? $recentPages : [];

			if (isset($recentPages[$scope])) {
				unset($recentPages[$scope]);
				$session->set('content:recent_pages', $recentPages);

			}

			$this->module->redirect(getServer('HTTP_REFERER'));
		}
	}
