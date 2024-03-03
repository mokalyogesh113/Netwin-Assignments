$(function () {

    // HANDLE STICKY HEADER
    console.log($(".ym-about-us-section").css("margin-top"))

    $(document).on("scroll", function () {
        const $nav = $("#navbar")
        let height = $("#header").height();
        if ($(this).scrollTop() > height) {
            $nav.addClass('fixed-nav');
            $("#about-us").css("margin-top", `${$nav.height()}px`)
        } else {
            $nav.removeClass('fixed-nav');
            $("#about-us").css("margin-top", `${0}px`)
        }
    });


    // ABOUT US CONTINUE READING BUTTON

    $("#about-us-hidden").hide() // Initially content will be hidden
    $("#about-continue-read-btn").on("click", function () {
        $("#about-us-hidden").slideToggle();
    });


    // GALLERY + Button
    $("#gallery-hidden").hide();
    $("#gallery-plus-btn").on("click", function () {
        $("#gallery-hidden").slideToggle();
    })


})