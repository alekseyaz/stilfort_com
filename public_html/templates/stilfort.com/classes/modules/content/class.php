<?php
	use UmiCms\Service;
	
	class content_custom{

		public function setVideoChangeTime(iUmiEventPoint $event){
			$cmsController = cmsController::getInstance();
			if ($cmsController->getCurrentMode() !== "admin") {
				return;
			}
			$element = &$event->getRef('element');
			$inputData = &$event->getRef('inputData');
			static $ssylka_na_video = false;
			if ($event->getMode() == 'before') {
				$ssylka_na_video = $element->ssylka_na_video;
			}
			if ($event->getMode() == 'after') {
				if($ssylka_na_video != $element->ssylka_na_video){
					$element->date_video_change = time();
					$element->commit();
				}
			}
		}
		
		public function sendJsonResponse($response = array()){
			if($this->module->errorHasErrors()){
				foreach ($this->module->errorGetErrors() as $error) {
					$response['message'][] = getLabel($error['message']);
				}
			}
			
			$buffer = outputBuffer::current();
			$buffer->charset('utf-8');
			$buffer->contentType('application/jsonp');
			$buffer->clear();
			$buffer->push(json_encode($response));
			$buffer->end();
		}
		
		public function extGlobalVar(iUmiEventPoint $event){
			$cmsController = cmsController::getInstance();
			if ($cmsController->getCurrentMode() == "admin") {
				return;
			}
			$debug = in_array(getServer('REMOTE_ADDR'), ['109.252.55.105']);
			if ($event->getMode() == 'after') {
				$variables = &$event->getRef('variables');
				$variables['@year'] = date('Y');
				$variables['@protocol'] = getServerProtocol();
			}
		}
		
		public function getDefaultPageId(){
			$result = 0;
			$cmsController = cmsController::getInstance();
			$current_domain = $cmsController->getCurrentDomain();
			if(!$current_domain)return $result;
			$pages = new selector('pages');
			$pages->where('domain')->equals($current_domain->getId());
			$pages->where('is_default')->isnotnull(true);
			$pages->limit(0, 1);
			$pages = $pages->result();
			foreach($pages as $page){
				$result = $page->id;
			}
			return $result;
		}
		
		/**
		 * Возвращает относительный (от корневой директории, доступной в WEB) путь до директории с ресурсами шаблона
		 * @param string $workingDir корневая директория, относительно которой строится путь
		 * @return string
		 */
		public function getResourceDirectory($workingDir = CURRENT_WORKING_DIR) {
			$resourceDirAbsolutePath = cmsController::getInstance()->getResourcesDirectory();
			return $this->removeSubPathAtStart($workingDir, $resourceDirAbsolutePath);
		}
		
		/**
		 * Удаляет часть пути из его начала
		 * @param string $needle удаляемая часть пути
		 * @param string $haystack исходный путь
		 * @return string путь, полученный в результате удаления его части
		 */
		private function removeSubPathAtStart($needle, $haystack) {
			if (startsWith($haystack, $needle)) {
				return str_replace($needle, '', $haystack);
			}
			return $haystack;
		}
		
		/**
		 * Выводит текущий год
		 * @return string
		 */
		public function getCurrentYear() {
			return date('Y');
		}

		
	}
	
