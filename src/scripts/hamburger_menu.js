document.addEventListener('DOMContentLoaded', () => {
    const hamburgerMenu = document.getElementById('hamburgerMenu');
    const navButtons = document.querySelector('.nav_buttons');

    hamburgerMenu.addEventListener('click', () => {
        navButtons.classList.toggle('active');
    });
});
