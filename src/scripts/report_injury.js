document.getElementById('injuryForm').addEventListener('submit', async function(event) {
    event.preventDefault();

    const formData = new FormData(this);

    try {
        const response = await fetch('/src/controllers/report_injury.php', {
            method: 'POST',
            body: formData
        });

        if (response.ok) {
            document.getElementById('success-message').style.display = 'block';
            document.getElementById('error-message').style.display = 'none';
            this.reset();
        } else {
            document.getElementById('success-message').style.display = 'none';
            document.getElementById('error-message').style.display = 'block';
        }
    } catch (error) {
        document.getElementById('success-message').style.display = 'none';
        document.getElementById('error-message').style.display = 'block';
    }
});
