import React, { useState, useEffect } from 'react';

function TeamLeaders(props) {
  const [data, setData] = useState({ leaders: [] });

  useEffect(() => {
    async function setLeaders() {
      const response = await fetch(
        '/api/v1/rosters?league_tournament_id=' + props.leagueTournamentId
      );
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const json = await response.json();
      setData({
        leaders: json.data.map(function(team) {
          return {
            id: team.id,
            name: team.attributes.name,
            score: team.attributes.score
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

  return (
    <div>
      <table className="table-minimal w-full border-gray-300">
        <tbody>
          {data.leaders.map(leader => (
            <tr key={leader.id}>
              <td className="p-2 border-b border-gray-300">
                {leader.name}
              </td>
              <td className="p-2 border-b border-gray-300">
                {leader.score}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default TeamLeaders;
