import React, { Component } from 'react'

import YTSearch from 'youtube-api-search';

import SearchBar from './search_bar';
import { VideoList, VideoDetail } from './videos';

const YTKey = 'AIzaSyB6iXh3MeXcQ8nzmj_K6WucDA6WPLXk998';

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      videos: [],
      selectedVideo: null
    };
    YTSearch({key: YTKey, term: 'react js'}, videos => {
      this.setState(
        {
          videos,
          selectedVideo: videos[0]
        }
      );
    });
  }
  render() {
    return(
      <div>
        <SearchBar />
        <VideoDetail video={this.state.selectedVideo} />
        <VideoList
          onVideoSelect={selectedVideo => this.setState({selectedVideo})}
          videos={this.state.videos}/>
      </div>
    );
  }
}