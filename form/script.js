document.addEventListener("DOMContentLoaded", () => {
    // VARIABLES
    const form = document.querySelector("#my-form");
    const dataTable = document.querySelector("#display-table");

    // Buttons
    const addEmailBtn = document.querySelector("#addEmailBtn");
    const addAddressBtn = document.querySelector("#addAddressBtn");
    const importBtn = document.querySelector("#importBtn");

    // COUNTERS
    let emailCount = 1;
    let addressCount = 1;

    // HANDLE ADD  EMAIL BUTTON CLICK
    addEmailBtn.addEventListener("click", () => {

        const emailContainer = document.querySelector("#emails");
        if (emailCount < 5) {
            const newEmail = document.createElement("div");
            newEmail.className = "email-div";

            const newEmailInput = document.createElement("input");
            newEmailInput.className = "email";
            newEmailInput.type = "email";
            newEmailInput.name = "email";
            newEmailInput.placeholder = "@example.com";
            newEmailInput.pattern = ".+@.+\..+";
            newEmailInput.title = "Please enter a valid email address."

            const deleteIcon = document.createElement("input");
            deleteIcon.type = "button";
            deleteIcon.className = "addBtn";
            deleteIcon.value = "-";

            deleteIcon.addEventListener("click", () => {
                emailContainer.removeChild(newEmail);
                emailCount--;
            });

            newEmail.appendChild(newEmailInput);
            newEmail.appendChild(deleteIcon);

            emailContainer.appendChild(newEmail);

            emailCount++;
        }
    });

    // HANDLE ADD ADDRESS  BUTTON CLICK
    addAddressBtn.addEventListener("click", () => {
        const addressContainer = document.querySelector("#addresses");
        if (addressCount < 2) {
            const defaultAddress = form.querySelector("#defaultAddress");
            const newAddress = defaultAddress.cloneNode(true);
            newAddress.id = "";

            // Delete Button
            const deleteIcon = document.createElement("input");
            deleteIcon.type = "button";
            deleteIcon.className = "addBtn";
            deleteIcon.value = "Delete Address";

            deleteIcon.addEventListener("click", () => {
                addressContainer.removeChild(newAddress);
                addressCount--;
            });

            const brTag = document.createElement("br");

            newAddress.appendChild(deleteIcon);
            newAddress.appendChild(brTag);
            newAddress.appendChild(brTag.cloneNode(true));

            addressContainer.appendChild(newAddress);
            addressCount++;
        }
    });

    // HANDLE FORM  SUBMISSION
    form.addEventListener("submit", (event) => {
        event.preventDefault();

        if (!validateFields()) {
            return;
        }

        const newRow = document.createElement("tr");
        var formData = {};

        // GET INPUT VALUES FROM THE USER
        formData["firstName"] = event.target.querySelector("input[name=firstName]").value;
        formData["lastName"] = event.target.querySelector("input[name=lastName]").value;
        formData["gender"] = event.target.querySelector("input[name=gender]").value;

        formData["email"] = []
        const emails = event.target.querySelectorAll("input[type=email]")
        for (let i = 0; i < emails.length; i++) {
            formData["email"].push(emails[i].value);
        }

        formData["phone"] = event.target.querySelector("input[name=phone]").value;


        formData["address"] = [];
        const addressDivs = event.target.querySelectorAll(".address-div");
        for (let i = 0; i < addressDivs.length; i++) {
            const addressData = {};

            addressData["street"] = addressDivs[i].querySelector("input[name=street]").value;
            addressData["city"] = addressDivs[i].querySelector("input[name=city]").value;
            addressData["country"] = addressDivs[i].querySelector("input[name=country]").value;
            addressData["state"] = addressDivs[i].querySelector("input[name=state]").value;
            addressData["zipcode"] = addressDivs[i].querySelector("input[name=zipcode]").value;

            formData["address"].push(addressData);
        }


        // ADD DATA TO THE TABLE
        appendToTable(formData);

        // DELETE EXTRA FIELDS
        deleteExtraFields();

        // RESET THE FORM
        form.reset();
    });


    const errorMsg = document.createElement("p");
    errorMsg.className = "error-msg";
    
    // VALIDATION
    function validateFields() {
        let flag = true

        
        
        
        // NAME
        // fname
        const fname = form.querySelector("#firstName")
        if(!fname){
            printError(fname , "Enter Data")
        }




        // EMAIL
        // PHONE
        // ADDRESS






        return flag;
    }



    // ADD THE DATA TO THE TABLE
    const appendToTable = (data) => {
        console.log(JSON.stringify(data));
        let tableBody = dataTable.querySelector("tbody");
        let row = document.createElement('tr');

        for (key in data) {
            const val = data[key];
            let cell = document.createElement("td");

            if (key == "email" || key == "address") {
                let list = document.createElement("ol")

                if (key == "email") {
                    for (email of data[key]) {
                        let listItem = document.createElement("li");
                        listItem.textContent = email;
                        list.appendChild(listItem);
                    }
                } else {

                    for (address of data[key]) {
                        let listItem = document.createElement("li");

                        let addrStr = "";
                        for (addrKey in address) {
                            addrStr += `${addrKey} : ${address[addrKey]} `
                        }

                        listItem.textContent = addrStr;
                        list.appendChild(listItem);
                    }
                }
                cell.append(list);
            } else {
                cell.innerText = data[key];
            }
            row.appendChild(cell);
        }

        const deleteButton = document.createElement("input");
        deleteButton.type = "button";
        deleteButton.className = "addBtn";
        deleteButton.value = "Delete";

        deleteButton.addEventListener("click", () => {
            tableBody.removeChild(row);
        });

        let cell = document.createElement("td").innerHTML = deleteButton;
        row.appendChild(cell);

        tableBody.append(row);
    };


    const deleteExtraFields = () => {

        if (emailCount > 1) {
            const emails = form.querySelectorAll(".email-div")
            for (var i = 1; i < emails.length; i++) {
                emails[i].parentNode.removeChild(emails[i]);
            }
            emailCount = 1;
        }
        if (addressCount > 1) {
            const addresses = form.querySelectorAll('.address-div');
            for (var i = 1; i < addresses.length; i++) {
                addresses[i].parentNode.removeChild(addresses[i]);
            }
            addressCount = 1;
        }
    }

    // HANDLE  IMPORT DATA BUTTON CLICK
    importBtn.addEventListener("click", () => {

        const xhttp = new XMLHttpRequest();
        xhttp.open("GET", "info.txt");

        xhttp.onload = function () {
            const data = JSON.parse(this.responseText);

            deleteExtraFields();


            for (key in data) {
                console.log(`${key} :- ${data[key]}`)
                if (key == "email") {
                    form.querySelector(`input[name=${key}]`).value = data[key][0];
                } else if (key == "address") {
                    for (addrKey in data[key][0]) {
                        // console.log(addre)
                        form.querySelector(`input[name=${addrKey}]`).value = data[key][0][addrKey];
                    }

                } else {
                    form.querySelector(`input[name=${key}]`).value = data[key];
                }

                console.log(`${key} :- ${data[key]}`)
            }



        }
        xhttp.send();

    });
});

function fillData() {
    const form = document.querySelector("#my-form");
    form.querySelector("#firstName").value = "Yogesh";
    form.querySelector("#lastName").value = "Mokal";
    form.querySelector("#email").value = "mokalyogesh113@gmail.com"
    form.querySelector("#phone").value = "1234567890"
    form.querySelector("#street").value = "15, Amrut Nagar";
    form.querySelector("#city").value = "Pachora";
    form.querySelector("#country").value = "India";
    form.querySelector("#state").value = "Maharashtra"
    form.querySelector("#zipcode").value = "42420";
}