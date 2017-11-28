<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add table</title>
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
	<br>
	<select id="choose_table" size=1>
		<option value="airs">Airs</option>
		<option value="channel">Channel</option>
		<option value="commercial">Commercial</option>
		<option value="consumer">Consumer</option>
		<option value="interested">Interested</option>
		<option value="product">Product</option>
		<option value="sees">Sees</option>
		<option value="sells">Sells</option>
		<option value="watches">Watches</option>
	</select>&nbsp;<br>
	<button onclick="selectAdd()">Select</button>
	
	<br>
	<br>

	<p id="adding"> Adding to table: <b>airs</b></p>

	<form id="airs" method="post" action="add_tuple.jsp">
		<input type="text" value="airs" name="table" style="display:none">
		<input type="text" placeholder="Commercial Name" name="Commercial" required>
		<br>
		<input type="text" placeholder="Channel Name" name="Channel" required>
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="channel" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="channel" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name"required>
		<br>
		<select name="Genre" required>
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
		<br>
		<select name="TargetAge" required>
			<option style="color:gray" value="">Choose Age</option>
			<option value="70">All Ages</option>
			<option value="20">Teen</option>
			<option value="30">20-30</option>
			<option value="40">31-40</option>
			<option value="50">41-50</option>
			<option value="60">51+</option>
		</select>
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="commercial" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="commercial" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name" required>
		<br>
		<select name="Tactic" required>
			<option style="color:gray" value="">Choose Genre</option>
			<option value="Action">Action</option>
			<option value="Celebrity Sponsor">Celebrity Sponsor</option>
			<option value="Factual">Factual</option>
			<option value="Fear">Fear</option>
			<option value="Comedy">Comedy</option>
			<option value="Guilt">Guilt</option>
		</select>
		<br>
		<select name="City" required>
			<option style="color:gray" value="">Choose Closest City</option>
			<option value="Boston">Boston</option>
			<option value="Chicago">Chicago</option>
			<option value="Dallas">Dallas</option>
			<option value="Detroit">Detroit</option>
			<option value="Houston">Houston</option>
			<option value="Los Angeles">Los Angeles</option>
			<option value="New York">New York</option>
			<option value="Philadelphia">Philadelphia</option>
			<option value="Phoenix">Phoenix</option>
			<option value="San Diego">San Diego</option>
		</select>
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="consumer" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="consumer" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name" required>
		<br>
		<select name="City" required>
			<option style="color:gray" value="">Choose Closest City</option>
			<option value="Boston">Boston</option>
			<option value="Chicago">Chicago</option>
			<option value="Dallas">Dallas</option>
			<option value="Detroit">Detroit</option>
			<option value="Houston">Houston</option>
			<option value="Los Angeles">Los Angeles</option>
			<option value="New York">New York</option>
			<option value="Philadelphia">Philadelphia</option>
			<option value="Phoenix">Phoenix</option>
			<option value="San Diego">San Diego</option>
		</select>
		<br>
		<input type="text" placeholder="Age" name="Age" required>
		<br>
		<input type="radio" name="Gender" value="Male"/>Male
		<br>
		<input type="radio" name="Gender" value="Female"/>Female
		<br>
		<input type="radio" name="Gender" value="Unknown"/>Unknown
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="interested" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="interested" name="table" style="display:none">
		<input type="text" placeholder="Consumer" name="Consumer" required>
		<br>
		<input type="text" placeholder="Product" name="Product"required>
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="product" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="product" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name" required>
		<br>
		<input type="text" placeholder="Price" name="Price" required>
		<br>
		<select name="Market" required>
			<option style="color:gray" value="">Choose Market</option>
			<option value="Clothes">Clothes</option>
			<option value="Books">Books</option>
			<option value="Electronics">Electronics</option>
			<option value="Camera & Photo">Camera & Photot</option>
			<option value="Toys & Games">Toys & Games</option>
			<option value="Video Games">Video Games</option>
		</select>
		<br>
		<input type="text" placeholder="Company" name="Company" required>
		<br>
		<input type="radio" name="Gender" value="Male"/>Male
		<br>
		<input type="radio" name="Gender" value="Female"/>Female
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="sees" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="sees" name="table" style="display:none">
		<input type="text" placeholder="Consumer" name="Consumer" required>
		<br>
		<input type="text" placeholder="Commercial" name="Commercial" required>
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="sells" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="sells" name="table" style="display:none">
		<input type="text" placeholder="Commercial" name="Commercial" required>
		<br>
		<input type="text" placeholder="Product" name="Product"required>
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="watches" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="watches" name="table" style="display:none">
		<input type="text" placeholder="Consumer" name="Consumer" required>
		<br>
		<input type="text" placeholder="Channel" name="Channel" required>
		<br>
		<input type="submit" value="Add Value">
	</form>
	<br>
	<br>
	
	<p>	<b>WARNING: Adding an entity (Channel, Commercial, Consumer, or Product) is only possible if the entity name is not already present.</b></p>
	<p> <b>Example: Consumer a cannot be interested in product b if b is not present in the Product table</b></p>
	<p>	<b>WARNING: Adding a relationship (Airs, Interested, Sees, Sells, or Watches) will only be added if both entities involved are present in the table.</b></p>
	<p> <b>Example: Consumer a cannot be interested in product b if b is not present in the Product table</b></p>

<script>
function selectAdd(){
	var formsCollection = document.getElementsByTagName("form");
	for(var i=0;i<formsCollection.length;i++)
	{
	   formsCollection[i].style.display = "none";
	}
	var selected = document.getElementById("choose_table");
	var tableName = selected.options[selected.selectedIndex].value;
	var display  = document.getElementById(String(tableName));

	display.style.display = "block";
	
	document.getElementById("adding").innerHTML = "Adding to table: <b>" + tableName + "</b>";
	document.getElementById("links").style.display = "block";
}
</script>
</body>
</html>