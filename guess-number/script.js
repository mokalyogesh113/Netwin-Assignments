
const input = document.querySelector("input"),
  guess = document.querySelector("#guess"),
  checkButton = document.querySelector("button"),
  total_attempts = document.querySelector("#attempts");

let attempts = 0;

function guessNumber() {

  if (checkButton.innerHTML == "Replay") {
    window.navigation.reload()
  }

  let randomNum = Math.floor(Math.random() * 10);
  let inputValue = input.value;


  // VALIDATION
  if(inputValue==""){
    guess.innerHTML = `Input Field <br> Cannot  Be Empty`;
    guess.style.color = "rgb(227,0,0)";
    input.focus();
    return;
  }
  
  if (!(inputValue >= 0 && inputValue <= 9)) {
    guess.innerHTML = `Enter Valid Number`;
    guess.style.color = "rgb(227,0,0)";
    input.focus();
    return;
  }

  

  attempts++;
  total_attempts.innerHTML = attempts;


  if (inputValue == randomNum) {
    guess.innerHTML = "CONGRATULATIONS!..... <br> You Guessed it Right";
    guess.style.color = "rgb(34,15  9,0)";
    input.disabled = true;
    checkButton.innerHTML = "Replay";

  } else if (inputValue != randomNum && inputValue < 10) {
    guess.innerHTML = `Number was ${randomNum}  BAD LUCK :( <br> TRY AGAIN...`;
    guess.style.color = "rgb(34,159,0)";
    input.focus();
  }

}

input.focus();
checkButton.addEventListener("click", guessNumber);
