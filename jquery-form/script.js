$(document).ready(function () {
    const $form = $("#my-form");
    const $addBtn = $("#addBtn");
    const $inputContainer = $("#input-container");
    const $displayTable = $("#display-table")

    // HANDLE ADD BUTTON CLICK
    $addBtn.click(function () {
        $template = $("#template");
        
        // HANDLE DELETE BUTTON
        $($inputContainer).on("click", ".dltBtn", function () {
            $(this).parent().remove();
        });
        
        $inputContainer.append($template.html());
    });

    // HANDLE SUBMIT BUTTON
    $form.on("submit", function (event) {
        event.preventDefault();

        let userData = []
        
        $(".input-field").each(function (index, element) {
            let newUser = {};
            $(element).children("input").each(function (idx, inp) {
                if($(inp).attr("type")=="text" && $(inp).val()){
                    newUser[$(inp).attr("name")] = $(inp).val()
                }
            });
            if(Object.keys(newUser).length == 2){
                userData.push(newUser);
            }
        });

        console.log(userData);
        appendDataToTable(userData);
    });


    // APPEND THE DATA TO THE TABLE
    let rowCount = 0;
    function appendDataToTable(data){
        let $body = $displayTable.children("table").children("tbody");
        
        for(obj of data){  
            let row = `<tr><td>${rowCount++}</td>`
            for(key in obj){
                row+=`<td>${obj[key]}</td>`
            }
            row+="</tr>"
            $body.append(row);
        }
    }






});