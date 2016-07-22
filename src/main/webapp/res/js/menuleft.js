$(function(){
	var nowHref = window.location.pathname+window.location.search;//端口后路径加参数如/test/test.htm?id=1
	$("#my_menu").find("a").each(function(){
		if(nowHref==$(this).attr("href")){
			$(this).parent().addClass("active");
		}else{
			$(this).parent().removeClass();
			$(this).parent().addClass("normal");
		}
	});

});