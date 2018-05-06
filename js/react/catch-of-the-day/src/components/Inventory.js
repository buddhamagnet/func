import React, { Component } from 'react';
import AddFishForm from './AddFishForm';

export default class Inventory extends Component {
  handleChange = (e, key) => {
    const fish = this.props.fishes[key]
    const updatedFish = {
      ...fish,
      [e.target.name]: e.target.value
    }
    this.props.updateFish(key, updatedFish)
  }
  renderInventory = (key) => {
    const fish = this.props.fishes[key]
    return (
      <div className="fish-edit" key={key}>
        <input onChange={(e) => this.handleChange(e, key)} type="text" name="name" value={fish.name} placeholder="name" />
        <input onChange={(e) => this.handleChange(e, key)}type="text" name="price" value={fish.price} placeholder="price" />
        <select onChange={(e) => this.handleChange(e, key)}name="status">
          <option value="available">available</option>
          <option value="unavailable">sold out</option>
        </select>
        <textarea onChange={(e) => this.handleChange(e, key)}placeholder="description" value={fish.desc}></textarea>
        <input onChange={(e) => this.handleChange(e, key)} type="text" name="image" value={fish.image} placeholder="image" />
        <button onClick={() => this.props.deleteFish(key)}>&times;</button>
      </div>
    )
  }
  render() {
    return (
      <div>
        <h2>inventory</h2>
        <button onClick={this.props.loadFishes}>load fishes</button>
        {Object.keys(this.props.fishes).map(this.renderInventory)}
        <AddFishForm addFish={this.props.addFish} />
      </div>
    );
  }
}