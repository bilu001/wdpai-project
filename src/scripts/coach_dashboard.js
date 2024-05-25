document.addEventListener('DOMContentLoaded', async () => {
    const newPlayerButton = document.getElementById('newPlayerButton');
    const newPlayerModal = document.getElementById('newPlayerModal');
    const closeNewPlayerForm = document.getElementById('closeNewPlayerForm');
    const newPlayerForm = document.getElementById('newPlayerForm');
    const playersGrid = document.getElementById('playersGrid');
    const hamburgerMenu = document.getElementById('hamburgerMenu');
    const navButtons = document.querySelector('.nav_buttons');

    await loadPlayers();

    newPlayerButton.onclick = () => {
        newPlayerModal.style.display = 'block';
    };

    closeNewPlayerForm.onclick = () => {
        newPlayerModal.style.display = 'none';
    };

    window.onclick = (event) => {
        if (event.target == newPlayerModal) {
            newPlayerModal.style.display = 'none';
        }
    };

    newPlayerForm.onsubmit = async (event) => {
        event.preventDefault();
        const formData = new FormData(newPlayerForm);
        try {
            const response = await fetch('/src/controllers/add_player.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                const errorMessage = await response.text();
                throw new Error(errorMessage);
            }

            const newPlayer = await response.json();
            addPlayerToGrid(newPlayer);
            newPlayerModal.style.display = 'none';
        } catch (error) {
            alert('Error adding player: ' + error.message);
        }
    };

    async function loadPlayers() {
        try {
            const response = await fetch('/src/controllers/get_players.php');
            if (!response.ok) {
                throw new Error('Failed to fetch players');
            }

            const players = await response.json();
            players.forEach(player => addPlayerToGrid(player));
        } catch (error) {
            console.error('Error loading players:', error);
        }
    }

    function addPlayerToGrid(player) {
        const playerDiv = document.createElement('div');
        playerDiv.classList.add('player');
        playerDiv.setAttribute('data-player-id', player.player_id);
        playerDiv.innerHTML = `
            <img src="/public/images/${player.image}" alt="player">
            <p>${player.name} <span>${player.surname}</span></p>
            <p>${player.position}</p>
            <p>Contract valid until<span>${player.contract_ends}</span></p>
            <div class="manage_players">
                <button>Add Statistics</button>
                <button onclick="removePlayer(${player.player_id})">Remove Player</button>
            </div>
            ${player.injury_status ? '<div class="injury-indicator">!</div>' : ''}
        `;
        playersGrid.appendChild(playerDiv);
    }

    window.removePlayer = async function(playerId) {
        try {
            const response = await fetch('/src/controllers/remove_player.php', {
                method: 'POST',
                body: JSON.stringify({ player_id: playerId }),
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            const text = await response.text();
            console.log('Response Text:', text); 

            const result = JSON.parse(text);

            if (result.status === 'success') {
                document.querySelector(`.player[data-player-id="${playerId}"]`).remove();
            } else {
                throw new Error(result.message);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Error removing player: ' + error.message);
        }
    };
    hamburgerMenu.addEventListener('click', () => {
        navButtons.classList.toggle('active');
    });
    

});

function logout() {
    fetch('/src/controllers/logout.php')
        .then(() => {
            window.location.href = '/public/views/login.html';
        });
}
