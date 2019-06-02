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
          {this.props.pick.player.first_name} {this.props.pick.player.last_name}
        </div>
      </div>
    ) : ""
  }
}

export default Pick
