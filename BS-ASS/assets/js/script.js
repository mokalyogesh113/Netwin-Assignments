$(function () {

    // HANDLE STICKY HEADER

    $(document).on("scroll", function () {
        const $nav = $("#navbar")
        let height = $("#header").height();
        if ($(this).scrollTop() > height) {
            $nav.addClass('fixed-nav');
            $("#about-us").css("margin-top", `${$nav.height()}px`)
            console.log("stick")
        } else {
            $nav.removeClass('fixed-nav');
            $("#about-us").css("margin-top", `${0}px`)
        }
    });


    // ABOUT US CONTINUE READING BUTTON

    let readingExapanded = false;
    $("#about-us-hidden").hide() // Initially content will be hidden
    $("#about-continue-read-btn").on("click", function () {
        console.log("Hello ")
        $("#about-us-hidden").slideToggle();

        readingExapanded = !readingExapanded;
        if(readingExapanded){
            $("#about-continue-read-btn").html("Read Less")
        } else{
            $("#about-continue-read-btn").html("Continue Reading")
        }
        
        
        
    });


    // GALLERY + Button
    let gallrryBtnVal = ["+" , "-"]; 
    let currentBtnVal = 0;
    $("#gallery-hidden").hide();
    $("#gallery-plus-btn").on("click", function () {
        $("#gallery-hidden").slideToggle();


        currentBtnVal^=1;
        $("#gallery-plus-btn").html(gallrryBtnVal[currentBtnVal])
        
    })


})