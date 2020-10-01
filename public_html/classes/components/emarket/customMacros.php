<?php

	/** Класс пользовательских макросов */
	class EmarketCustomMacros {

		/** @var emarket $module */
		public $module;
		
		public function jsonGetCompareList($template = "default") {
			if (!$template) {
				$template = "default";
			}

			list(
				$template_block, $template_block_empty, $template_block_line, $template_block_link
				) = emarket::loadTemplates(
				"emarket/compare/{$template}",
				"compare_list_block",
				"compare_list_block_empty",
				"compare_list_block_line",
				"compare_list_block_link"
			);

			$result = array();
			$elements = $this->module->getCompareElements();
			$maxItemsCount = $this->module->iMaxCompareElements;

			if (sizeof($elements) == 0) {
				$result['void:max_elements'] = $maxItemsCount ? $maxItemsCount : getLabel('label-unlimited');

				if ($maxItemsCount) {
					$result['attribute:max-elements'] = $maxItemsCount;
				}

				return emarket::parseTemplate($template_block_empty, $result);
			}

			$items = [];
			$hierarchy = umiHierarchy::getInstance();
			$hierarchy->loadElements($elements);
			$umiLinksHelper = umiLinksHelper::getInstance();
			$umiLinksHelper->loadLinkPartForPages($elements);

			foreach ($elements as $element_id) {
				$el = $hierarchy->getElement($element_id);

				if (!$el instanceof iUmiHierarchyElement) {
					continue;
				}

				$items['item'][] = [
						'id' => $el->getId(),
						'link' => $umiLinksHelper->getLinkByParts($el),//$el->link,
						'name' => $el->getName(),
						'alt-name' => $el->getAltName()
				];
			}

			$result['compare_link'] = (sizeof($elements) >= 2) ? $template_block_link : "";
			$result['void:max_elements'] = $maxItemsCount ? $maxItemsCount : getLabel('label-unlimited');

			if ($maxItemsCount) {
				$result['attribute:max-elements'] = $maxItemsCount;
			}
			if(!empty($items)){
				$result['items'] = $items;
				$result['count'] = count($items['item']);
			}
			echo json_encode($result);exit;
			
			//$result['subnodes:items'] = $items;
			//return emarket::parseTemplate($template_block, $result);
		}
		
		/**
		 * Добавляет товар с сранению и выводит результат в буффер
		 */
		public function jsonAddToCompareList($element_id) {
			//$element_id = getRequest("param0");
			list($add_to_compare_tpl, $already_exists_tpl) = emarket::loadTemplates(
				"emarket/compare/default",
				"json_add_to_compare",
				"json_compare_already_exists"
			);

			$template = $this->module->add_to_compare($element_id) ? $add_to_compare_tpl : $already_exists_tpl;
			$block_arr = array(
				'id' => $element_id
			);

			$this->jsonGetCompareList();
			return null;
		}
		
		/**
		 * Убирает товар из сравнения и выводит результат в буффер
		 */
		public function jsonRemoveFromCompare($element_id) {
			//$element_id = getRequest("param0");
			$this->module->remove_from_compare($element_id);

			list($template) = emarket::loadTemplates(
				"emarket/compare/default",
				"json_remove_from_compare"
			);

			$block_arr = array(
				'id' => $element_id
			);

			$this->jsonGetCompareList();
			return null;
		}
		
		public function OnPriceValue($event) {
			$objectID = $event->getParam('object_id');
			$price = &$event->getRef('price');
			$cmsController = cmsController::getInstance();
			if ($cmsController->getCurrentMode() != "admin"){
				$objects = umiObjectsCollection::getInstance();
				$object = $objects->getObject($objectID);
				if($object instanceof umiObject) {
					$new_price = $object->new_price;
					if($new_price > 0){
						//$price = $new_price;
					}
				}
			}
		}
		
		/**
		 * Возвращает стоимость товара (объекта каталога)
		 * @param iUmiHierarchyElement $element товар
		 * @param bool $ignoreDiscounts игнорировать скидки
		 * @return Float
		 * @throws privateException
		 * @throws coreException
		 */
		/*public function getPrice(iUmiHierarchyElement $element, $ignoreDiscounts = false) {
			$price = $element->getValue('price');
			$new_price = $element->new_price;
			if($new_price > 0){
				$price = $new_price;
			}
			if (!$ignoreDiscounts) {
				$discount = itemDiscount::search($element);

				if ($discount instanceof discount) {
					$price = $discount->recalcPrice($price);
				}
			}

			return $price;
		}
		*/
		/**
		 * Возвращает стоимость товара с учетом скидок.
		 * @param null|int $elementId идентификатор товара (объекта каталога)
		 * @param string $template имя шаблона (для tpl)
		 * @param bool $showAllCurrency выводить во всех доступных валютах
		 * @return mixed|null
		 * @throws publicException
		 * @throws privateException
		 * @throws coreException
		 * @throws ErrorException
		 */
		/*public function price($elementId = null, $template = 'default', $showAllCurrency = true) {
			if (!$elementId) {
				return null;
			}
			// @var emarket|EmarketMacros $module
			$module = $this->module;

			$hierarchy = umiHierarchy::getInstance();
			$elementId = $module->analyzeRequiredPath($elementId);
			$element = $hierarchy->getElement($elementId);

			if (!$element instanceof iUmiHierarchyElement) {
				throw new publicException('Wrong element id given');
			}

			list($tpl_block) = emarket::loadTemplates(
				'emarket/' . $template,
				'price_block'
			);

			$result = [
				'attribute:element-id' => $elementId,
			];

			$discount = itemDiscount::search($element);

			if ($discount instanceof discount) {
				$result['discount'] = [
					'attribute:id' => $discount->getId(),
					'attribute:name' => $discount->getName(),
					'description' => $discount->getValue('description'),
				];
				$result['void:discount_id'] = $discount->getId();
			}

			$price = $module->formatPrice($element->getValue('price'), $discount);
			$currencyPrice = $module->formatCurrencyPrice($price);

			if ($currencyPrice) {
				$result['price'] = $currencyPrice;
			} else {
				$result['price'] = $price;
			}

			$result['price'] = $module->parsePriceTpl($template, $result['price']);
			$result['void:price-original'] = getArrayKey($result['price'], 'original');
			$result['void:price-actual'] = getArrayKey($result['price'], 'actual');

			if ($showAllCurrency) {
				$result['currencies'] = $module->formatCurrencyPrices($price);
				$result['currency-prices'] = $module->parseCurrencyPricesTpl($template, $price);
			}

			return emarket::parseTemplate($tpl_block, $result);
		}*/
	}
