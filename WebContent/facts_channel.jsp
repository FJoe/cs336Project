<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Find viewer favorites</title>


<!-- CSS -->
<style>
.myForm {
font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
font-size: 0.8em;
width: 30em;
padding: 1em;
}

.myForm * {
box-sizing: border-box;
}

.myForm label {
padding: 0;
font-weight: bold;
text-align: right;
display: block;
}

.myForm input,
.myForm select,
.myForm textarea {
margin-left: 2em;
float: right;
width: 20em;
border: 1px solid #ccc;
font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
font-size: 0.9em;
padding: 0.3em;
}

.myForm textarea {
height: 100px;
}

.myForm button {
padding: 1em;
border-radius: 0.5em;
background: #eee;
border: none;
font-weight: bold;
margin-left: 14em;
margin-top: 1.8em;
}

.myForm button:hover {
background: #ccc;
cursor: pointer;
}
</style>

</head>
<body><center>
	<div id="links" style="width:100%">
		<a class="link" href="home.jsp">Home</a>
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="delete.jsp">Delete Tuple</a>
		<a class="link" href="facts.jsp">Commercial Generator</a>
		<a class="link" href="facts_channel.jsp">Viewer Favorites</a>
		<a class="link" href="facts_consumer.jsp">I want to shop</a>
		<a class="link" href="most_popular.jsp">Entity Stats</a>
		<a class="link" href="patterns.jsp">Patterns</a>
	</div></center>



<form class="myForm" action="make_channel_recs.jsp" method="get" enctype="application/x-www-form-urlencoded" action="/html/codes/html_form_handler.cfm">

<p>
<label style = "color: green">
Input your channel data here to find which commercials your typical viewers will enjoy the most
</label>
</p>

<p>
<label>Genre
<select name="genre" required>
	<option style="color:gray" value="">Choose Genre</option>
	<option value="Action">Action</option>
	<option value="Animation">Animation</option>
	<option value="Comedy">Comedy</option>
	<option value="Cooking">Cooking</option>
	<option value="Drama">Drama</option>
	<option value="Game Show">Game Show</option>
	<option value="Horror">Horror</option>
	<option value="Kids">Kids</option>
	<option value="News">News</option>
</select>
</label> 
</p>
	
<p>
<label>Target Age
<select name="age" required>
	<option style="color:gray" value="">Choose Age</option>
	<option value="70">All Ages</option>
	<option value="20">Teen</option>
	<option value="30">20-30</option>
	<option value="40">31-40</option>
	<option value="50">41-50</option>
	<option value="60">51+</option>
</select>
</label> 
</p>


<p><button onclick="createCommercial()">Find my ideal commercials!</button></p>




</body>
</html>