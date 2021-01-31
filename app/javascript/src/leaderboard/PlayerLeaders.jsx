import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { render } from 'react-dom';

function PlayerLeaders(props) {
  const [data, setData] = useState({ leaders: [] });

  useEffect(() => {
    async function setLeaders() {
      const response = await axios(
        '/api/v1/roster_players?league_tournament_id=' + props.leagueTournamentId
      );
      setData({
        leaders: response.data.data.map(function(player) {
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
    setInterval(
      setLeaders,
      60 * 1000
    );
    setLeaders();
  }, []);

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
          <tr key="{leader.id}">
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
