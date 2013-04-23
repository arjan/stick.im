(function($) {

    if (navigator.userAgent.match(/MSIE/i) && !document.location.href.match(/not-supported/)) {
        document.location.href="/not-supported";
    }
    
    $("#title").click(function(e) {
        e.stopPropagation();
    });
    
    window.gotImage = function(dataURL) {

        $("<img>").attr("src", dataURL).load(function() {
            var img = $(this), tgt = $(".target-area");
            img.hide().appendTo("body");
            
            if (img.width() > 1024 || img.height() > 1024) {
                alert("Sorry, this image is too large");
                return;
            }
            $(".target-area .hint").hide();
            
            tgt.css({backgroundImage: "url(" + dataURL + ")",
                     width: img.width()+"px",
                     height: img.height()+"px"});

            $("#imgdata").val(dataURL);

            $(".form-fields").fadeIn();

            $("#home-head").text("Enter image details");
            $("#home-expl").html("Well done! Now optionally give the image a title, select a background color, and press <b>share</b>!");
        });
        
    };

})(jQuery);
