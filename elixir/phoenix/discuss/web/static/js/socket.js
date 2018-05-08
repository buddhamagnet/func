import {Socket} from "phoenix"

const socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicID) => {
  const channelID = `comments:${ topicID }`;
  const channel = socket.channel(channelID, {})
  channel.join()
  .receive("ok", resp => { console.log(`joined channel ${ channelID }`, resp) })
  .receive("error", resp => { console.log(`Unable to join ${ channelID }`, resp) })
}

window.createSocket = createSocket;
