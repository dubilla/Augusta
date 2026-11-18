import React from 'react';
import { render } from 'react-dom';
import TeamLeaders from './TeamLeaders';

document.addEventListener('DOMContentLoaded', () => {
  const $elem = document.getElementById('team-leaders');
  if (!$elem) return;

  render(<TeamLeaders leagueTournamentId={$elem.dataset.leagueTournamentId} />, $elem);
});
