<?php

	/** Класс пользовательских макросов */
	class WebFormsCustomMacros {

		/** @var webforms $module */
		public $module;
		
		public function prepareFormData(){
			$iFormTypeId = (int)getRequest('system_form_id');
			if($iFormTypeId === 151){
				$data = getRequest('data');
				if(isset($data['new']['order'])){
					$tmp = [];
					$order = $data['new']['order'];
					$order = explode(',', $order);
					$page_id = array_shift($order);
					$umiHierarchy = umiHierarchy::getInstance();
					$element = $umiHierarchy->getElement($page_id);
					if($element){
						if($element->getObjectTypeId() == 129){//catalog object
							$available_modifiers = $element->available_modifiers;
							if(is_array($available_modifiers)){
								$ObjectsCollection = umiObjectsCollection::getInstance();
								foreach($available_modifiers as $available_modifier_id){
									if(in_array($available_modifier_id, $order)){
										$available_modifier = $ObjectsCollection->getObject($available_modifier_id);
										$tmp[] = $available_modifier->getName();
									}
								}
							}
						}
						if(!empty($tmp)){
							$tmp = ' ('.implode(', ', $tmp).')';
						}else{
							$tmp = '';
						}
						$tmp = $element->name . $tmp;
						$_REQUEST['data']['new']['order'] = $tmp;
						$_GET['data']['new']['order'] = $tmp;
						$_POST['data']['new']['order'] = $tmp;
					}
				}
			}
		}
		/**
		 * Возвращает данные для создания формы обратной связи
		 * TODO рефакторинг
		 * @param bool|int|string $formId идентификатор или имя формы
		 * @param string|int $who e-mail адресата или идентификатор адреса
		 * @param string $template имя шаблона (для tpl)
		 * @return mixed
		 * @throws coreException
		 * @throws ErrorException
		 */
		public function add($formId = false, $who = '', $template = 'webforms') {
			$paramList = [];
			$umiObjectTypes = umiObjectTypesCollection::getInstance();
			$baseTypeId = $umiObjectTypes->getTypeIdByHierarchyTypeName('webforms', 'form');

			if (is_numeric($formId)) {
				if ($umiObjectTypes->getParentTypeId($formId) != $baseTypeId) {
					$formId = false;
				}
			}

			if (!is_numeric($formId) || $formId === false) {
				$children = $umiObjectTypes->getChildTypeIds($baseTypeId);

				if (empty($children)) {
					list($template) = webforms::loadTemplates(
						'data/reflection/' . $template,
						'error_no_form'
					);
					return $template;
				}

				$i = 0;
				do {
					$form = $umiObjectTypes->getType($children[$i]);
					$i++;
				} while (
					$i < umiCount($children) && $form->getName() != $formId
				);

				$formId = $form->getId();
			}

			$paramList['attribute:form_id'] = $formId;
			$paramList['attribute:template'] = $template;
			$who = (string) $who;

			if ($who !== '') {
				$addressId = $this->module->guessAddressId($who);

				if (func_num_args() > 3) {
					$extraAddressList = array_slice(func_get_args(), 3);

					foreach ($extraAddressList as &$address) {
						$address = $this->module->guessAddressId($address);
					}

					$extraAddressList = array_merge([$addressId], $extraAddressList);
					$paramList['res_to'] = $paramList['address_select'] = $this->module->writeSeparateAddresses($extraAddressList, $template);
				} else {
					$paramList['res_to'] =
					$paramList['address_select'] = '<input type="hidden" name="system_email_to" value="' . $addressId . '" />';
				}
			} else {
				$addressList = $this->module->writeAddressSelect($template, $formId);

				if (is_array($addressList)) {
					if (isset($addressList['items'])) {
						$paramList['items'] = $addressList['items'];
					} else {
						return;
					}
				} else {
					if (is_string($addressList) && $addressList !== '') {
						$paramList['address_select'] = $addressList;
					} else {
						return;
					}
				}
			}

			/** @var data|DataForms $dataModule */
			$dataModule = cmsController::getInstance()->getModule('data');
			$paramList['groups'] = $dataModule->getCreateForm($formId, $template);
			
			$MessageTemplate = $this->getTemplateByFormId($formId);
			if($MessageTemplate){
				foreach(['form_title', 'form_sub_title', 'form_img_right'] as $field_name){
					if($MessageTemplate->$field_name){
						$paramList['nodes:'.$field_name][] = $MessageTemplate->$field_name;
					}
				}
			}
			

			list($formBlock) = webforms::loadTemplates('data/reflection/' . $template, 'form_block');
			return webforms::parseTemplate($formBlock, $paramList);
		}

		
		/**
		 * Клиентский метод.
		 * Валидирует данные формы, создает объект сообщения
		 * и отправляет на адрес формы почтовое сообщение,
		 * сформированные по шаблону.
		 * При необходимости отправляет автоматическое
		 * почтовое уведомление.
		 * После выполнения перенаправляет на referrer.
		 * @return void|string
		 * @throws Exception
		 * @throws coreException
		 * @throws errorPanicException
		 * @throws privateException
		 * @throws publicAdminException
		 */
		public function sendmsg() {
			//var_dump($_POST);exit;
			$module = $this->module;
			$this->prepareFormData();
			$ajax_response = array();
			$ajax_response['result'] = 0;
			$ajax_response['message'] = 'Спасибо, Ваше сообщение успешно отправлено.';
			$valid = true;
			if (!umiCaptcha::checkCaptcha()) {
				$ajax_response['result'] = 0;
				$ajax_response['fields'] = 0;
				$ajax_response['message'] = 'Неверный код каптчи';
				$valid = false;
				//echo json_encode($ajax_response);exit();
				//$module->reportError("%errors_wrong_captcha%");
			}
			


			$oTypes = umiObjectTypesCollection::getInstance();
			$iBaseTypeId = $oTypes->getTypeIdByHierarchyTypeName("webforms", "form");
			$iFormTypeId = getRequest('system_form_id');
			$sSenderIP = getServer('REMOTE_ADDR');
			$iTime = new umiDate(time());
			$aAddresses = getRequest('system_email_to');

			if (!is_array($aAddresses)) {
				$aAddresses = array($aAddresses);
			}

			$aRecipients = array();
			$sAddress = null;
			$sEmailTo = null;

			foreach ($aAddresses as $address){
				$sEmailTo = $module->guessAddressValue($address);
				$sAddress = $module->guessAddressName($address);
				$aRecipients[] = array(
					'email' => $sEmailTo,
					'name' => $sAddress
				);
			}

			if ($oTypes->getParentTypeId($iFormTypeId) != $iBaseTypeId) {
				$ajax_response['result'] = 0;
				$ajax_response['message'] = 'Неверный тип';
				$this->sendJsonResponse($ajax_response);
				$module->reportError("%wrong_form_type%");
			}

			if (($ef = $module->checkRequiredFields($iFormTypeId)) !== true) {
				$ajax_response['result'] = 0;
				$ajax_response['message'] = 'Неверно заполнены поля';
				$fieldsCollection = umiFieldsCollection::getInstance();
				foreach($ef as $fieldId){
					$field = $fieldsCollection->getField($fieldId);
					$ajax_response['fields'][$fieldId] = 'Это поле обязательно для заполнения';//'Неверно заполнено поле '.$field->getTitle();
				}
				
				$this->sendJsonResponse($ajax_response);
				$module->reportError(getLabel('error-required_list') . $module->assembleErrorFields($ef), false);
			}
			if(!$valid){
				$this->sendJsonResponse($ajax_response);
			}
			
			$_REQUEST['data']['new']['sender_ip'] = $sSenderIP;
			$oObjectsCollection = umiObjectsCollection::getInstance();
			$iObjectId = $oObjectsCollection->addObject($sAddress, $iFormTypeId);
			$oObjectsCollection->getObject($iObjectId)->setOwnerId(permissionsCollection::getInstance()->getUserId());

			/**
			 * @var data|DataForms $data
			 */
			try {
				webforms::$noRedirectOnPanic = true;
				$data = cmsController::getInstance()->getModule('data');
				$data->saveEditedObject($iObjectId, true);
				webforms::$noRedirectOnPanic = false;
			} catch (errorPanicException $e) {
				$module->reportError($e->getMessage());
			}

			$oObject = $oObjectsCollection->getObject($iObjectId);
			$oObject->setValue('destination_address', $sEmailTo);
			$oObject->setValue('sender_ip', $sSenderIP);
			$oObject->setValue('sending_time', $iTime);
			$aMessage = $module->formatMessage($iObjectId, true);

			$module->sendMail($oObject, $aRecipients, $aMessage);
			if (strlen($aMessage['autoreply_template'])) {
				$module->sendAutoReply($aMessage);
			}

			$oEventPoint = new umiEventPoint("webforms_post");
			$oEventPoint->setMode("after");
			$oEventPoint->setParam("email", $aMessage['from_email_template']);
			$oEventPoint->setParam("message_id", $iObjectId);
			$oEventPoint->setParam("form_id", $iFormTypeId);
			$oEventPoint->setParam("fio", $aMessage['from_template']);
			webforms::setEventPoint($oEventPoint);
			
			
			if ($iFormTypeId && is_numeric($iFormTypeId)) {

				$sel = new selector('objects');
				$sel->types('object-type')->name('webforms', 'template');
				$sel->where('form_id')->equals($iFormTypeId);
				$sel->limit(0, 1);

				if ($sel->first) {
					/**
					 * @var iUmiObject|iUmiEntinty $oTemplate
					 */
					$oTemplate = $sel->first;
					$res = $oTemplate->getValue('posted_message');
					if($res)$ajax_response['message'] = $res;
				}
			}
			$ajax_response['result'] = 1;
			$this->sendJsonResponse($ajax_response);
			//return $this->finishSending($iObjectId);
		}
		
		public function getTemplateByFormId($iFormTypeId = false){
			$result = null;
			if ($iFormTypeId && is_numeric($iFormTypeId)) {
				$sel = new selector('objects');
				$sel->types('object-type')->name('webforms', 'template');
				$sel->where('form_id')->equals($iFormTypeId);
				$sel->limit(0, 1);
				if ($sel->first) {
					/**
					 * @var iUmiObject|iUmiEntinty $oTemplate
					 */
					$oTemplate = $sel->first;
					$result = $oTemplate;
				}
			}
			return $result;
		}
		
		protected function sendJsonResponse($response = array()){
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
	}
