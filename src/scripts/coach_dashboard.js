// Get the modal
var modal = document.getElementById("newPlayerModal");

// Get the button that opens the modal
var btn = document.getElementById("newPlayerButton");

// Get the <span> element that closes the modal
var span = document.getElementById("closeNewPlayerForm");

// Hide the modal by default
modal.style.display = "none";

// When the user clicks the button, open the modal
btn.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

// Toggle visibility of navigation buttons when hamburger menu is clicked
document.getElementById('hamburgerMenu').addEventListener('click', function() {
    document.querySelector('.nav_buttons').classList.toggle('show');
});
