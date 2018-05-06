import React, { Component } from 'react'
import Base from '../base'
import Header from './Header'
import Order from './Order'
import Inventory from './Inventory'
import Fish from './Fish'

import SampleFishes from '../sample-fishes'

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      fishes: {},
      order: {}
    };
  }
  componentWillMount() {
    this.ref = Base.syncState(`${this.props.params.storeId}/fishes`,
    { context: this, state: 'fishes'})
    const ls = localStorage.getItem(`order-${this.props.params.storeId}`)
    if (ls) this.setState({order: JSON.parse(ls)})
  }
  componentWillUnmount() {
    // Switched store, remove binding so mounting will
    // switch to sync with new store.
    Base.removeBinding(this.ref)
  }
  componentWillUpdate(nextProps, nextState) {
    localStorage.setItem(`order-${this.props.params.storeId}`, JSON.stringify(nextState.order))
  }
  loadFishes = () => {
    this.setState({fishes: SampleFishes});
  }
  addToOrder = (key) => {
    const order = {...this.state.order};
    order[key] = order[key] + 1 || 1;
    this.setState({ order });
  };
  removeFromOrder = (key) => {
    const order = {...this.state.order};
    delete order[key];
    this.setState({ order });
  };
  addFish = (fish) => {
    const fishes = {...this.state.fishes}
    fishes[`fish${Date.now()}`] = fish;
    this.setState({ fishes })
  };
  updateFish = (key, fish) => {
    const fishes = {...this.state.fishes}
    fishes[key] = fish;
    this.setState({ fishes })
  };
  deleteFish = (key) => {
    const fishes = {...this.state.fishes}
    fishes[key] = null
    this.setState({ fishes })
  };
  render() {
    return (
      <div className="catch-of-the-day">
        <div className="menu">
          <Header tagline="Fill Me In"/>
          <ul>
          { 
            Object
              .keys(this.state.fishes)
              .map((fish, i) => <Fish addToOrder={this.addToOrder} fish={this.state.fishes[fish]} key={'fish' + i} index={'fish' + i} />)
          }
          </ul>
        </div>
        <Order
          fishes={this.state.fishes}
          order={this.state.order}
          params={this.props.params}
          remove={this.removeFromOrder} />
        <Inventory fishes={this.state.fishes} deleteFish={this.deleteFish} updateFish={this.updateFish} addFish={this.addFish} loadFishes={this.loadFishes} />
      </div>
    );
  }
}
