import React from "react"
import PropTypes from "prop-types"

class PlayersList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      players: []
    };
  }

  static getDerivedStateFromProps(props, state) {
    return {
      players: props.players
    }
  }

  render() {
    return (
      <ul>
        {this.state.players.map((player) => {
          return <li key={player.id}>{player.first_name} {player.last_name}</li>
        })}
      </ul>
    )
  }
}

export default PlayersList
