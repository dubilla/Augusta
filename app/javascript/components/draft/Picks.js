import React from "react"
import PropTypes from "prop-types"

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
          return (
            <li key={i + 1}>
              <div>
                Pick {i + 1}
              </div>
              <div>
                {this.state.picks[i]}
              </div>
            </li>
          )
        })}
      </ul>
    )
  }
}

export default Picks
