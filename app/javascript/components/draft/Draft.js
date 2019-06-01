import React from "react"
import PropTypes from "prop-types"
import PlayersList from "./PlayersList"
class Draft extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      players: []
    };
  }

  componentDidMount() {
    fetch('/players')
      .then(response => response.json())
      .then(players =>
        this.setState({
          players
        }));
  }

  render() {
    return (
      <div>
        <PlayersList players={this.state.players} />
      </div>
    );
  }
}

export default Draft
