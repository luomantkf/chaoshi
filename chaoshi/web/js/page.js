function page(url){
    var allNum = 20 , //总共的条数
        curentPage1 = 1, //当前页数
        ul = $(".pagecontrol");
    var ajaxload = function(){
        $.ajax({
            type: "get",
            url: url,
            data:{currentPage:curentPage1},
            dataType: "json",
            success: function(data) {
                allPage = Math.ceil(data.allNum/data.pageNum)//总页数
                template.config("escape", false);
                var html = template('test',{ items: data.model});
                $("#oneTr").html(html);
                ul.html('<span>共'+ allPage +'页</span><span>当前第 '+ curentPage1 +'/' + allPage + '页</span><span><a href="#" class="up-all">第一页&nbsp;&nbsp;</a><a href="#" class="up">上一页&nbsp;&nbsp;</a><a href="#" class="down">下一页&nbsp;&nbsp; </a><a href="#" class="down-all">最后一页&nbsp;&nbsp;</a></span>');
                pagebtn();
            },
            error: function() {

            }
        })
    }
    ajaxload();

     var pagebtn=function(){

        //第一页
        $(".up-all").click(function(){
            if (curentPage1 == 1){
                alert("当前已是第一页")
            }
            else{
                curentPage1 =  1;
                ajaxload();
            }
        })

        //上一页
        $(".up").click(function(){
            if (curentPage1 <= 1){
                alert("当前已是第一页")
            }
            else{
                curentPage1 = curentPage1 - 1;
                ajaxload();
            }
        })

        //下一页
        $(".down").click(function(){
            if (curentPage1 >= allPage){
                alert("当前已是最后一页")
            }
            else{
                curentPage1 = curentPage1 + 1;
                ajaxload();
            }
        })

        //最后一页
        $(".down-all").click(function(){
            if (curentPage1 >= allPage){
                alert("当前已是最后一页")
            }
            else{
                curentPage1 = allPage;
                ajaxload();
            }
        })

    }    
}