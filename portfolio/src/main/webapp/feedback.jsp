<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%
  UserService userService = UserServiceFactory.getUserService();
  boolean isLoggedIn = userService.isUserLoggedIn();
  String loginURL = userService.createLoginURL("/feedback.jsp");
  String logoutURL = userService.createLogoutURL("/feedback.jsp");
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>My Portfolio</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="script.js"></script>
  </head>
  <body>
    <div id="content">
      <h1>Daniel Ostashev</h1>
      <div class="topnav">
        <a href="index.html">Home</a>
        <a href="blog.html">Blog</a>
        <a class="active" href="feedback.jsp">Feedback</a>
        <a href="data.html">Data</a>
        <a href="tsp.html">TSP</a>
      </div>
      <div id="user-container">
        <p>
          Signed in as <b><%= isLoggedIn ? userService.getCurrentUser().getEmail() : null %></b>
          <br>
          <a href="<%= logoutURL %>" style="float: right; margin-right: 3px;">Sign Out</a>
        </p>
      </div>
      <br>
      <p id="logged-out-message">You have to <a href="<%= loginURL %>">sign in</a> to leave a comment<p>
      <div id="comment-editor">
        <h2>Tell me what you think:</h2>
        <form onsubmit="return submitComment(this)">
          <div class="comment-author">
            <label for="author">Your name:</label><input class="comment-author" name="author" maxlength="30">
          </div>
          <textarea class="comment-text" name="text" id="comment-input" maxlength="1500"></textarea>
          <button class="comment-submit" type="submit">Leave comment</button>
        </form>
      </div>
      <div id="page-selector">
         <button onclick="commentLoader.loadFirstPage()">First page</button>
         <button id="prev-page-button" onclick="commentLoader.loadPrevPage()">Prev page</button>
         <input id="comments-per-page" type="number" value="10" min="1" max="100" onchange="refreshComments()">
         <button id="next-page-button" onclick="commentLoader.loadNextPage()">Next page</button>
         <button onclick="commentLoader.loadLastPage()">Last page</button>
      </div>
      <div id="comment-list"></div>
      <script type="text/javascript">refreshComments()</script>
    </div>
    <script type="text/javascript">setupLoggedInBasedContent(<%= isLoggedIn %>)</script>
  </body>
</html>
