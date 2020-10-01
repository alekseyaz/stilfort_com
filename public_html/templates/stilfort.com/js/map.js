function showdealers(){
	console.log('showdealers');
}
$(function(){
	if($('#dealer__map').length===0)return;
ymaps.ready(function () {
	var myMap = new ymaps.Map('dealer__map', {
            center: [55.751574, 37.573856],
            zoom: 9,
            behaviors: ['default', 'scrollZoom']
        }, {
            searchControlProvider: 'yandex#search'
        }),
		
        /**
         * Создадим кластеризатор, вызвав функцию-конструктор.
         * Список всех опций доступен в документации.
         * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Clusterer.xml#constructor-summary
         */
            clusterer = new ymaps.Clusterer({
            /**
             * Через кластеризатор можно указать только стили кластеров,
             * стили для меток нужно назначать каждой метке отдельно.
             * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/option.presetStorage.xml
             */
			clusterIconLayout: ymaps.templateLayoutFactory.createClass(
				'<div class="map__tip map__tip-yellow">{{ properties.geoObjects.length }}</div>'
			),
			// Чтобы метка была кликабельной, переопределим ее активную область.
			clusterIconShape: {
				type: 'Circle',
				coordinates: [0, 0],
				radius: 16,
			},
            /**
             * Ставим true, если хотим кластеризовать только точки с одинаковыми координатами.
             */
            groupByCoordinates: false,
            /**
             * Опции кластеров указываем в кластеризаторе с префиксом "cluster".
             * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/ClusterPlacemark.xml
             */
            clusterDisableClickZoom: true,
            clusterHideIconOnBalloonOpen: false,
            geoObjectHideIconOnBalloonOpen: false
        }),

            getPointData = function (index) {
				var point = points[index];
            return {
				balloonContentHeader: point.name,
				balloonContentBody: '<div class="dealer__info"><div class="dealer__address">'+point.address+'</div><div class="dealer__tel">Тел.: '+point.tel+'</div><div class="dealer__hours">Часы работы: '+point.hours+'</div></div><div class="dealer__site"><a href="https://'+point.site+'">'+point.site+'</a></div>',
				clusterCaption: point.name
            };
        },

            getPointOptions = function () {
				return {
					
					//iconLayout: 'default#image', // обозначаем что будет использоваться пользовательское изображение
					//iconImageHref: '/images/marker1.png',  // указываем путь к картинке которая будет служить меткой
					iconLayout:ymaps.templateLayoutFactory.createClass('<div class="map__tip map__tip-white">1</div>'),
					iconSize: [32, 32], // указываем размер изображения
					iconOffset: [0, 0], // обозначаем сдвиг от левого верхнего угла к точке изображения метки
					iconShape:{
						type: 'Circle',
						coordinates: [0, 0],
						radius: 16,
					},
				};
        },
        geoObjects = [];
	var i = 0;
    for(var k in points) {
		var point = points[k];
		geoObjects[i] = new ymaps.Placemark(point['location'], getPointData(k), getPointOptions());
		i++;
    }
    myMap.behaviors.disable('scrollZoom');
    /**
     * Можно менять опции кластеризатора после создания.
     */
    clusterer.options.set({
        gridSize: 80,
        clusterDisableClickZoom: true
    });

    /**
     * В кластеризатор можно добавить javascript-массив меток (не геоколлекцию) или одну метку.
     * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Clusterer.xml#add
     */
    clusterer.add(geoObjects);
    myMap.geoObjects.add(clusterer);

    /**
     * Спозиционируем карту так, чтобы на ней были видны все объекты.
     */

    myMap.setBounds(clusterer.getBounds(), {
        checkZoomRange: true
    });
	
	
	$(document).on('change', '.dealer__selects select', function(){
		var country = $('select[name=county]').val(),city = $('select[name=city]').val(),type = $('select[name=type]').val();
		
		clusterer.removeAll();
		var i = 0;
		geoObjects = [];
		console.log(country, city, type,points);
		for(var k in points) {
			var point = points[k];
			if(country&&country.length){
				if(country != point.country)continue;
			}
			if(city&&city.length){
				if(city != point.city)continue;
			}
			if(type&&type.length){
				if(type != point.type)continue;
			}
			geoObjects[i] = new ymaps.Placemark(point['location'], getPointData(k), getPointOptions());
			i++;
			console.log(point);
		}
		
		clusterer.add(geoObjects);
		myMap.geoObjects.add(clusterer);
		myMap.setBounds(clusterer.getBounds(), {
			checkZoomRange: true
		});
	});
});

});