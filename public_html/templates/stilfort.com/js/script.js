var onloadCallback = function() {
	let elements = document.getElementsByClassName('g-recaptcha');
	for (let i = 0; i < elements.length; i += 1) {
		if (elements[i]) {
			var captcha = elements[i];
			var id = captcha.id;
			try{
				window[id] = grecaptcha.render(captcha, {
					'sitekey' : site_key
				});
			}catch(err){
			}
		}
	}
};
var resetCaptcha = function() {
	let elements = document.getElementsByClassName('g-recaptcha');
	for (let i = 0; i < elements.length; i += 1) {
		if (elements[i]) {
			var captcha = elements[i];
			var id = captcha.id;
			try{
				if(window[id]){
					grecaptcha.reset(window[id]);
				}else{
					window[id] = grecaptcha.render(captcha, {
						'sitekey' : site_key
					});
				}
			}catch(err){
			}
		}
	}
};
function jsonPostRequest(url, callback, data){
	if(!data)data={};
	$.ajax({
		type: "POST",
		url: url,
		data: data,
		dataType:'json',
		success: function(data){
			if(callback){
				callback(data);
			}
		},
		error: function(data){
			return false;
		}
	});
}
(function( $ ) {
	$.fn.drawmessages = function(data) {
		var $form = this;
		var wrap = "<div class='alert alert-danger'>";
		var message = '';
		if(typeof data.result === 'number'){
			switch( data.result){
				case 0:wrap="<div class='alert alert-danger'>";break;
				case 1:wrap="<div class='list-success'>";break;
				default:wrap="<div class='list-message'>";break;
			}
		}
		if(data.message){
			switch(typeof data.message){
				case 'string':message = '<div>'+data.message+'</div>';break;
				case 'object':for(var i in data.message){
					message += '<div>'+data.message[i]+'</div>';
				}
				break;
				default:;
			}
			$form.find('.status').html(wrap+message+"</div>");
		}
		return $form;
	};
})(jQuery);

function validateform($form){
	var valid = true;
	
	var msg = {
		required: 'Это поле обязательно для заполнения',
		email: 'Укажите e-mail',
		phone: 'Укажите корректный телефон',
		captcha: 'Неверный код проверки',
		error: 'Во время отправки формы возникли ошибки.',
		success: 'Ваше сообщение отправлено.'
	};
	$form.find('.input_error').remove();
	$form.find('input:visible, textarea:visible, select').each(function() {
		$(this).closest('.form__textarea,.modal-form-group,.form__input').removeClass('has-error').addClass('has-successs');
		if($(this).attr('required') == 'required') {
			switch(this.type){
				case 'checkbox':
					if(this.checked == false){
						valid = false;
						$(this).addClass('error').closest('.form__textarea,.modal-form-group,.form__input').removeClass('has-successs').addClass('has-error');
						var options = $(this).data();
						var message = msg.required;
						//$(this).after('<div class="input_error input-group-addon">' + message + '</div>');
					}
					break;
				case 'select-one':
					if(this.value == undefined || this.value==0){
						valid = false;
						$(this).addClass('error').closest('.form__textarea,.modal-form-group,.form__input').removeClass('has-successs').addClass('has-error');
						var options = $(this).data();
						var message = msg.required;
						//$(this).after('<div class="input_error input-group-addon">' + message + '</div>');
					}
					break;
				default:
					if(this.value=='' || this.value==0){
						valid = false;
						$(this).addClass('error').closest('.form__textarea,.modal-form-group,.form__input').removeClass('has-successs').addClass('has-error');
						var options = $(this).data();
						var message = msg.required;
						//$(this).after('<div class="input_error input-group-addon">' + message + '</div>');
					}
			}
		}
		if($(this).hasClass('email')) {
			var re = /.+@.+\..+/;
			if(this.value.length < 5 || !re.test(this.value)){
				valid = false;
				$(this).addClass('error').closest('.form__textarea,.modal-form-group,.form__input').removeClass('has-successs').addClass('has-error');
				var options = $(this).data();
				var message = msg.email;
				//$(this).after('<div class="input_error input-group-addon">' + message + '</div>');
			}
		}
	});
	if(!valid) {
		$(".has-error", $form).first().focus();
	}
	return valid;
}
$(function() {
	
	
	$(document).on('submit', '.js-form', function(event) {
		event.preventDefault();
		var $form = $(this);
		var valid = validateform($form);

		if(valid){
			var url = $form.attr('action');
			var data = $form.serializeArray();
			data.push({name:'ajax', value: 1});
			$.ajax({
				url: '/udata/webforms/sendmsg/.json',
				data: data,
				success: function(data){
					//resetCaptcha();
					$form.drawmessages(data);
					if(data.result == 1){
						$form.trigger('reset');
						//success();
						$('#thanks').modal('show');
					}else{
						
						for (i in data.invalids) {
							var invalid = data.invalids[i];
							$('#field_'+invalid.id).addClass('not-valid');
						}
					}
				},
				type: "POST",
				dataType: "json"
			});
		}
		return false;
	});
	
	$(document).on('submit', '.js-modal-form', function(event) {
		event.preventDefault();
		var $form = $(this);
		var valid = validateform($form);
		
		if(valid){
			var url = $form.attr('action');
			var data = $form.serializeArray();
			data.push({name:'ajax', value: 1});
			$.ajax({
				url: '/udata/webforms/sendmsg/.json',
				data: data,
				success: function(data){
					//resetCaptcha();
					$form.drawmessages(data);
					if(data.result == 1){
						$form.trigger('reset');
						//success();
						var form_id = $form.closest('.modal').attr('id');
						//$('#'+form_id).modal('hide');
						//$('#thanks').modal('show');
					}else{
						
						for (i in data.invalids) {
							var invalid = data.invalids[i];
							$('#field_'+invalid.id).addClass('not-valid');
						}
					}
				},
				type: "POST",
				dataType: "json"
			});
		}
		return false;
	});
	
	$(document).on('click', '.js-submit', function(){
		var $form = $(this).closest('form');
		var valid = validateform($form);
		
		if(valid){
			$form.trigger('submit');
		}
		return false;
	});

});

