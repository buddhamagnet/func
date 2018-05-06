class ProductList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      products: [],
    };
    this.handleProductUpvote = this.handleProductUpvote.bind(this);
  }
  handleProductUpvote(productId) {
    this.setState({
      products: this.state.products.map((product) => {
        if (product.id === productId) {
          return Object.assign({}, product, {
            votes: product.votes + 1,
          });
        } else {
          return product;
        }
      })
    });
  }
  render() {
    const sorted = this.state.products.sort((a, b) => b.votes - a.votes);
    const products = sorted.map((product) => (
        <Product
          key={product.id}
          id={product.id}
          title={product.title}
          description={product.description}
          url={product.url}
          votes={product.votes}
          onVote={this.handleProductUpvote}
          submitterAvatarURL={product.submitterAvatarURL}
          productImageURL={product.productImageURL}
        />
    ));
    return (
      <div className='ui unstackable items'>
        {products}
      </div>
    );
  }
  componentDidMount() {
    this.setState({ products: Seed.products });
  }
}

class Product extends React.Component {
  constructor(props) {
    super(props);
    this.handleUpvote = this.handleUpvote.bind(this);
  }
  handleUpvote() {
    this.props.onVote(this.props.id)
  }
  render() {
    return (
      <div className='item'>
        <div className='image'>
          <img src={this.props.productImageURL} />
        </div>
        <div className='middle aligned content'>
          <div className='header'>
            <a onClick={this.handleUpvote}>
              <i className='large caret up icon' />
            </a>
            {this.props.votes}
          </div>
          <div className='description'>
            <a href={this.props.url}>
              {this.props.title}
            </a>
            <p>{this.props.description}</p>
          </div>
          <div className='extra'>
            <span>submitted by:</span>
            <img
              className='ui avatar image'
              src={this.props.submitterAvatarURL}
            />
          </div>
        </div>
      </div>
    );
  }
}

ReactDOM.render(<ProductList />, document.getElementById('content'));
