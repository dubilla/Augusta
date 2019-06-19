import React from "react"
import PropTypes from "prop-types"

class PlayersList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  handleClick = (player) => {
    this.props.onSelection(player);
  }

  render() {
    let pickCell;
    if (this.props.isUserPickPending) {
      pickCell = (player) =>
        <td><button onClick={() => this.handleClick(player)}>Pick</button></td>;
    } else {
      pickCell = () =>
        <td></td>;
    }
    return (
      <table>
        <tbody>
          {this.props.players.map((player) => {
            return (
              <tr key={player.id}>
                {pickCell(player)}
                <td>
                  {player.first_name} {player.last_name}
                </td>
              </tr>
            )
          })}
        </tbody>
      </table>
    )
  }
}

export default PlayersList