$(function(){
	function loadCatalogObjects(url, replace){
		if($('.js-filter.active').length){
			var param_1 = $('.js-filter.active').attr('href').split('?');
			var param_2 = url.split('?');
			if(param_1[0]&&param_2[1]){
				url = param_1[0]+'?'+param_2[1];
			}
		}
		
		$.ajax({
			url: url,
			success: function(data, status){
				var html = $(data).find('.results__content>.results__list').eq(0).html();
				if(replace){
					$('.results__content>.results__list').html(html?html:'');
				}else{
					$('.results__content>.results__list').append(html);
				}
				
				var navigation = $(data).find('.results__content .pagination_wrap').eq(0).html();
				$('.results__content .pagination_wrap').html(navigation?navigation:'');
				//if($('.results__content .navigation:first li.active').eq(0).next().children('a').length==0){$('.show_more_click').remove();}
				//notload = true;
			}
		});
	}
	
	$(document).on('click', '.js-filter', function(){
		$(this).siblings().removeClass('active');
		$(this).addClass('active');
		
		loadCatalogObjects($(this).attr('href'), true);
		return false;
	});
	
	$(document).on('click', '.results__content .js-show_more', function(){
		var container = $(this).closest('.results__content');
		loadCatalogObjects($(this).attr('href'), false);
		return false;
	});
});


