document.addEventListener('DOMContentLoaded', async () => {
    const playerDashboard = document.getElementById('playerDashboard');
    try {
        const response = await fetch('/src/controllers/get_player_data.php');
        if (!response.ok) {
            throw new Error('Failed to fetch player data');
        }

        const player = await response.json();
        renderPlayerData(player);
    } catch (error) {
        console.error('Error loading player data:', error);
    }

    function renderPlayerData(player) {
        const playerInfo = `
            <section class="player-info">
                <img src="/public/images/${player.image}" alt="Player Photo" class="player-photo"/>
                <div class="player-details">
                    <h2 class="player-name">${player.name} ${player.surname}</h2>
                    <p>Position: ${player.position}</p>
                    <p>Contract Ends: ${player.contract_ends}</p>
                    <p>Date of Birth: ${player.date_of_birth || 'No data present yet.'}</p>
                    <button class="injury-status">${player.injury_status ? '!' : ''}</button>
                </div>
            </section>
            <section class="coach-feedback">
                <h3>Coach's Feedback</h3>
                <p>${player.feedback || 'No data present yet.'}</p>
            </section>
            <section class="match-stats">
                <h3>Last Match Statistics</h3>
                <ul>
                    <li>Goals: ${player.goals !== null ? player.goals : 'No data present yet.'}</li>
                    <li>Assists: ${player.assists !== null ? player.assists : 'No data present yet.'}</li>
                    <li>Pass Accuracy: ${player.passes_completed !== null ? player.passes_completed + '%' : 'No data present yet.'}</li>
                    <li>Shots on Target: ${player.shots_on_target !== null ? player.shots_on_target : 'No data present yet.'}</li>
                    <li>Distance Covered: ${player.distance_covered !== null ? player.distance_covered + ' km' : 'No data present yet.'}</li>
                    <li>Yellow Cards: ${player.yellow_cards !== null ? player.yellow_cards : 'No data present yet.'}</li>
                    <li>Red Cards: ${player.red_cards !== null ? player.red_cards : 'No data present yet.'}</li>
                    <li>Fouls: ${player.fouls !== null ? player.fouls : 'No data present yet.'}</li>
                    <li>Saves: ${player.saves !== null ? player.saves : 'No data present yet.'}</li>
                </ul>
            </section>
            <section class="next-week-schedule">
                <h3>Next Week Schedule</h3>
                <table>
                    <tr><th>Day</th><th>Event</th></tr>
                    <tr><td>Monday</td><td>Training</td></tr>
                    <tr><td>Tuesday</td><td>Rest Day</td></tr>
                    <tr><td>Wednesday</td><td>Team Meeting</td></tr>
                    <tr><td>Thursday</td><td>Training</td></tr>
                    <tr><td>Friday</td><td>Match Preparation</td></tr>
                    <tr><td>Saturday</td><td>Match Day</td></tr>
                    <tr><td>Sunday</td><td>Rest Day</td></tr>
                </table>
            </section>
        `;
        playerDashboard.innerHTML = playerInfo;
    }
});
