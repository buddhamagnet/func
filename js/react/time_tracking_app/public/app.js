class TimersDashboard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      timers: []
    }
    this.handleCreateFormSubmit = this.handleCreateFormSubmit.bind(this);
    this.handleEditFormSubmit = this.handleEditFormSubmit.bind(this);
    this.handleTrashClick = this.handleTrashClick.bind(this);
    this.handleStartClick = this.handleStartClick.bind(this);
    this.handleStopClick = this.handleStopClick.bind(this);
    this.createTimer = this.createTimer.bind(this);
    this.updateTimer = this.updateTimer.bind(this);
    this.deleteTimer = this.deleteTimer.bind(this);
    this.startTimer = this.startTimer.bind(this);
    this.stopTimer = this.stopTimer.bind(this);
    this.loadTimersFromServer = this.loadTimersFromServer.bind(this);
  }
  render() {
    return (
      <div className='ui three column centered grid'>
        <div className='column'>
          <EditableTimerList
            timers={this.state.timers}
            onFormSubmit={this.handleEditFormSubmit}
            onTrashClick={this.handleTrashClick}
            onStartClick={this.handleStartClick}
            onStopClick={this.handleStopClick}
          />
          <ToggleableTimerForm
            onFormSubmit={this.handleCreateFormSubmit}
          />
        </div>
      </div>
    );
  }
  componentDidMount() {
    this.loadTimersFromServer();
    setInterval(this.loadTimersFromServer, 5000);
  }
  loadTimersFromServer() {
    client.getTimers((serverTimers)=> (
      this.setState({timers: serverTimers})
      )
    );
  }
  handleCreateFormSubmit(timer) {
    this.createTimer(timer);
  }
  handleEditFormSubmit(attrs) {
    this.updateTimer(attrs);
  }
  handleTrashClick(timerId) {
    this.deleteTimer(timerId);
  }
  handleStartClick(timerId) {
    this.startTimer(timerId);
  }
  handleStopClick(timerId) {
    this.stopTimer(timerId);
  }
  createTimer(timer) {
    const t = helpers.newTimer(timer);
    this.setState({
      timers: this.state.timers.concat(t),
    });
    client.createTimer(t);
  }
  updateTimer(attrs) {
    this.setState({
      timers: this.state.timers.map((timer) => {
        if (timer.id === attrs.id) {
          return Object.assign({}, timer, {
            title: attrs.title,
            project: attrs.project,
          });
        } else {
          return timer;
        }
      }),
    });
    client.updateTimer(attrs);
  }
  deleteTimer(timerId) {
    this.setState({
      timers: this.state.timers.filter((timer) => timer.id !== timerId)
    });
    client.deleteTimer({
      id: timerId
    });
  }
  startTimer(timerId) {
    const now = Date.now();
    this.setState({
      timers: this.state.timers.map((timer)=> {
        if (timer.id === timerId) {
          return Object.assign({}, timer, {
            runningSince: now
          });
        } else {
          return timer;
        }
      }),
    });
    client.startTimer({
      id: timerId,
      start: now
    });
  }
  stopTimer(timerId) {
    const now = Date.now();
    this.setState({
      timers: this.state.timers.map((timer) => {
        if (timer.id === timerId) {
          const lastElapsed = now - timer.runningSince;
          return Object.assign({}, timer, {
            elapsed: timer.elapsed + lastElapsed,
            runningSince: null
          })
        } else {
          return timer;
        }
      }),
    });
    client.stopTimer({
      id: timerId,
      stop: now
    });
  }
}

class EditableTimerList extends React.Component {
  render() {
    const timers = this.props.timers.map((timer) => (
       <EditableTimer
          key={timer.id}
          id={timer.id}
          title={timer.title}
          project={timer.project}
          elapsed={timer.elapsed}
          runningSince={timer.runningSince}
          onFormSubmit={this.props.onFormSubmit}
          onTrashClick={this.props.onTrashClick}
          onStartClick={this.props.onStartClick}
          onStopClick={this.props.onStopClick}
        />
    ));
    return (
      <div id='timers'>
        {timers}
      </div>
    );
  }
}

