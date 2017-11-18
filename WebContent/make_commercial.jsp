<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make Commercial</title>
</head>
<body>
	<div id="links" style="width:100%">
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="edit.jsp">Edit Tuple</a>
		<a class="link" href="facts.jsp">Facts</a>
	</div>
	
	<%
	var mysql = require('mysql');

	var con = mysql.createConnection({
	  host: " francisjoetest.c4lvmvi7tnes.us-east-2.rds.amazonaws.com",
	  user: "FJoe",
	  password: "bluemonkey"
	});

	con.connect(function(err) {
	  if (err) throw err;
	  console.log("Connected!");
	  con.query("SELECT * FROM customers", function (err, result, fields) {
		   if (err) throw err;
		   console.log(result);
	});
	
	
	
	
	
	
		
	%>
</body>
</html>