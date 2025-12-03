function addComment(sender)
{
    let mainDiv = document.createElement('div');
    let controlsDiv = document.createElement('div');
    let editBtn = document.createElement('button');
    let editImg = document.createElement('img');
    let deleteBtn = document.createElement('button');
    let deleteImg = document.createElement('img');
    let textDiv = document.createElement('div');
    let text = document.createElement('span');

    mainDiv.className = "comment";
    controlsDiv.className = "comment-controls";
    editBtn.setAttribute('onclick', 'editComment(this)');
    editImg.src = "../resources/img/edit-text.png";
    deleteBtn.setAttribute('onclick', 'deleteComment(this)');
    deleteImg.src = "../resources/img/recycle-bin.png";
    textDiv.className = "comment-text";

    text.innerHTML = prompt("Add Comment:");

    textDiv.appendChild(text);
    editBtn.appendChild(editImg);
    deleteBtn.appendChild(deleteImg);
    controlsDiv.appendChild(editBtn);
    controlsDiv.appendChild(deleteBtn);
    mainDiv.appendChild(controlsDiv);
    mainDiv.appendChild(textDiv);

    sender.parentNode.appendChild(mainDiv);
}

function editComment(sender)
{
    mainDiv = sender.parentNode;
    textDiv = mainDiv.nextElementSibling;
    currentText = textDiv.firstElementChild.innerHTML;
    let newText = prompt("Edit Comment:", currentText);
    textDiv.firstElementChild.innerHTML = newText;
}