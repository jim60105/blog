// Modified for Misskey API
// Original Mastodon version: https://carlschwan.eu/2020/12/29/adding-comments-to-your-static-blog-with-mastodon/

let blogPostAuthorText = document.getElementById(
  "blog-post-author-text"
).textContent;
let renotesFromText = document.getElementById("renotes-from-text").textContent;
let dateLocale = document.getElementById("date-locale").textContent;
let reactionsFromText = document.getElementById(
  "reactions-from-text"
).textContent;
let host = document.getElementById("host").textContent;
let id = document.getElementById("id").textContent;
let lazyAsyncImage = document.getElementById("lazy-async-image").textContent;
let loadingText = document.getElementById("loading-text").textContent;
let noCommentsText = document.getElementById("no-comments-text").textContent;
let relAttributes = document.getElementById("rel-attributes").textContent;
let reloadText = document.getElementById("reload-text").textContent;
let sensitiveText = document.getElementById("sensitive-text").textContent;
let user = document.getElementById("user").textContent;
let viewCommentText = document.getElementById("view-comment-text").textContent;
let viewProfileText = document.getElementById("view-profile-text").textContent;

document
  .getElementById("load-comments")
  .addEventListener("click", loadComments);

function escapeHtml(unsafe) {
  return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function emojify(input, emojis) {
  let output = input;

  // Misskey emojis is an object { shortcode: url }
  if (emojis && typeof emojis === "object") {
    Object.keys(emojis).forEach((shortcode) => {
      let img = document.createElement("img");
      img.className = "emoji";
      img.setAttribute("src", escapeHtml(emojis[shortcode]));
      img.setAttribute("alt", `:${shortcode}:`);
      img.setAttribute("title", `:${shortcode}:`);
      if (lazyAsyncImage == "true") {
        img.setAttribute("decoding", "async");
        img.setAttribute("loading", "lazy");
      }

      output = output.replace(`:${shortcode}:`, img.outerHTML);
    });
  }

  return output;
}

function textToHtml(text) {
  if (!text) return "";

  // Escape HTML first
  let html = escapeHtml(text);

  // Convert URLs to links
  html = html.replace(
    /(https?:\/\/[^\s<]+)/g,
    '<a href="$1" rel="' + relAttributes + '">$1</a>'
  );

  // Convert @mentions to links (handle both local @user and remote @user@host)
  html = html.replace(
    /@([a-zA-Z0-9_]+)(?:@([a-zA-Z0-9.-]+))?/g,
    function (match, username, mentionHost) {
      if (mentionHost) {
        return `<a href="https://${mentionHost}/@${username}" rel="${relAttributes}">@${username}@${mentionHost}</a>`;
      } else {
        return `<a href="https://${host}/@${username}" rel="${relAttributes}">@${username}</a>`;
      }
    }
  );

  // Convert hashtags to links
  html = html.replace(
    /#([a-zA-Z0-9_\u4e00-\u9fff]+)/g,
    `<a href="https://${host}/tags/$1" rel="${relAttributes}">#$1</a>`
  );

  // Convert newlines to <br>
  html = html.replace(/\n/g, "<br>");

  return html;
}

async function fetchAllReplies(noteId) {
  let allReplies = [];
  let hasMore = true;
  let untilId = null;

  while (hasMore) {
    const body = {
      noteId: noteId,
      limit: 100,
    };
    if (untilId) {
      body.untilId = untilId;
    }

    const response = await fetch(`https://${host}/api/notes/replies`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });

    const replies = await response.json();

    if (replies && Array.isArray(replies) && replies.length > 0) {
      allReplies = allReplies.concat(replies);
      untilId = replies[replies.length - 1].id;

      // If we got less than limit, we've reached the end
      if (replies.length < 100) {
        hasMore = false;
      }
    } else {
      hasMore = false;
    }
  }

  // Recursively fetch replies to replies
  for (const reply of allReplies) {
    if (reply.repliesCount > 0) {
      const nestedReplies = await fetchAllReplies(reply.id);
      allReplies = allReplies.concat(nestedReplies);
    }
  }

  return allReplies;
}

