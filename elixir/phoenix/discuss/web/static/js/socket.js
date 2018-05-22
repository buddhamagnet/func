import {Socket} from "phoenix"

const socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicID) => {
  const channelID = `comments:${ topicID }`;
  const channel = socket.channel(channelID, {});
  channel.join()
  .receive("ok", resp => {
    renderComments(resp.comments);
  })
  .receive("error", resp => { console.log(`Unable to join ${ channelID }`, resp) });

  channel.on(`comments:${ topicID }:new`, renderComment);

  document.querySelector('button').addEventListener('click', () => {
    const content = getElement('textarea').value;
    channel.push('comments:add', {content})
  });
}

const getElement = (name) => document.querySelector(name)

const commentsList = () => getElement(".collection")

const commentTemplate = (comment) => {
  return `<li class="collection-item">${comment.content} by <small>${ user(comment) }</small></li>`
}

const user = (comment) => comment.user && comment.user.email || 'anonymous';

const renderComment = (event) => {
  commentsList().innerHTML += commentTemplate(event.comment);
}

const renderComments = (comments) => {
  console.dir(comments);
  const renderedComments = comments.map((comment) => {
    return commentTemplate(comment);
  });
  commentsList().innerHTML = renderedComments.join('');
};


window.createSocket = createSocket;
