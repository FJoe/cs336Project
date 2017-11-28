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
	
	<%
    
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String market = request.getParameter("market");
			String tactic = null;
			String city = null;
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = 
				"SELECT DISTINCT c.Tactic AS 'Best Tactic' " +
				"FROM (((cs336db.interested i " + 
				"INNER JOIN cs336db.product p ON i.ProductName = p.Name) "+
				"INNER JOIN cs336db.sees s ON s.Consumer = i.Name) " +
				"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
				"WHERE p.Market = '" + market + "' " +
				"GROUP BY c.Tactic " + 
				"ORDER BY COUNT(i.Name) desc " +
				"LIMIT 1";
						
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			if(!result.next()){
				out.print("<p>Sorry, an ideal location was not found.</p>");
			}else{
				tactic = result.getString(1);
				
				//Make an HTML table to show the results in:
				out.print("<p>The ideal tactic for this commercial is: " + "<b>" + tactic + "</b>" + "</p>");
			}

			
			stmt = con.createStatement();
			
			str = "SELECT DISTINCT c.City AS 'Best City'" +
					"FROM (((cs336db.interested i " + 
					"INNER JOIN cs336db.product p ON i.ProductName = p.Name) "+
					"INNER JOIN cs336db.sees s ON s.Consumer = i.Name) " +
					"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
					"WHERE p.Market = '" + market + "' " +
					"GROUP BY c.City " +
					"ORDER BY COUNT(i.Name) desc " +
					"LIMIT 1";
			
			result = stmt.executeQuery(str);
			if(!result.next()){
				out.print("<p>Sorry, an ideal location was not found.</p>");
			}
			else{
				city = result.getString(1);
				out.print("<p>The ideal location for this commercial is: " + "<b>" +city + "</b>" + "</p>");
			}

			
			stmt = con.createStatement();
			
			if(tactic == null || city == null){
				out.print("An ideal tactic and city is needed to find the ideal channel.");
			}
			else{
				str = "SELECT DISTINCT ch.Name AS 'Best Channel' " +
						"FROM (((cs336db.watches w " +
						"INNER JOIN cs336db.channel ch ON w.Channel = ch.Name) " +
						"INNER JOIN cs336db.sees s ON s.Consumer = w.Consumer) " +
						"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
						"WHERE c.Tactic = '" + tactic + "' "+
						"AND c.City = '" + city + "' "+
						"GROUP BY c.Name " +
						"ORDER BY COUNT(w.Consumer) desc " +
						"LIMIT 1";
				
				result = stmt.executeQuery(str);
				out.print("<p>The ideal channel for this commercial to air is: ");
				if(!result.next()){
					out.print("<p>Sorry, an ideal channel was not found.</p>");
				}
				else{
					out.print("<b>"+ result.getString(1) + "</b>" + "</p>");
				}
			}

		//close the connection.
		db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		
	%>
</body>
</html>