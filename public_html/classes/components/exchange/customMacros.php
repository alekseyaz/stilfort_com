<?php
	/**
	 * Класс пользовательских макросов
	 */
	class ExchangeCustomMacros {
		/**
		 * @var exchange $module
		 */
		public $module;
		
		
		public function setCategoryAfterImport(iUmiEventPoint $event){
			$element = $event->getRef("element");

			if (!$element instanceof umiHierarchyElement) {
				return false;
			}
			
			if ($event->getMode() == "after") {
				$photo = $element->photo;
				$need_save = false;
				/*if($photo){
					$element->foto_tovara = [$photo];
					$need_save = true;
				}*/
				
				$artikul = $element->artikul;
				if($artikul){
					$artikul = translit::convert($artikul, '-');
					$element->setAltName($artikul);
					$need_save = true;
				}
				
				if($need_save){
					$element->commit();
				}
			}
		}

	}
?>