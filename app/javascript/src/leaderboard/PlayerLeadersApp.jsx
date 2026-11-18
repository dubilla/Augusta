import React from 'react';
import { render } from 'react-dom';
import PlayerLeaders from './PlayerLeaders';

document.addEventListener('DOMContentLoaded', () => {
  const $elem = document.getElementById('player-leaders');
  if (!$elem) return;

  render(<PlayerLeaders leagueTournamentId={$elem.dataset.leagueTournamentId} />, $elem);
});
