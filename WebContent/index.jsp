<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Commercials</title>

<style>
table {    
	font-family: arial, sans-serif;    
	border-collapse: collapse;    
	width: 100%;
}
td, th {    
	border: 1px solid #dddddd;    
	text-align: left;    
	padding: 8px;
}
tr:nth-child(even) {    
	background-color: #dddddd;
}
tr:nth-child(odd) {    
	background-color: white;
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
	<br>
	<br>
	<form method="post" action="index.jsp">
		<select name="table" type="submit" size=1>
			<option value="airs">Airs</option>
			<option value="channel">Channel</option>
			<option value="commercial">Commercial</option>
			<option value="consumer">Consumer</option>
			<option value="interested">Interested</option>
			<option value="product">Product</option>
			<option value="sees">Sees</option>
			<option value="sells">Sells</option>
			<option value="watches">Watches</option>
		</select>&nbsp;<br><input type="submit" value="submit">
	</form>
	<%
    
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			String table = request.getParameter("table");
			
			if(table == null)
				table = "airs";
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM cs336db." + table;
			
			
			out.print("<p>Current Table: <b>" + table + "</b>");
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			ResultSetMetaData resultMD = result.getMetaData();
			
			//Make an HTML table to show the results in:
			out.print("<div style = \"background-color:white;border:solid;border-radius:5px;\"><table>");
	
			//make a row
			out.print("<tr>");
			for(int i = 0; i < resultMD.getColumnCount(); i++){
				out.print("<td>");
				out.print("<b>" + resultMD.getColumnName(i + 1) + "</b>");
				out.print("</td>");
			}
			out.print("</tr>");
	
			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				for(int i = 0; i < resultMD.getColumnCount(); i++){
					out.print("<td>");
					out.print(result.getString(resultMD.getColumnName(i+1)));
					out.print("</td>");
				}
				out.print("</tr>");
	
			}
			out.print("</table><div>");
	
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>