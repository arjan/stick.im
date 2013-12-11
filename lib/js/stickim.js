(function($) {

    if (!navigator.userAgent.match(/(Chrome|Firefox)/i) && $("form .target-area").length) {
        document.location.href="/not-supported";
    }
    
    $("#title").click(function(e) {
        e.stopPropagation();
    });

    if (navigator.userAgent.match(/Macintosh/i)) {
        // Change help text for Mac users
        $(".shortcut-key").text("Cmd-V");
    }
    
    window.gotImage = function(dataURL) {

        $("<img>").attr("src", dataURL).load(function() {
            var img = $(this), tgt = $(".target-area");
            img.hide().appendTo("body");
            
            if (img.width() > 2048 || img.height() > 2048) {
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
