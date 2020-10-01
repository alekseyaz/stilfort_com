<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM	"ulang://i18n/constants.dtd:file"	[
	<!ENTITY template_file	"'/layaouts/index.xsl'">
]>

<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/TR/xlink">
	<xsl:output method="html" indent="yes" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl umi"/>

	<xsl:template match="/" mode="index">
		<html>

			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<title><xsl:value-of select="$document-title" /></title>
				<meta name="description" content="{$document-description}"></meta>
				<meta name="keywords" content="{$document-keywords}"></meta>
				
				<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
				<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
				
				<!-- Template Basic Images Start -->
				<meta property="og:image" content="/images/image.jpg"/>
				<link rel="icon" href="/favicon.ico"/>
				<!-- Template Basic Images End -->
				
				<link rel="stylesheet" href="{$template}css/slick.css"/>
				<link rel="stylesheet" href="{$template}css/magnific-popup.css"/>
				<link rel="stylesheet" href="{$template}css/fotorama.css"/>
				<link rel="stylesheet" href="{$template}css/main.css"/>
			</head>
			
			<body> 

				<section class="header header__stable">
					<div class="wrapper">
						<header>
						<div class="mobile__menu-open">
							<a href="#modalMobileMenu" class="popup-modal">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"><defs><style>.cls-1{fill:none;}</style></defs><title/><g data-name="Layer 2" id="Layer_2"><path d="M28,10H4A1,1,0,0,1,4,8H28a1,1,0,0,1,0,2Z"/><path d="M28,17H4a1,1,0,0,1,0-2H28a1,1,0,0,1,0,2Z"/><path d="M28,24H4a1,1,0,0,1,0-2H28a1,1,0,0,1,0,2Z"/></g><g id="frame"><rect class="cls-1" height="32" width="32"/></g></svg>
							</a>
						</div>
						
							<xsl:apply-templates select="$homepage//property[@name='header_logo']" mode="header_logo" />

							<xsl:apply-templates select="document('udata://menu/draw/top_menu')/udata" mode="top_menu" />
							
							<xsl:apply-templates select="$homepage//property[@name='contact_phone']" mode="header_tel" />
						

						<div class="mobile__callback">
							<a href="#modalCallback" class="popup-modal">
							<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="512.001px" height="512.001px" viewBox="0 0 512.001 512.001" style="enable-background:new 0 0 512.001 512.001;" xml:space="preserve">
								<g>
								<path d="M462.491,468.206l-33.938,33.937c-6.062,6.031-23.812,9.844-24.343,9.844c-107.435,0.905-210.869-41.279-286.882-117.31   C41.097,318.46-1.136,214.619,0.036,106.872c0-0.063,3.891-17.312,9.938-23.312l33.937-33.968   c12.453-12.437,36.295-18.062,52.998-12.5l7.156,2.406c16.703,5.562,34.155,23.999,38.78,40.967l17.093,62.717   c4.64,17-1.594,41.186-14.031,53.623l-22.687,22.687c22.25,82.467,86.919,147.121,169.339,169.402l22.687-22.688   c12.438-12.438,36.687-18.656,53.687-14.031l62.718,17.125c16.937,4.594,35.374,22.03,40.968,38.748l2.375,7.156   C480.552,431.926,474.928,455.769,462.491,468.206z M287.996,255.993h31.999c0-35.343-28.655-63.998-63.998-63.998v31.999   C273.636,223.994,287.996,238.368,287.996,255.993z M415.992,255.993c0-88.373-71.623-159.996-159.995-159.996v32   c70.591,0,127.996,57.436,127.996,127.996H415.992z M255.997,0v31.999c123.496,0,223.993,100.497,223.993,223.994h31.999   C511.989,114.622,397.368,0,255.997,0z"/>
								</g>
							</svg>
							</a>
							<div class="search-icon__mobile">
								<img src="{$template}img/search__icon.svg" width="30" height="30"></img>
							</div>
						</div>
						</header>
					</div>
				</section>

				<section class="header header__sticky">
					<div class="wrapper">
						<header>
							<xsl:apply-templates select="$homepage//property[@name='header_logo_sticky']" mode="header_logo_sticky" />

							<xsl:apply-templates select="document('udata://menu/draw/top_menu')/udata" mode="top_menu" />
							
							<xsl:apply-templates select="$homepage//property[@name='contact_phone']" mode="header_tel" />
						</header>
					</div>
				</section>
				
				
				<xsl:apply-templates select="result" />
				
				
				<section class="footer footer__home">
					<div class="wrapper">
						<div class="footer__content">
							<footer>
								<xsl:apply-templates select="document('udata://menu/draw/bottom_menu')/udata" mode="bottom_menu" />
							</footer>
						</div>
					</div>
				</section>

				<!-- <section class="copyright">
					<div class="wrapper">
						<div class="copyright__content">
							<xsl:apply-templates select="$homepage//property[@name='copyright']" mode="copyright" />
							<form class="copyright__search" action="/search/search_do/" method="get">
								<input type="search" placeholder="Поиск по каталогу" name="search_string"/>
							</form>
							
						</div>
					</div>
				</section> -->
				
				<xsl:apply-templates select="document('udata://webforms/add/142')/udata" mode="modalCallback"/>

				<xsl:apply-templates select="$homepage//group[@name='socseti']" mode="socseti_menu_mob" />

				<script src="{$template}js/scripts.js"></script>
				<script src="{$template}js/common.js"></script>
				
				<link rel="stylesheet" href="{$template}js/tooltipster.bundle.min.css" />
				<script src="{$template}js/tooltipster.bundle.min.js"></script>
				
				<script src="{$template}js/script.js"></script>
				
				<xsl:if test="$is_default or $result/page/@id = '51'">
					<xsl:variable name="dealers" select="document('udata://custom/getDealers/?extProps=country,city,type,address,tel,hours,site,latitude,longitude')/udata"/>
					<xsl:apply-templates select="$dealers" mode="points_data"/>
					<script src="{$template}js/map.js"></script>
					<script src="https://api-maps.yandex.ru/2.1?apikey=a1ef96fc-af4c-4439-83b3-a4a220b15594&amp;lang=ru_RU"></script>
				</xsl:if>
				<xsl:apply-templates select="$homepage//property[@name = 'share']" mode="script"/>
			</body>
  
		</html>
	</xsl:template>
	
	
	<!--header_logo-->
	<xsl:template match="property" mode="header_logo">
		<div class="header__logo">
			<a href="/">
				<img src="{value}" alt="{value/@alt}"/>
			</a>
		</div>
     </xsl:template>
	 
	 <!--header_tel-->
	<xsl:template match="property" mode="header_tel">
		<div class="header__contacts">
			<div class="header__tel">
				<xsl:value-of select="value" />
			</div>
			<div class="header__order">
				<a href="#modalCallback" class="popup-modal">Заказать звонок</a>
			</div>
			<form class="copyright__search" action="/search/search_do/" method="get">
				<input type="search" placeholder="Поиск по каталогу" name="search_string"/>
			</form>
		</div>
     </xsl:template>
	 
	 
	 <!--header_logo_sticky-->
	<xsl:template match="property" mode="header_logo_sticky">
		<div class="header__logo">
			<a href="/">
				<img src="{value}" alt="{value/@alt}"/>
			</a>
		</div>
    </xsl:template>
	 
	<!--copyright-->
	<xsl:template match="property" mode="copyright">
		<div class="copyright__text">
			<xsl:value-of select="value" disable-output-escaping="yes"/>
		</div>
    </xsl:template>
	
	<!--socseti-->
	<xsl:template match="group" mode="socseti">
	  <li>
		<ul class="copyright__social">
		     <li class="copyright__social_title">Присоединяйтесь к нам</li>
			<xsl:apply-templates select=".//property[starts-with(@name,'social_')]" mode="social" />
		</ul>
		</li>
    </xsl:template>
	
	<xsl:template match="property" mode="social">
		<xsl:variable name="name" select="concat('icon_', substring-after(@name, 'social_'))"/>
		<li class="social__icon {substring-after(@name, 'social_')}__icon">
			<a href="{value}" target="_blank">
				<xsl:apply-templates select="." mode="icon_social" />
			</a>
		</li>
	</xsl:template>
	<xsl:template match="property" mode="icon_social"/>
    <xsl:template match="property[@name='social_vk']" mode="icon_social">
		<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px" width="30px" height="30px" viewBox="0 0 548.358 548.358" style="enable-background:new 0 0 548.358 548.358;" xml:space="preserve">
			<g>
				<path d="M545.451,400.298c-0.664-1.431-1.283-2.618-1.858-3.569c-9.514-17.135-27.695-38.167-54.532-63.102l-0.567-0.571   l-0.284-0.28l-0.287-0.287h-0.288c-12.18-11.611-19.893-19.418-23.123-23.415c-5.91-7.614-7.234-15.321-4.004-23.13   c2.282-5.9,10.854-18.36,25.696-37.397c7.807-10.089,13.99-18.175,18.556-24.267c32.931-43.78,47.208-71.756,42.828-83.939   l-1.701-2.847c-1.143-1.714-4.093-3.282-8.846-4.712c-4.764-1.427-10.853-1.663-18.278-0.712l-82.224,0.568   c-1.332-0.472-3.234-0.428-5.712,0.144c-2.475,0.572-3.713,0.859-3.713,0.859l-1.431,0.715l-1.136,0.859   c-0.952,0.568-1.999,1.567-3.142,2.995c-1.137,1.423-2.088,3.093-2.848,4.996c-8.952,23.031-19.13,44.444-30.553,64.238   c-7.043,11.803-13.511,22.032-19.418,30.693c-5.899,8.658-10.848,15.037-14.842,19.126c-4,4.093-7.61,7.372-10.852,9.849   c-3.237,2.478-5.708,3.525-7.419,3.142c-1.715-0.383-3.33-0.763-4.859-1.143c-2.663-1.714-4.805-4.045-6.42-6.995   c-1.622-2.95-2.714-6.663-3.285-11.136c-0.568-4.476-0.904-8.326-1-11.563c-0.089-3.233-0.048-7.806,0.145-13.706   c0.198-5.903,0.287-9.897,0.287-11.991c0-7.234,0.141-15.085,0.424-23.555c0.288-8.47,0.521-15.181,0.716-20.125   c0.194-4.949,0.284-10.185,0.284-15.705s-0.336-9.849-1-12.991c-0.656-3.138-1.663-6.184-2.99-9.137   c-1.335-2.95-3.289-5.232-5.853-6.852c-2.569-1.618-5.763-2.902-9.564-3.856c-10.089-2.283-22.936-3.518-38.547-3.71   c-35.401-0.38-58.148,1.906-68.236,6.855c-3.997,2.091-7.614,4.948-10.848,8.562c-3.427,4.189-3.905,6.475-1.431,6.851   c11.422,1.711,19.508,5.804,24.267,12.275l1.715,3.429c1.334,2.474,2.666,6.854,3.999,13.134c1.331,6.28,2.19,13.227,2.568,20.837   c0.95,13.897,0.95,25.793,0,35.689c-0.953,9.9-1.853,17.607-2.712,23.127c-0.859,5.52-2.143,9.993-3.855,13.418   c-1.715,3.426-2.856,5.52-3.428,6.28c-0.571,0.76-1.047,1.239-1.425,1.427c-2.474,0.948-5.047,1.431-7.71,1.431   c-2.667,0-5.901-1.334-9.707-4c-3.805-2.666-7.754-6.328-11.847-10.992c-4.093-4.665-8.709-11.184-13.85-19.558   c-5.137-8.374-10.467-18.271-15.987-29.691l-4.567-8.282c-2.855-5.328-6.755-13.086-11.704-23.267   c-4.952-10.185-9.329-20.037-13.134-29.554c-1.521-3.997-3.806-7.04-6.851-9.134l-1.429-0.859c-0.95-0.76-2.475-1.567-4.567-2.427   c-2.095-0.859-4.281-1.475-6.567-1.854l-78.229,0.568c-7.994,0-13.418,1.811-16.274,5.428l-1.143,1.711   C0.288,140.146,0,141.668,0,143.763c0,2.094,0.571,4.664,1.714,7.707c11.42,26.84,23.839,52.725,37.257,77.659   c13.418,24.934,25.078,45.019,34.973,60.237c9.897,15.229,19.985,29.602,30.264,43.112c10.279,13.515,17.083,22.176,20.412,25.981   c3.333,3.812,5.951,6.662,7.854,8.565l7.139,6.851c4.568,4.569,11.276,10.041,20.127,16.416   c8.853,6.379,18.654,12.659,29.408,18.85c10.756,6.181,23.269,11.225,37.546,15.126c14.275,3.905,28.169,5.472,41.684,4.716h32.834   c6.659-0.575,11.704-2.669,15.133-6.283l1.136-1.431c0.764-1.136,1.479-2.901,2.139-5.276c0.668-2.379,1-5,1-7.851   c-0.195-8.183,0.428-15.558,1.852-22.124c1.423-6.564,3.045-11.513,4.859-14.846c1.813-3.33,3.859-6.14,6.136-8.418   c2.282-2.283,3.908-3.666,4.862-4.142c0.948-0.479,1.705-0.804,2.276-0.999c4.568-1.522,9.944-0.048,16.136,4.429   c6.187,4.473,11.99,9.996,17.418,16.56c5.425,6.57,11.943,13.941,19.555,22.124c7.617,8.186,14.277,14.271,19.985,18.274   l5.708,3.426c3.812,2.286,8.761,4.38,14.853,6.283c6.081,1.902,11.409,2.378,15.984,1.427l73.087-1.14   c7.229,0,12.854-1.197,16.844-3.572c3.998-2.379,6.373-5,7.139-7.851c0.764-2.854,0.805-6.092,0.145-9.712   C546.782,404.25,546.115,401.725,545.451,400.298z"/>
			</g>
		</svg>
	</xsl:template> 
    <xsl:template match="property[@name='social_insta']" mode="icon_social">
		<svg xmlns="http://www.w3.org/2000/svg" xmlns:serif="http://www.serif.com/" xmlns:xlink="http://www.w3.org/1999/xlink" height="30px" width="30px" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:1.41421;" version="1.1" viewBox="0 0 24 24" xml:space="preserve"><rect height="24" id="Artboard10" style="fill:none;" width="24" x="0" y="0"/><path d="M22,7c0,-2.761 -2.239,-5 -5,-5c-3.054,0 -6.946,0 -10,0c-2.761,0 -5,2.239 -5,5c0,3.054 0,6.946 0,10c0,2.761 2.239,5 5,5c3.054,0 6.946,0 10,0c2.761,0 5,-2.239 5,-5c0,-3.054 0,-6.946 0,-10Z" style="fill:url(#_Radial1);"/><path d="M14.958,5.005c2.091,0.02 4.016,1.815 4.037,4.037c0.007,1.972 0.007,3.944 0,5.916c-0.02,2.083 -1.815,4.016 -4.037,4.037c-1.972,0.007 -3.944,0.007 -5.916,0c-2.092,-0.02 -4.016,-1.815 -4.037,-4.037c-0.007,-1.972 -0.007,-3.944 0,-5.916c0.019,-2.093 1.81,-4.016 4.037,-4.037c1.972,-0.007 3.944,-0.007 5.916,0Zm-5.889,0.945c-1.623,0.005 -3.103,1.412 -3.119,3.098c-0.006,1.968 -0.006,3.936 0,5.904c0.015,1.605 1.388,3.082 3.098,3.098c1.968,0.006 3.936,0.006 5.904,0c1.609,-0.015 3.082,-1.388 3.098,-3.098c0.006,-1.968 0.006,-3.936 0,-5.904c-0.015,-1.616 -1.415,-3.082 -3.098,-3.098c-1.961,-0.006 -3.922,0 -5.883,0Z" style="fill:#fff;fill-rule:nonzero;"/><path d="M12.024,8.5c1.618,0.015 3.126,1.263 3.422,2.862c0.211,1.14 -0.187,2.376 -1.027,3.178c-0.935,0.89 -2.382,1.208 -3.622,0.754c-1.386,-0.507 -2.361,-1.968 -2.296,-3.448c0.079,-1.768 1.641,-3.34 3.499,-3.346c0.008,0 0.016,0 0.024,0Zm-0.04,0.947c-1.155,0.011 -2.244,0.887 -2.484,2.025c-0.243,1.151 0.419,2.428 1.506,2.887c1.187,0.502 2.72,-0.061 3.293,-1.233c0.593,-1.211 0.034,-2.856 -1.218,-3.441c-0.341,-0.159 -0.72,-0.239 -1.097,-0.238Z" style="fill:#fff;fill-rule:nonzero;"/><path d="M16.5,8.227c0,-0.193 -0.077,-0.378 -0.213,-0.514c-0.136,-0.136 -0.321,-0.213 -0.514,-0.213c-0.015,0 -0.031,0 -0.046,0c-0.193,0 -0.378,0.077 -0.514,0.213c-0.136,0.136 -0.213,0.321 -0.213,0.514c0,0.008 0,0.015 0,0.023c0,0.199 0.079,0.39 0.22,0.53c0.14,0.141 0.331,0.22 0.53,0.22c0,0 0,0 0,0c0.414,0 0.75,-0.336 0.75,-0.75c0,-0.008 0,-0.015 0,-0.023Z" style="fill:#fff;"/><defs><radialGradient cx="0" cy="0" gradientTransform="matrix(27.933,0,0,27.933,2,21.5)" gradientUnits="userSpaceOnUse" id="_Radial1" r="1"><stop offset="0" style="stop-color:#ff8100;stop-opacity:1"/><stop offset="0.19" style="stop-color:#ff7209;stop-opacity:1"/><stop offset="0.32" style="stop-color:#f55e16;stop-opacity:1"/><stop offset="0.48" style="stop-color:#d92938;stop-opacity:1"/><stop offset="1" style="stop-color:#9100ff;stop-opacity:1"/></radialGradient></defs></svg>
	</xsl:template> 
    <xsl:template match="property[@name='social_tw']" mode="icon_social">
		<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 128 128" id="Social_Icons" version="1.1" viewBox="0 0 128 128" xml:space="preserve"><g id="_x37__stroke"><g id="Twitter"><rect clip-rule="evenodd" fill="none" fill-rule="evenodd" height="128" width="128"/><path clip-rule="evenodd" d="M128,23.294    c-4.703,2.142-9.767,3.59-15.079,4.237c5.424-3.328,9.587-8.606,11.548-14.892c-5.079,3.082-10.691,5.324-16.687,6.526    c-4.778-5.231-11.608-8.498-19.166-8.498c-14.493,0-26.251,12.057-26.251,26.927c0,2.111,0.225,4.16,0.676,6.133    C41.217,42.601,21.871,31.892,8.91,15.582c-2.261,3.991-3.554,8.621-3.554,13.552c0,9.338,4.636,17.581,11.683,22.412    c-4.297-0.131-8.355-1.356-11.901-3.359v0.331c0,13.051,9.053,23.937,21.074,26.403c-2.201,0.632-4.523,0.948-6.92,0.948    c-1.69,0-3.343-0.162-4.944-0.478c3.343,10.694,13.035,18.483,24.53,18.691c-8.986,7.227-20.315,11.533-32.614,11.533    c-2.119,0-4.215-0.123-6.266-0.37c11.623,7.627,25.432,12.088,40.255,12.088c48.309,0,74.717-41.026,74.717-76.612    c0-1.171-0.023-2.342-0.068-3.49C120.036,33.433,124.491,28.695,128,23.294" fill="#00AAEC" fill-rule="evenodd" id="Twitter_1_"/></g></g></svg>
	</xsl:template> 
    <xsl:template match="property[@name='social_fb']" mode="icon_social">
		 <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" height="1.04167in" style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd" version="1.1" viewBox="0 0 187 187" width="1.04167in" xml:space="preserve"><defs><style type="text/css">
                            <![CDATA[
                             .fil1 {fill:#FEFEFE}
                             .fil0 {fill:#485992}
                            ]]>
                           </style></defs><g id="Layer_x0020_1"><rect class="fil0" height="187" rx="18" ry="18" width="187"/><path class="fil1" d="M131 79l0 -12c0,-6 4,-7 6,-7 3,0 18,0 18,0l0 -27 -24 0c-27,0 -33,20 -33,32l0 14 -15 0 0 19 0 12 16 0c0,35 0,77 0,77l30 0c0,0 0,-42 0,-77l23 0 1 -12 2 -19 -24 0z"/></g></svg>
	</xsl:template>

	<!--socseti_menu_mob-->
	<xsl:template match="group" mode="socseti_menu_mob">
		<section class="modal modal__mobileMenu mfp-hide" id="modalMobileMenu">
			<div class="wrapper">
				<div class="modal__content">
					<xsl:apply-templates select="document('udata://menu/draw/top_menu')/udata" mode="top_menu_mob" />
					<div class="modal__close popup-modal-dismiss">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="25px" height="25px" viewBox="0 0 17 17" version="1.1">
							<defs/>
							<g id="Icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" stroke-linecap="round">
								<g id="24-px-Icons" transform="translate(-364.000000, -124.000000)" stroke="#000000">
									<g id="ic_cancel" transform="translate(360.000000, 120.000000)">
										<g id="cross">
											<g transform="translate(5.000000, 5.000000)" stroke-width="2">
												<path d="M0,0 L14.1421356,14.1421356" id="Line"/>
												<path d="M14,0 L1.77635684e-15,14" id="Line"/>
											</g>
										</g>
									</g>
								</g>
							</g>
						</svg>
					</div>
				</div>
			</div>
		</section>
    </xsl:template>
	
		<!--socseti_mob-->
	<xsl:template match="group" mode="socseti_mob">
		<div class="social__list">
			<xsl:apply-templates select=".//property[starts-with(@name,'social_')]" mode="social" />
		</div>
    </xsl:template>
	
	
	<!--cena-->
	<xsl:template match="value" mode="cena">
		<xsl:value-of select="format-number(., '### ##0', 'df')" /><xsl:text> ₽</xsl:text>
    </xsl:template>
	
	
	
	<!--kontakty_footer-->
	<xsl:template match="group" mode="kontakty_footer">
	  <xsl:apply-templates select=".//property[@name='adres']" mode="kontakty_footer" />
	  <xsl:apply-templates select=".//property[@name='contact_phone']" mode="kontakty_footer" />
    </xsl:template>
	
	<xsl:template match="property" mode="kontakty_footer">
	  <li>
	      <xsl:value-of select="value" />
	  </li>
    </xsl:template>


</xsl:stylesheet>