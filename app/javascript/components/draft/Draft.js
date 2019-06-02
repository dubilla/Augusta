import React from "react"
import PropTypes from "prop-types"
import PlayersList from "./PlayersList"
import Picks from "./Picks"

class Draft extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      players: [],
      picks: [],
      teamCount: props.teamCount
    };
  }

  componentDidMount() {
    fetch('/players')
      .then(response => response.json())
      .then(players =>
        this.setState({
          players
        }));
    fetch(`/draft_picks?draft_id=${this.props.draft_id}`)
      .then(response => response.json())
      .then(picks =>
        this.setState({
          draftPicks: picks
        }));
  }

  render() {
    return (
      <div>
        <Picks picks={this.state.draftPicks} teamCount={this.state.teamCount} />
        <PlayersList players={this.state.players}  />
      </div>
    );
  }
}

export default Draft
