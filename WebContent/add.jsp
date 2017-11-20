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
		<input type="text" value="Airs" name="table" style="display:none">
		<input type="text" placeholder="Commercial Name" name="Commercial">
		<br>
		<input type="text" placeholder="Channel Name" name="Channel">
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="channel" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Channel" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name">
		<br>
		<input type="text" placeholder="Genre" name="Genre">
		<br>
		<input type="text" placeholder="Taget Age" name="Target Age">
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="commercial" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Commercial" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name">
		<br>
		<input type="text" placeholder="Tactic" name="Tactic">
		<br>
		<input type="text" placeholder="City" name="City">
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="consumer" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Consumer" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name">
		<br>
		<input type="text" placeholder="City" name="City">
		<br>
		<input type="text" placeholder="Age" name="Age">
		<br>
		<input type="radio" name="Gender" value="Male"/>Male
		<br>
		<input type="radio" name="Gender" value="Female"/>Female
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="interested" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Interested" name="table" style="display:none">
		<input type="text" placeholder="Consumer" name="Consumer">
		<br>
		<input type="text" placeholder="Product" name="Product">
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="product" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Product" name="table" style="display:none">
		<input type="text" placeholder="Name" name="Name">
		<br>
		<input type="text" placeholder="Price" name="Price">
		<br>
		<input type="text" placeholder="Market" name="Market">
		<br>
		<input type="text" placeholder="Company" name="Company">
		<br>
		<input type="radio" name="Gender" value="Male"/>Male
		<br>
		<input type="radio" name="Gender" value="Female"/>Female
		<br>
		<input type="submit" value="Add Value">
	</form>

	<form id="sees" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Sees" name="table" style="display:none">
		<input type="text" placeholder="Consumer" name="Consumer">
		<br>
		<input type="text" placeholder="Commercial" name="Commercial">
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="sells" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Sells" name="table" style="display:none">
		<input type="text" placeholder="Commercial" name="Commercial">
		<br>
		<input type="text" placeholder="Product" name="Product">
		<br>
		<input type="submit" value="Add Value">
	</form>
	
	<form id="watches" method="post" style="display:none" action="add_tuple.jsp">
		<input type="text" value="Watches" name="table" style="display:none">
		<input type="text" placeholder="Consumer" name="Consumer">
		<br>
		<input type="text" placeholder="Channel" name="Channel">
		<br>
		<input type="submit" value="Add Value">
	</form>
	<br>
	<br>

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