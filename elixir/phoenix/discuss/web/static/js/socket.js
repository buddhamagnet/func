import {Socket} from "phoenix"

const socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicID) => {
  const channelID = `comments:${ topicID }`;
  const channel = socket.channel(channelID, {})
  channel.join()
  .receive("ok", resp => { console.log(`joined channel ${ channelID }`, resp) })
  .receive("error", resp => { console.log(`Unable to join ${ channelID }`, resp) })

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;
    channel.push('comments:add', {content})
  });
}

window.createSocket = createSocket;
