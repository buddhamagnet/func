import React, { Component } from 'react'

import YTSearch from 'youtube-api-search';

import SearchBar from './search_bar';
import { VideoList, VideoDetail } from './videos';

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      videos: [],
      selectedVideo: null
    };
    this.videoSearch();
  }
  videoSearch(term = 'grider udemy') {
    YTSearch({key: process.env.API_KEY, term}, videos => {
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
        <SearchBar
          videoSearch={term => this.videoSearch(term)} />
        <VideoDetail video={this.state.selectedVideo} />
        <VideoList
          onVideoSelect={selectedVideo => this.setState({selectedVideo})}
          videos={this.state.videos} />
      </div>
    );
  }
}