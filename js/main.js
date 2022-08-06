$(document).ready(function(){
    if($(this).scrollTop() > 80){
        $('.navbar').addClass('bg-light');
    }
    $(window).scroll(function(){
        if($(this).scrollTop() > 80){
            $('.navbar').addClass('bg-light');
        }
        else{
            if ($(window).width() > 992) {
                $('.navbar').removeClass('bg-light');
            }
        }
    });
});

if ($(window).width() < 992) {
    $(".navbar-toggler").on("click",function(){
        $('.navbar').addClass('bg-light');
    })
 }

$(document).ready(function(){
    $('.navbar-nav>li>a').on('click', function(){
        $('.navbar-collapse').collapse('hide');
    });
});
