<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>CommercialFacts</title>
</head>

<style>
.buttons { 
  width: 60%;
  height: 40%;
  table-layout: fixed;
  

}
.buttons button { 
  width: 100%;
  font-size:100%;
}
</style>



<body>
	<center>
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
	</div>
	</center>
	<br>
	<br>
	<p style = "">
	<center>
	<img src="https://i.imgur.com/GBFADS9.png" alt="title" border="0"></a>
	<br><br><br>
			
	<table class="buttons">
    	<tr><td>
    	<button type="button" onclick="location.href='facts_consumer.jsp';" >
    				I want to<br>Look for Products and Commercials</button></td>
    	<td><button type="button" onclick="location.href='facts.jsp';">
    				I want to<br>Create a Commercial for my Product</button></td></tr>
    	<tr>
	    <td><button type="button" onclick="location.href='facts_channel.jsp';">
	    			I want to<br>Find the best Commercials for my Channel</button></td>
	    <td><button type="button" onclick="location.href='patterns.jsp';">
	    			I am curious<br>And just looking for some patterns!</button></td></tr>
	</table>
	
	</center>
	<p>
	
</body>
</html>