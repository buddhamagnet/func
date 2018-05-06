import React, { Component } from 'react';

export default class AddFishForm extends Component {
  createFish = (event) => {
    event.preventDefault();
    const fish = { 
      name: this.name.value,
      price: this.price.value,
      status: this.status.value,
      desc: this.desc.value,
      image: this.image.value
    }
    this.props.addFish(fish)
    this.form.reset();
  }
  render() {
    return (
      <form ref={(input) => this.form = input} className="fish-edit" onSubmit={(e) => this.createFish(e)}>
        <input ref={(input) => this.name = input} type="text" placeholder="fish name" />
        <input ref={(input) => this.price = input} type="text" placeholder="fish price" />
        <select ref={(input) => this.status = input}>
          <option value="available">fresh!</option>
          <option value="unavailable">sold out!</option>
        </select>
        <textarea ref={(input) => this.desc = input} placeholder="fish desc" />
        <input ref={(input) => this.image = input} type="text" placeholder="fish image" />
        <button type="submit">add item</button>
      </form>
    );
  }
}