async function loadComments() {
  let commentsWrapper = document.getElementById("comments-wrapper");
  commentsWrapper.innerHTML = "";

  let loadCommentsButton = document.getElementById("load-comments");
  loadCommentsButton.innerHTML = loadingText;
  loadCommentsButton.disabled = true;

  try {
    const replies = await fetchAllReplies(id);

    if (replies && Array.isArray(replies) && replies.length > 0) {
      commentsWrapper.innerHTML = "";

      replies.forEach(function (note) {
        console.log(note);

        // Get display name
        let displayName = note.user.name || note.user.username;
        if (displayName) {
          displayName = escapeHtml(displayName);
          displayName = emojify(displayName, note.user.emojis);
        } else {
          displayName = note.user.username;
        }

        // Determine instance
        let instance = note.user.host || host;

        // Check if this is a nested reply
        const isReply = note.replyId !== id;

        // Check if this is the original poster
        let op = false;
        if (
          note.user.username.toLowerCase() === user.toLowerCase() &&
          note.user.host === null
        ) {
          op = true;
        }

        // Convert text to HTML and emojify
        let contentHtml = textToHtml(note.text);
        contentHtml = emojify(contentHtml, note.emojis || {});

        // Construct URLs
        const noteUrl = note.user.host
          ? note.uri || `https://${note.user.host}/notes/${note.id}`
          : `https://${host}/notes/${note.id}`;
        const profileUrl = note.user.host
          ? `https://${note.user.host}/@${note.user.username}`
          : `https://${host}/@${note.user.username}`;

        let comment = document.createElement("article");
        comment.id = `comment-${note.id}`;
        comment.className = isReply ? "comment comment-reply" : "comment";
        comment.setAttribute("itemprop", "comment");
        comment.setAttribute("itemtype", "http://schema.org/Comment");

        let avatarImg = document.createElement("img");
        avatarImg.className = "avatar";
        avatarImg.setAttribute("src", note.user.avatarUrl);
        avatarImg.setAttribute(
          "alt",
          `@${note.user.username}@${instance} avatar`
        );
        if (lazyAsyncImage == "true") {
          avatarImg.setAttribute("decoding", "async");
          avatarImg.setAttribute("loading", "lazy");
        }

        let avatar = document.createElement("a");
        avatar.className = "avatar-link";
        avatar.setAttribute("href", profileUrl);
        avatar.setAttribute("rel", relAttributes);
        avatar.setAttribute(
          "title",
          `${viewProfileText} @${note.user.username}@${instance}`
        );
        avatar.appendChild(avatarImg);
        comment.appendChild(avatar);

        let instanceBadge = document.createElement("a");
        instanceBadge.className = "instance";
        instanceBadge.setAttribute("href", profileUrl);
        instanceBadge.setAttribute(
          "title",
          `@${note.user.username}@${instance}`
        );
        instanceBadge.setAttribute("rel", relAttributes);
        instanceBadge.textContent = instance;

        let display = document.createElement("span");
        display.className = "display";
        display.setAttribute("itemprop", "author");
        display.setAttribute("itemtype", "http://schema.org/Person");
        display.innerHTML = displayName;

        let header = document.createElement("header");
        header.className = "author";
        header.appendChild(display);
        header.appendChild(instanceBadge);
        comment.appendChild(header);

        let permalink = document.createElement("a");
        permalink.setAttribute("href", noteUrl);
        permalink.setAttribute("itemprop", "url");
        permalink.setAttribute("title", `${viewCommentText} ${instance}`);
        permalink.setAttribute("rel", relAttributes);
        permalink.textContent = new Date(note.createdAt).toLocaleString(
          dateLocale,
          {
            dateStyle: "long",
            timeStyle: "short",
          }
        );

        let timestamp = document.createElement("time");
        timestamp.setAttribute("datetime", note.createdAt);
        timestamp.appendChild(permalink);
        permalink.classList.add("external");
        comment.appendChild(timestamp);

        let main = document.createElement("main");
        main.setAttribute("itemprop", "text");

        // Handle content warning (cw)
        if (note.cw != null && note.cw !== "") {
          let summary = document.createElement("summary");
          summary.innerHTML = escapeHtml(note.cw);

          let spoiler = document.createElement("details");
          spoiler.appendChild(summary);
          spoiler.innerHTML += contentHtml;

          main.appendChild(spoiler);
        } else {
          main.innerHTML = contentHtml;
        }
        comment.appendChild(main);

        // Handle file attachments
        let files = note.files;
        let media = document.createElement("div");
        media.className = "attachments";
        if (files && Array.isArray(files) && files.length > 0) {
          files.forEach((file) => {
            let mediaElement;
            const fileType = file.type.split("/")[0];

            switch (fileType) {
              case "image":
                mediaElement = document.createElement("img");
                mediaElement.setAttribute("src", file.thumbnailUrl || file.url);

                if (file.comment != null) {
                  mediaElement.setAttribute("alt", file.comment);
                  mediaElement.setAttribute("title", file.comment);
                }

                if (lazyAsyncImage == "true") {
                  mediaElement.setAttribute("decoding", "async");
                  mediaElement.setAttribute("loading", "lazy");
                }

                if (file.isSensitive == true) {
                  mediaElement.classList.add("spoiler");
                }
                break;

              case "video":
                mediaElement = document.createElement("video");
                mediaElement.setAttribute("src", file.url);
                mediaElement.setAttribute("controls", "");

                if (file.comment != null) {
                  mediaElement.setAttribute("aria-title", file.comment);
                  mediaElement.setAttribute("title", file.comment);
                }

                if (file.isSensitive == true) {
                  mediaElement.classList.add("spoiler");
                }
                break;

              case "audio":
                mediaElement = document.createElement("audio");
                mediaElement.setAttribute("src", file.url);
                mediaElement.setAttribute("controls", "");

                if (file.comment != null) {
                  mediaElement.setAttribute("aria-title", file.comment);
                  mediaElement.setAttribute("title", file.comment);
                }
                break;
            }

            if (mediaElement) {
              let mediaLink = document.createElement("a");
              mediaLink.setAttribute("href", file.url);
              mediaLink.setAttribute("rel", relAttributes);
              mediaLink.appendChild(mediaElement);

              media.appendChild(mediaLink);
            }
          });

          comment.appendChild(media);
        }

        let interactions = document.createElement("footer");

        let renotes = document.createElement("a");
        renotes.className = "boosts";
        renotes.setAttribute("href", noteUrl);
        renotes.setAttribute(
          "title",
          `${renotesFromText}`.replace("$INSTANCE", instance)
        );

        let renotesIcon = document.createElement("i");
        renotesIcon.className = "icon";
        renotes.appendChild(renotesIcon);
        renotes.insertAdjacentHTML("beforeend", ` ${note.renoteCount}`);
        interactions.appendChild(renotes);

        let reactions = document.createElement("a");
        reactions.className = "faves";
        reactions.setAttribute("href", noteUrl);
        reactions.setAttribute(
          "title",
          `${reactionsFromText}`.replace("$INSTANCE", instance)
        );

        let reactionsIcon = document.createElement("i");
        reactionsIcon.className = "icon";
        reactions.appendChild(reactionsIcon);
        reactions.insertAdjacentHTML("beforeend", ` ${note.reactionCount}`);
        interactions.appendChild(reactions);
        comment.appendChild(interactions);

        if (op === true) {
          comment.classList.add("op");

          avatar.classList.add("op");
          avatar.setAttribute(
            "title",
            `${blogPostAuthorText}: ` + avatar.getAttribute("title")
          );

          instanceBadge.classList.add("op");
          instanceBadge.setAttribute(
            "title",
            `${blogPostAuthorText}: ` + instanceBadge.getAttribute("title")
          );
        }

        commentsWrapper.innerHTML += comment.outerHTML;
      });
    } else {
      var statusText = document.createElement("p");
      statusText.innerHTML = noCommentsText;
      statusText.setAttribute("id", "comments-status");
      commentsWrapper.appendChild(statusText);
    }

    loadCommentsButton.innerHTML = reloadText;
  } catch (error) {
    console.error("Error loading comments:", error);
  } finally {
    loadCommentsButton.disabled = false;
  }
}
