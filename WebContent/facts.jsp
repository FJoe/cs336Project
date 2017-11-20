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
<body>
	<div id="links" style="width:100%">
		<a class="link" href="home.jsp">Home</a>
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="delete.jsp">Delete Tuple</a>
		<a class="link" href="facts.jsp">Commercial Generator</a>
		<a class="link" href="facts_channel.jsp">Viewer Favorites</a>
		<a class="link" href="facts_commercial.jsp">Where to Advertise</a>
		<a class="link" href="facts_consumer.jsp">I want to shop</a>
		<a class="link" href="most_popular.jsp">The Most Popular</a>
	</div>


<form class="myForm" action="make_commercial.jsp" method="get" enctype="application/x-www-form-urlencoded" action="/html/codes/html_form_handler.cfm">

<p>
<label style = "color: green">
Input your product data into this form to receive the best recommendations for your commercial
</label>
</p>

<p>
<label>Product Name
<input type="text" name="product_name" required placeholder="Product Name">
</label> 
</p>

<p>
<label>Company
<input type="text" name="company" placeholder="Company" required>
</label>
</p>

<p>
<label>Price
<input type="text" name="product_price" placeholder="Price" required>
</label>
</p>
	
<p>
<label>Market 
<select id="chooseMarket_table" required>
	<option style="color:gray" value="">Market</option>
	<option value="product">Video Games</option>
	<option value="commercial">Toys & Games</option>
	<option value="consumer">Books</option>
	<option value="channel">Electronics</option>
	<option value="consumer">Camera & Photo</option>
	<option value="channel">Clothes</option>
</select>
</label> 
</p>


<p>
<label>
Male
<input type="radio" name="Gender" required value="Male" style="margin-left:-100px"/>
</label>
</p>
<p>
<label>
Female
<input type="radio" name="Gender" required value="Female"style="margin-left:-100px"/>
</label>
</p>

<p><button onclick="createCommercial()">Create my commercial!</button></p>








<!--

</head>
<body>
	<div id="links" style="width:100%">
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="edit.jsp">Edit Tuple</a>
		<a class="link" href="facts.jsp">Facts</a>
	</div>
	<br>
	I am a: 
	<select id="choose_table" size=1 style="margin-bottom: 5px;">
		<option value="product">Product</option>
		<option value="commercial">Commercial</option>
		<option value="consumer">Consumer</option>
		<option value="channel">Channel</option>
	</select>&nbsp;<br>
	<button onclick="selectAdd()">Select</button>
			
	<br>
	<br>
	
	<form id="product" method="post" action="add_tuple.jsp" >
		<input type="text" value="Product" name="table" style="display:none">
		<input type="text" placeholder="Product Name" name="Name" style="width: 200px; margin-bottom: 5px; padding:5px;">
		<br>
		<input type="text" placeholder="Price" name="Price" style="width: 200px; margin-bottom: 5px; padding:5px">
		<br>
		<select id="chooseMarket_table" size=1 style="width: 211px; margin-bottom: 5px; padding:5px;">
			<option style="color:gray" value="null">Market</option>
			<option value="product">Video Games</option>
			<option value="commercial">Toys & Games</option>
			<option value="consumer">Books</option>
			<option value="channel">Electronics</option>
			<option value="consumer">Camera & Photo</option>
			<option value="channel">Clothes</option>
		</select>&nbsp;
		<br>
		<input type="text" placeholder="Company" name="Company" style="width: 200px; margin-bottom: 5px;padding:5px;">
		<br>
		<input type="radio" name="Gender" value="Male" />Male
		<br>
		<input type="radio" name="Gender" value="Female" style ="margin-bottom: 5px;"/>Female
		<br>
		<input type="submit" value="Make my commercial!">
	</form>
	
	
	
	
	-->
	
</body>
</html>