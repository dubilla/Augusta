import React from "react"
import PropTypes from "prop-types"

class Pick extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return this.props.pick ? (
      <div>
        <div>
          {this.props.pick.player_id}
        </div>
        <div>
          {this.props.pick.team_id}
        </div>
      </div>
    ) : ""
  }
}

export default Pick
