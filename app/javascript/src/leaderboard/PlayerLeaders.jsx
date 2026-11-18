import React, { useState, useEffect } from 'react';

function PlayerLeaders(props) {
  const [data, setData] = useState({ leaders: [] });

  useEffect(() => {
    async function setLeaders() {
      const response = await fetch(
        '/api/v1/roster_players?league_tournament_id=' + props.leagueTournamentId
      );
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const json = await response.json();
      setData({
        leaders: json.data.map(function(player) {
          return {
            id: player.id,
            name: player.attributes.name,
            score: player.attributes.score,
            user_name: player.attributes.user_name,
            status: player.attributes.status
          }
        })
      });
    };
    const refresh = () =>
      setLeaders().catch((error) => console.error('Leaderboard refresh failed:', error));
    refresh();
    const interval = setInterval(refresh, 60 * 1000);
    return () => clearInterval(interval);
  }, [props.leagueTournamentId]);

  return(
    <table className="table-minimal table-fixed w-full border-gray-300">
      <thead>
        <tr>
          <th className="p-2 border-b border-gray-300 text-left">
            Golfer
          </th>
          <th className="p-2 border-b border-gray-300 text-left">
            Foursome
          </th>
          <th className="p-2 border-b border-gray-300 text-left">
            Total
          </th>
          <th className="p-2 border-b border-gray-300 text-left">
            Thru
          </th>
        </tr>
      </thead>
      <tbody>
        {data.leaders.map(leader => (
          <tr key={leader.id}>
            <td className="p-2 border-b border-gray-300">
              {leader.name}
            </td>
            <td className="p-2 border-b border-gray-300">
              {leader.user_name}
            </td>
            <td className="p-2 border-b border-gray-300">
              {leader.score}
            </td>
            <td className="p-2 border-b border-gray-300">
              {leader.status}
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

export default PlayerLeaders;
