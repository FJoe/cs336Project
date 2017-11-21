<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Facts - CommercialFacts</title>
</head>
<body>
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
	<br>
	
	<!-- Prints Patterns -->
	<%
    
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		Statement stmt = con.createStatement();
		
		String str = "SELECT c.gender AS Gender, Count(i.Consumer) as 'Interested in Video Games' " + 
				"FROM Project.Consumer c JOIN Project.Interested i JOIN Project.Product p " +
				"WHERE p.Market = 'video games' AND i.Product = p.Name AND c.Name = i.Consumer GROUP BY c.Gender";
		
		out.print("<p>More guys are interested in video games than girls: </p>");
		
		ResultSet result = stmt.executeQuery(str);
		ResultSetMetaData resultMD = result.getMetaData();
		
		//Make an HTML table to show the results in:
		out.print("<table>");

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
		out.print("</table>");
		
		stmt = con.createStatement();
		
		str = "SELECT c.gender AS Gender, Count(i.Consumer) as 'Interested in Clothes' " + 
				"FROM Project.Consumer c JOIN Project.Interested i JOIN Project.Product p " +
				"WHERE p.Market = 'clothes' AND i.Product = p.Name AND c.Name = i.Consumer GROUP BY c.Gender";
		
		out.print("<p>More girls are interested in clothes than guys: </p>");
		
		result = stmt.executeQuery(str);
		resultMD = result.getMetaData();
		
		//Make an HTML table to show the results in:
		out.print("<table>");

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
		out.print("</table>");
		
		stmt = con.createStatement();
		
		str = "SELECT c.gender AS Gender, Count(i.Consumer) as 'Interested in Clothes' " + 
				"FROM Project.Consumer c JOIN Project.Interested i JOIN Project.Product p " +
				"WHERE p.Market = 'clothes' AND i.Product = p.Name AND c.Name = i.Consumer GROUP BY c.Gender";
		
		out.print("<p>More girls are interested in clothes than guys: </p>");
		
		result = stmt.executeQuery(str);
		resultMD = result.getMetaData();
		
		//Make an HTML table to show the results in:
		out.print("<table>");

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
		out.print("</table>");
		
		
		
		//close the connection.
		db.closeConnection(con);
		con.close();
		}catch (Exception e) {
			out.print(e);
	}
	%>
	
</body>
</html>