import React, { Component } from 'react';
import { formatPrice } from '../helpers';
import CSSTransitionGroup from 'react-addons-css-transition-group'

export default class Order extends Component {
  renderOrder = (key) => {
    console.log(key);
    const fish = this.props.fishes[key];
    const count = this.props.order[key];
    if (!fish || fish.status === 'unavailable') {
      return <li key={key}>Sorry {fish ? fish.name : 'this fish'} is unavailable</li>
    }
    return (
      <li key={key}>
        <span>
          <CSSTransitionGroup
          component="span"
          className="count"
          transitionName="count"
          transitionEnterTimeout={250}
          transitionLeaveTimeout={250}>
          <span key={count}>{count}</span>
          </CSSTransitionGroup>
          lbs {fish.name}
          <button onClick={() => this.props.remove(key)}>&times;</button>
        </span>
        <span className="price">{formatPrice(count * fish.price)}</span>
      </li>

    );
  }
  render() {
    const orderIds = Object.keys(this.props.order);
    const total = orderIds.reduce((prevTotal, key) => {
      const fish = this.props.fishes[key];
      const count = this.props.order[key];
      const isAvailable = fish && fish.status === 'available';
      if (isAvailable) {
        return prevTotal + (count * fish.price || 0);
      }
      return prevTotal;
    }, 0);
    return (
      <div className="order-wrap">
        <h2>Order</h2>
        <CSSTransitionGroup
        component="ul"
        className="order"
        transitionName="order"
        transitionEnterTimeout={500}
        transitionLeaveTimeout={500}>
          {orderIds.map(this.renderOrder)}
        </CSSTransitionGroup>
        <p>{formatPrice(total)}</p>
      </div>
    );
  }
}