$(function(){
	/*Получить список избранного и отметить на странице*/
	(function(){
		var url = '/udata://content/jsonGetFaforiteList/.json';
		jsonPostRequest(url,setFavoriteCheck);
	})();
	(function(){
		var url = '/udata://emarket/jsonGetCompareList/.json';
		jsonPostRequest(url,setCompareCheck);
	})();
	function addToFavorite(id){
		var url = '/udata://content/jsonAddToFaforiteList/'+id+'/.json';
		jsonPostRequest(url,setFavoriteCheck);
	}
	function removeFromFavorite(id){
		var url = '/udata://content/jsonRemoveFromFaforite/'+id+'/.json';
		jsonPostRequest(url,setFavoriteCheck);
	}
	function addToCompare(id){
		var url = '/udata://emarket/jsonAddToCompareList/'+id+'/.json';
		jsonPostRequest(url,setCompareCheck);
	}
	function removeFromCompare(id){
		var url = '/udata://emarket/jsonRemoveFromCompare/'+id+'/.json';
		jsonPostRequest(url,setCompareCheck);
	}
	
	function setFavoriteCheck(data){
		var count = 0;
		var names = [];
		$('.result__like,.products__like').each(function(){
			$(this).removeClass('active').find('i').removeClass('fa').addClass('far');
		});
		if(data.items){
			for (i in data.items['item']) {
				var item = data.items['item'][i];
				var id = item['id'];
				names.push(item['name']);
				$('.result__like>a[data-id="'+id+'"]').parent().addClass('active').find('i').removeClass('far').addClass('fa');
				$('.products__like>a[data-id="'+id+'"]').parent().addClass('active').find('i').removeClass('far').addClass('fa');
			}
		}
		
		if(data.count){
			$ ('.favorite_link').find('sup').text(data.count);
		}else{
			$('.favorite_link').find('sup').text('');
		}
		if(data.code == 0){
		}
		return;
	}
	function setCompareCheck(data){
		var count = 0;
		var names = [];
		$('.result__compare,.products__compare').each(function(){
			$(this).removeClass('active');
		});
		if(data.items){
			for (i in data.items['item']) {
				var item = data.items['item'][i];
				var id = item['id'];
				names.push(item['name']);
				$('.result__compare>a[data-id="'+id+'"]').parent().addClass('active');
				$('.products__compare>a[data-id="'+id+'"]').parent().addClass('active');
				
			}
		}
		if(data.count){
			$('.compare_link').find('sup').text(data.count);
		}else{
			$('.compare_link').find('sup').text('');
		}
		if(data.code == 0){
		}
		return;
	}
	
	$(document).on('click', '.result__like>a,.products__like>a', function(){
		var infavorite = $(this).parent().hasClass('active');
		var id = $(this).data('id');
		if(!id)return;
		if(infavorite){
			removeFromFavorite(id);
			$('.favorit_content .result__cell[data-id="'+id+'"]').remove();
		}else{
			addToFavorite(id);
		}
		return false;
	});
	$(document).on('click', '.result__compare>a,.products__compare>a', function(){
		var incompare = $(this).parent().hasClass('active');
		var id = $(this).data('id');
		if(!id)return;
			if(incompare){
			removeFromCompare(id);
		}else{
			addToCompare(id);
		}
		return false;
	});
	$(document).on('click', '.compare__remove', function(e){
		var id = $(this).data('id');
		$('.compare_'+id).remove();
		removeFromCompare(id);
		e.preventDefault();
		e.stopPropagation();
		return false;
	});
	$(document).on('click', '.favorite__remove', function(e){
		var id = $(this).data('id');
		$(this).parent().remove();
		removeFromFavorite(id);
		e.preventDefault();
		e.stopPropagation();
		return false;
	});
});

$(function(){
	$(document).on('change', 'form.results__selects select', function(){
		var $form = $(this).closest('form.results__selects');
		var filter_url = $form.serialize();
		
		var data = $form.serializeArray();
		var t = [];
		$.each(data,function(){
			if(this.value){
				t.push(this.name+'='+this.value);
			}
		});
		if(t.length){
			filter_url = '?' + t.join('&');
		}else{
			filter_url = '';
		}
		var url = window.location.pathname;
		var replace = true;
		
		url = url + filter_url;
		$.ajax({
			url: url,
			success: function(data, status){
				var html = $(data).find('.results__content>.results__list').eq(0).html();
				if(replace){
					$('.results__content>.results__list').html(html?html:'');
				}else{
					$('.results__content>.results__list').append(html);
				}
				
				var navigation = $(data).find('.results__content .pagination_wrap').eq(0).html();
				$('.results__content .pagination_wrap').html(navigation?navigation:'');
				//if($('.results__content .navigation:first li.active').eq(0).next().children('a').length==0){$('.show_more_click').remove();}
				//notload = true;
				history.pushState('', '', url);
			}
		});
	});

	if(typeof $.tooltipster == 'object'){
		$('.tooltip').tooltipster({
			animation: 'fade',
			delay: 200,
			theme: 'tooltipster-noir',
			trigger: 'hover',
			maxWidth: 320,
		});
	}
});