<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Find best channel</title>


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
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="edit.jsp">Edit Tuple</a>
		<a class="link" href="facts.jsp">Commercial Generator</a>
		<a class="link" href="facts_channel.jsp">Viewer Favorites</a>
		<a class="link" href="facts_commercial.jsp">Best Channel for Me?</a>
		<a class="link" href="facts_consumer.jsp">consumer?</a>
	</div>



<form class="myForm" action="make_commercial.jsp" method="get" enctype="application/x-www-form-urlencoded" action="/html/codes/html_form_handler.cfm">

<p>
<label>Commercial Title
<input type="text" name="commercial_title" required placeholder="Commercial Title">
</label> 
</p>

<p>
<label>Tactic
<select id="chooseMarket_table" required>
	<option style="color:gray" value="">Choose Tactic</option>
	<option value="Action">Action</option>
	<option value="Celebrity_Sponsor">Celebrity Sponsor</option>
	<option value="Comedy">Comedy</option>
	<option value="Factual">Factual</option>
	<option value="Fear">Fear</option>
	<option value="Guilt">Guilt</option>
</select>
</label> 
</p>
	
<p>
<label>City
<select id="chooseMarket_table" required>
	<option style="color:gray" value="">Choose Closest City</option>
	<option value="Boston">Boston</option>
	<option value="Chicago">Chicago</option>
	<option value="Dallas">Dallas</option>
	<option value="Detroit">Detroit</option>
	<option value="Houston">Houston</option>
	<option value="Los_Angeles">Los Angeles</option>
	<option value="New_York">New York</option>
	<option value="Philadelphia">Philadelphia</option>
	<option value="Phoenix">Phoenixt</option>
	<option value="San_Diego">San Diego</option>
</select>
</label> 
</p>


<p><button >Find the best channel for my commercial!</button></p>




</body>
</html>>