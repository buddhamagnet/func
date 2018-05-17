import {Socket} from "phoenix"

const socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicID) => {
  const channelID = `comments:${ topicID }`;
  const channel = socket.channel(channelID, {})
  channel.join()
  .receive("ok", resp => {
    renderComments(resp.comments);
  })
  .receive("error", resp => { console.log(`Unable to join ${ channelID }`, resp) });

  channel.on(`comments:${ topicID }:new`, renderComment);

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;
    channel.push('comments:add', {content})
  });
}

const commentTemplate = (comment) => {
  return `<li class="collection-item">${comment.content}</li>`
}

const renderComment = (event) => {
  document.querySelector(".collection").innerHTML += commentTemplate(event.comment);
}

const renderComments = (comments) => {
  const renderedComments = comments.map((comment) => {
    return commentTemplate(comment);
  });
  document.querySelector(".collection").innerHTML = renderedComments.join('');
};


window.createSocket = createSocket;
