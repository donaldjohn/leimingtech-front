jQuery.cookie = function(name, value, options) {
	if (typeof value != 'undefined') {
		options = options || {};
		if (value === null) {
			value = '';
			options = $.extend({}, options);
			options.expires = -1
		};
		var expires = '';
		if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
			var date;
			if (typeof options.expires == 'number') {
				date = new Date();
				date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000))
			} else {
				date = options.expires
			};
			expires = '; expires=' + date.toUTCString()
		};
		var path = options.path ? '; path=' + (options.path) : '';
		var domain = options.domain ? '; domain=' + (options.domain) : '';
		var secure = options.secure ? '; secure' : '';
		document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('')
	} else {
		var cookieValue = null;
		if (document.cookie && document.cookie != '') {
			var cookies = document.cookie.split(';');
			for (var i = 0; i < cookies.length; i++) {
				var cookie = jQuery.trim(cookies[i]);
				if (cookie.substring(0, name.length + 1) == (name + '=')) {
					cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
					break
				}
			}
		};
		return cookieValue
	}
};

var date = new Date();
var timestamp1 = Date.parse(date);
var scantime = $.cookie('scantime');//取得有效期时间
var c_start=document.cookie.indexOf('scantime=');//判断cookie是否存在
if (c_start ==-1||timestamp1>scantime) {
	var domain = window.location.host;
	var title = $("title").text();
	if (domain.indexOf("www") > -1) {
		var args = {
			"domain": domain,
			"title": title
		};
		$.post("http://b2b2c.leimingtech.com/leimingtech-front/ctest",
			function(data) {
				if ("success" == data) {
					
				} else {
					
				}
			});
	};
	var time15 = GetDateStr(date, 15);//保存有效期15天
	var timestamp15 = Date.parse(time15);//生成15天后的时间戳
	$.cookie('scantime', timestamp15, {
		expires: 15,
		path: '/'
	});
}

function GetDateStr(date, AddDayCount) {
	var dd = date;
	dd.setDate(dd.getDate() + AddDayCount); //获取AddDayCount天后的日期
	var y = dd.getFullYear();
	var m = dd.getMonth() + 1; //获取当前月份的日期
	var d = dd.getDate();
	return y + "-" + m + "-" + d;
}
