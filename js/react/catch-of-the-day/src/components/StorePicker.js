import React, { Component } from 'react';
import { getFunName } from '../helpers';

export default class StorePicker extends Component {
  goToStore = (event) => {
    event.preventDefault();
    let store = this.storeInput.value;
    this.context.router.transitionTo('/store/' + store);
  }
  // The input box below uses a functional ref to store the element
  // as a property on the class.
  render() {
    return (
      <div>
        <form className="store-selector" onSubmit={this.goToStore}>
          <h2>please enter a store</h2>
          <input ref={(input) => { this.storeInput = input }} type="text" required placeholder="store name" defaultValue={getFunName()} />
          <button type="submit">visit store</button>
        </form>
      </div>
    );
  }
}

StorePicker.contextTypes = {
  router: React.PropTypes.object
}
