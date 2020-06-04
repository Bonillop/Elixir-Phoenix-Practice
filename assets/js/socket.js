import { Socket } from "phoenix"

// the params object gets mapped to the params argument in user_socket.ex
if(window.userToken) {
  let socket = new Socket("/socket", { params: { token: window.userToken } });
  socket.connect();

  const createSocket = (topicId) => {
    let channel = socket.channel(`comments:${topicId}`, {})
    channel.join()
      .receive("ok", resp => { 
        renderComments(resp.comments); 
      })
      .receive("error", resp => { console.log("Unable to join", resp) })
  
    // Here we add the handler for the broadcast in the server
    channel.on(`comments:${topicId}:new`, (event) => {
      // Whenever we broadcast something, javascript receives an event object, which contains the data 
      // that we broadcast, in this case just the comment
      renderComment(event.comment)
    });
  
    document.querySelector("button").addEventListener("click", function () {
      const textarea = document.querySelector("textarea")
      const content = textarea.value;
      textarea.value = "";
      channel.push("comment:add", { content: content });
    });
  
  }
  
  // Renders initial list of comments when the user joins the channel
  function renderComments(comments) {
    const renderedComments = comments.map(comment => {
      return commentTemplate(comment);
    });
  
    document.querySelector(".collection").innerHTML = renderedComments.join("");
  }
  
  // Renders a specific comment when the server broadcasts the message
  function renderComment(comment) {
    const renderedComment = commentTemplate(comment);
  
    document.querySelector(".collection").innerHTML += renderedComment;
  }
  
  function commentTemplate(comment) {
    let email = "Anonymous";
  
    if(comment.user){
      email = comment.user.email;
    }
    return `
    <li class="collection-item">
      ${comment.content}
      <div class="secondary-content">
        ${email}
      </div>
    </li>
    `;
  }
  
  // Probably not the cleanest solution, but for this arquitecture it works
  window.createSocket = createSocket;
}


