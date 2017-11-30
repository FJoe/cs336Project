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
	
	<%
    
		try {
			String genre = request.getParameter("genre");
			String targetAge = request.getParameter("age");
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = 
				"SELECT DISTINCT co.Name AS 'Best Commercials', COUNT(w.Consumer) " +
				"FROM ((((cs336db.watches w " + 
				"INNER JOIN cs336db.channel ch ON w.Channel = ch.Name) "+
				"INNER JOIN cs336db.consumer c ON c.Name = w.Consumer) " +
				"INNER JOIN cs336db.sees s ON s.Consumer = c.Name) " +
				"INNER JOIN cs336db.commercial co ON co.Name = s.Commercial) " +
				"WHERE ch.Genre = '" + genre + "' " +
				"AND 'ch.Target Age' = " + targetAge + " " + 
				"GROUP BY co.Name " + 
				"ORDER BY COUNT(w.Consumer) desc " +
				"LIMIT 5";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			ResultSetMetaData resultMD = result.getMetaData();
			
			boolean empty = false;
			if(!result.next()){
				stmt = con.createStatement();
				str =   "SELECT DISTINCT co.Name AS 'Best Commercials', COUNT(w.Consumer) " +
						"FROM ((((cs336db.watches w " + 
						"INNER JOIN cs336db.channel ch ON w.Channel = ch.Name) "+
						"INNER JOIN cs336db.consumer c ON c.Name = w.Consumer) " +
						"INNER JOIN cs336db.sees s ON s.Consumer = c.Name) " +
						"INNER JOIN cs336db.commercial co ON co.Name = s.Commercial) " +
						"WHERE ch.Genre = '" + genre + "' " +
						"GROUP BY co.Name " + 
						"ORDER BY COUNT(w.Consumer) desc " +
						"LIMIT 5";
				result = stmt.executeQuery(str);
				resultMD = result.getMetaData();
				if(!result.next()){
					empty = true;
				}
			}
			if(!empty){
				//Make an HTML table to show the results in:
				out.print("<table style=\"border:solid;border-width:2px;\"><tr><th>Commercials that may do well on this channel</th>"+
				" <th>Number of consumers who are interested in commercials that are on channels similar to this</th></tr>");
				
				for(int j = 0;j<5;j++){
					String commercial = result.getString(1);
					//out.print("<p>A commercial that may do well on this channel is: <b><u>"+ commercial + "</u></b>" + "</p>");
					String answer = result.getString(2);
					//out.print("<p style = \"color:#0c192d;\">Number of consumers who are interested in commercials that are on channels similar to this are:" + 
					//		" <b><u>"+ answer + "</u></b>");
					out.print("<tr><td><u>" + commercial + "</u></td><td>" + answer + "</td></tr>");
					result.next();
				}
			}
			else{
				out.print("<p>Sorry, no ideal commercials were found</p>");
			}

			out.print("</p></table>");
			//close the connection.
			db.closeConnection(con);
		} catch(NumberFormatException e){
			out.print("Error: Invalid age inputted (either not int or is negative)");
		}
			catch (Exception e) {
			out.print(e);
		}
		
	%>
</body>
</html>