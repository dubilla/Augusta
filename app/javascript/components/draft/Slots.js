import React from "react"
import PropTypes from "prop-types"
import Pick from "./Pick"

class Slots extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      slots: []
    };
  }

  static getDerivedStateFromProps(props, state) {
    return {
      slots: props.slots
    }
  }

  render() {
    return this.props.slots ? (
      <ul>
        {this.props.slots.map((slot, i) => {
          return (
            <li key={slot.order}>
              <div>
                Slot {slot.order}
              </div>
              <div>
                {slot.team.name}
              </div>
              <Pick pick={slot.draft_pick} />
            </li>
          )
        })}
      </ul>
    ) : "";
  }
}

export default Slots
