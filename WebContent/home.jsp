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
  height: 20%;
  table-layout: fixed;
 

}
.buttons button { 
  width: 100%;
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
	<img src="https://preview.ibb.co/fUj5hm/title.gif" alt="title" border="0"></a>
	
	
	<br>
	<img src ="https://78.media.tumblr.com/a981475cb25e1a2123d5bd10e90b6117/tumblr_ms2kuucJdD1qkjjfoo1_500.gif"
			width="250 height="300">
			
	<table class="buttons">
    	<tr><td>
    	<button type="button" onclick="location.href='facts_consumer.jsp';" >
    				I am a Consumer<br>Looking for Products</button></td>
    	<td><button type="button" onclick="location.href='facts.jsp';">
    				I am a Product<br>Looking to create a Commercial</button></td></tr>
    	<tr>
	    <td><button type="button" onclick="location.href='facts_channel.jsp';">
	    			I am a Channel<br>Looking for the best Commercials</button></td>
	    <td><button type="button" onclick="location.href='patterns.jsp';">
	    			I am curious<br>And just looking for some patterns!</button></td></tr>
	</table>
	
	</center>
	<p>
	
</body>
</html>