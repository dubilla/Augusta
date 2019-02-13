class AvailabilityTable extends React.Component {
  render(props) {
    const golfers = this.props.golfers;
    const golferItems = golfers.map((golfer) =>
      <tr key={golfer.id}>
        <td>{golfer.first_name} {golfer.last_name}</td>
      </tr>
    );
    return (
      <table>
        <tbody>
          {golferItems}
        </tbody>
      </table>
    );
  }
};

class Draft extends React.Component {
  render(props) {
    return (
      <div>
        <h2>{this.props.league_name} Draft</h2>
        <section>
          <h3>Available Golfers</h3>
          <AvailabilityTable golfers={this.props.golfers}/>
        </section>
      </div>
    )
  }
};
