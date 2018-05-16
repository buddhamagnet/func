import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { selectBook } from '../actions';

class BookList extends Component {
  renderList() {
    return this.props.books.map((book) => {
      return (
        <li
        onClick={() => this.props.selectBook(book)}
        key={book.title}
        className="list-group-item">
          {book.title}

        </li>
      );
    });
  }
  render() {
    return (
      <div>
      <ul className="list-group col-sm-4">
        {this.renderList()}
      </ul>
      </div>
    )
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(
    {selectBook}, dispatch
  );
}

function mapStateToProps(state) {
  return {
    books: state.books
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(BookList);
