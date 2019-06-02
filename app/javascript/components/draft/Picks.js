import React from "react"
import PropTypes from "prop-types"
import Pick from "./Pick"

class Picks extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      picks: [],
      slotCount: 4 * props.teamCount
    };
  }

  static getDerivedStateFromProps(props, state) {
    return {
      picks: props.picks
    }
  }

  render() {
    return (
      <ul>
        {[...Array(this.state.slotCount)].map((_, i) => {
          return this.state.picks ? (
            <li key={i + 1}>
              <div>
                Pick {i + 1}
              </div>
              <Pick pick={this.state.picks[i]} />
            </li>
          ) : ""
        }, this)}
      </ul>
    )
  }
}

export default Picks
