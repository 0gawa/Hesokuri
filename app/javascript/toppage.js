$(function(){
    var interval = 3000;
    var i = 0
    var c_array = ["bg-pic-com","bg-pic-bit","bg-pic-office","bg-pic-man"]
    var changeImage = function(){
        $("#top-bg-first").removeClass(c_array[i]);
        if(i == c_array.length-1) i = 0;
        $("#top-bg-first").addClass(c_array[i+1]);
        i += 1;
    }
    setInterval(changeImage,interval);
    
    $("#title-slow").hide().fadeIn(1500)
});
//animation
$(function () {
    $(".js-fade").on("inview", function () {
        $(this).addClass("inview");
    });
});