class EditableTimer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      editFormOpen: false,
    }
    this.handleEditClick = this.handleEditClick.bind(this);
    this.handleFormClose = this.handleFormClose.bind(this);
    this.handleFormOpen = this.handleFormOpen.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.openForm = this.openForm.bind(this);
    this.closeForm = this.closeForm.bind(this);
  }
  render() {
    if (this.state.editFormOpen) {
      return (
        <TimerForm
          id={this.props.id}
          title={this.props.title}
          project={this.props.project}
          onFormClose={this.handleFormClose}
          onFormSubmit={this.handleSubmit}
        />
      );
    } else {
      return (
        <Timer
          id={this.props.id}
          title={this.props.title}
          project={this.props.project}
          elapsed={this.props.elapsed}
          runningSince={this.props.runningSince}
          onEditClick={this.handleEditClick}
          onTrashClick={this.props.onTrashClick}
          onStartClick={this.props.onStartClick}
          onStopClick={this.props.onStopClick}
        />
      );
    }
  }
  handleEditClick() {
    this.openForm();
  }
  handleFormClose() {
    this.closeForm();
  }
  handleFormOpen() {
    this.openForm();
  }
  handleSubmit(timer) {
    this.props.onFormSubmit(timer);
    this.closeForm();
  }
  closeForm() {
    this.setState({
      editFormOpen: false
    });
  }
  openForm() {
    this.setState({
      editFormOpen: true
    });
  }
}

class TimerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: this.props.title || '',
      project: this.props.project || '',
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  render() {
    const submitText = this.props.id ? 'Update' : 'Create';
    return (
      <div className='ui centered card'>
        <div className='content'>
          <div className='ui form'>
            <div className='field'>
              <label>Title</label>
              <input
                type='text'
                name='title'
                value={this.state.title}
                onChange={this.handleChange}
              />
            </div>
            <div className='field'>
              <label>Project</label>
              <input
                type='text'
                name='project'
                value={this.state.project}
                onChange={this.handleChange}
              />
            </div>
            <div className='ui two bottom attached buttons'>
              <button
                className='ui basic blue button'
                onClick={this.handleSubmit}
              >
                {submitText}
              </button>
              <button
                className='ui basic red button'
                onClick={this.props.onFormClose}
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
  handleChange(e) {
    this.setState({
      [e.target.name]: e.target.value
    });
  }
  handleSubmit() {
    this.props.onFormSubmit({
      id: this.props.id,
      title: this.state.title,
      project: this.state.project,
    });
  };
}

class Timer extends React.Component {
  constructor(props) {
    super(props);
    this.handleTrashClick = this.handleTrashClick.bind(this);
    this.handleStartClick = this.handleStartClick.bind(this);
    this.handleStopClick = this.handleStopClick.bind(this);
  }
  render() {
    const elapsedString = helpers.renderElapsedString(
      this.props.elapsed, this.props.runningSince
    );
    return (
      <div className='ui centered card'>
        <div className='content'>
          <div className='header'>
            {this.props.title}
          </div>
          <div className='meta'>
            {this.props.project}
          </div>
          <div className='center aligned description'>
            <h2>
              {elapsedString}
            </h2>
          </div>
          <div className='extra content'>
            <span
              className='right floated edit icon'
              onClick={this.props.onEditClick}>
              <i className='edit icon' />
            </span>
            <span
              className='right floated trash icon'
              onClick={this.handleTrashClick} >
              <i className='trash icon' />
            </span>
          </div>
        </div>
        <TimerActionButton
          timerIsRunning={!!this.props.runningSince}
          onStartClick={this.handleStartClick}
          onStopClick={this.handleStopClick}
        />
      </div>
    );
  }
  componentDidMount() {
    this.forceUpdateInterval = setInterval(() => this.forceUpdate(), 50);
  }
  componentWillUnmount() {
    clearInterval(this.forceUpdateInterval);
  }
  handleTrashClick() {
    this.props.onTrashClick(this.props.id);
  }
  handleStartClick() {
    this.props.onStartClick(this.props.id);
  }
  handleStopClick() {
    this.props.onStopClick(this.props.id);
  }
}

class TimerActionButton extends React.Component {
  render() {
    if (this.props.timerIsRunning) {
      return (
        <div
          className='ui bottom attached red basic button'
          onClick={this.props.onStopClick}>
          Stop
        </div>
      );
    } else {
      return (
        <div
          className='ui bottom attached green basic button'
          onClick={this.props.onStartClick}>
          Start
        </div>
      );
    }
  }
}

class ToggleableTimerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isOpen: false
    }
    this.handleFormOpen = this.handleFormOpen.bind(this);
    this.handleFormClose = this.handleFormClose.bind(this);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
  }
  render() {
    if (this.state.isOpen) {
      return (
        <TimerForm
          onFormClose={this.handleFormClose}
          onFormSubmit={this.handleFormSubmit}
        />
      );
    } else {
      return (
        <div className='ui basic content center aligned segment'>
          <button onClick={this.handleFormOpen} className='ui basic button icon'>
            <i className='plus icon' />
          </button>
        </div>
      );
    }
  }
  handleFormOpen() {
    this.setState({
      isOpen: true
    });
  }
  handleFormClose() {
    this.setState({
      isOpen: false
    });
  }
  handleFormSubmit(timer) {
    this.props.onFormSubmit(timer);
    this.setState({
      isOpen: false
    });
  }
}

ReactDOM.render(
  <TimersDashboard />,
  document.getElementById('content')
)

