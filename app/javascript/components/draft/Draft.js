import React from "react"
import PropTypes from "prop-types"
import PlayersList from "./PlayersList"
import Slots from "./Slots"
import NextAlert from "./NextAlert"

class Draft extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      players: [],
      slots: []
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
        this.setState(() => ({
          slots,
          nextSlot: this.findNextSlot(slots)
        })));
  }

  addDraftPick(pick) {
    this.setState((currentState) => {
      return {
        slots: currentState.slots.map((slot) => {
          if (slot.id === currentState.nextSlot.id) {
            slot.draft_pick = {
              player: pick.player
            }
            return slot;
          }
          return slot;
        })
      };
    });
  }

  findNextSlot(slots) {
    return slots.find(function(element) {
      return !element.draft_pick;
    });
  }

  isUserPickPending() {
    return this.state.nextSlot && this.state.nextSlot.team.id === this.props.current_team.id;
  }

  handleSelection = (player) => {
    let body = JSON.stringify({
      draft_pick: {
        draft_slot_id: this.state.nextSlot.id,
        player_id: player.id
      }
    });
    fetch('/draft_picks/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: body
    }).then((response) => { return response.json() })
    .then((pick) => {
      this.addDraftPick(pick);
    });
  }

  render() {
    let nextAlert;
    if (this.isUserPickPending()) {
      nextAlert = <NextAlert nextSlot={this.state.nextSlot} />
    } else {
      nextAlert = "";
    }
    return (
      <div>
        {nextAlert}
        <Slots slots={this.state.slots} />
        <PlayersList players={this.state.players} isUserPickPending={this.isUserPickPending()} onSelection={(player) => this.handleSelection(player)}/>
      </div>
    );
  }
}

export default Draft
