import React from 'react';
import { render } from 'react-dom';
import PlayerLeaders from './PlayerLeaders';

document.addEventListener('DOMContentLoaded', () => {
  const $elem = document.getElementById('player-leaders');
  const leagueTournamentId = $elem.dataset.leagueTournamentId;
  render(<PlayerLeaders leagueTournamentId={leagueTournamentId} />, $elem);
});
