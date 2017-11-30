<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Commercial Generator</title>


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


<form class="myForm" action="make_commercial.jsp" method="get" enctype="application/x-www-form-urlencoded" action="/html/codes/html_form_handler.cfm">

<p>
<label style = "color: green">
Input your product data into this form to receive the best recommendations for your commercial
</label>
</p>

<p>
<label>Price
<input type="text" name="product_price" placeholder="Price" required>
</label>
</p>
	
<p>
<label>Market 
<select name="market" required>
	<option style="color:gray" value="">Market</option>
	<option value="Video Games">Video Games</option>
	<option value="Toys & Games">Toys & Games</option>
	<option value="Books">Books</option>
	<option value="Electronics">Electronics</option>
	<option value="Camera & Photo">Camera & Photo</option>
	<option value="Clothes">Clothes</option>
</select>
</label> 
</p>


<p>
<label>
Male
<input type="radio" name="Gender" value="Male" style="margin-left:-100px"/>
</label>
</p>
<p>
<label>
Female
<input type="radio" name="Gender" value="Female"style="margin-left:-100px"/>
</label>
</p>

<p><button onclick="createCommercial()">Create my commercial!</button></p>




	
</body>
</html>