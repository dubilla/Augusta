import React from "react"
import PropTypes from "prop-types"
import PlayersList from "./PlayersList"
import Slots from "./Slots"

class Draft extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      players: [],
      picks: []
    };
  }

  componentDidMount() {
    fetch('/players')
      .then(response => response.json())
      .then(players =>
        this.setState({
          players
        }));
    fetch(`/draft_slots?draft_id=${this.props.draft_id}`)
      .then(response => response.json())
      .then(slots =>
        this.setState({
          slots
        }));
  }

  render() {
    return (
      <div>
        <Slots slots={this.state.slots} />
        <PlayersList players={this.state.players}  />
      </div>
    );
  }
}

export default Draft
