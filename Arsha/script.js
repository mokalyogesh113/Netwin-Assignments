$(function () {
    let headerEnabled = false;
    const header = $("#header")
        
    $(document).on("scroll", (event) => {
        
        var top = $("#header").offset().top;
        header.css("background", `rgba(40, 58, 90, ${Math.min(0.9,top/500)})`)
    });
});
