import React from 'react';
import { render } from 'react-dom';
import TeamLeaders from './TeamLeaders';

document.addEventListener('DOMContentLoaded', () => {
  const $elem = document.getElementById('team-leaders');
  const leagueTournamentId = $elem.dataset.leagueTournamentId;
  render(<TeamLeaders leagueTournamentId={leagueTournamentId} />, $elem);
});
