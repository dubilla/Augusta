import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { render } from 'react-dom';

function TeamLeaders(props) {
  const [data, setData] = useState({ leaders: [] });

  useEffect(async () => {
    async function setLeaders() {
      const response = await axios(
        '/api/v1/rosters?league_tournament_id=' + props.leagueTournamentId
      );
      setData({
        leaders: response.data.data.map(function(team) {
          return {
            id: team.id,
            name: team.attributes.name,
            score: team.attributes.score
          }
        })
      });
    };
    setInterval(
      setLeaders,
      60 * 1000
    );
  }, []);

  return (
    <div>
      <table className="table-minimal w-full border-gray-300">
        <tbody>
          {data.leaders.map(leader => (
            <tr key="{leader.id}">
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
