import React, { Component } from 'react';
import { formatPrice } from '../helpers';

export default class Fish extends Component {
  render() {
    const { fish, index } = this.props;
    const isAvailable = fish.status === 'available';
    const buttonText = isAvailable ? 'Add to order' : 'Sold out';
    return (
      <li className="menu-fish">
        <img src={fish.image} alt={fish.name} />
        <h3 className="fish-name">{fish.name}</h3>
        <span className="price">{formatPrice(fish.price)}</span>
        <p>{fish.description}</p>
        <button onClick={() => this.props.addToOrder(index)} disabled={!isAvailable}>{buttonText}</button>
      </li>
     );
  }
}