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
	
	<%
    
		try {
			String age = request.getParameter("age");
			if(Integer.parseInt(age) >= 80)
				age = "79";
			if(Integer.parseInt(age) < 0)
				throw new NumberFormatException();
			String gender = request.getParameter("gender");
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT DISTINCT co.Name AS 'Best Commercials' " +
				"FROM ((((Project.Watches w " + 
				"INNER JOIN Project.Channel ch ON w.Channel = ch.Name) "+
				"INNER JOIN Project.Consumer c ON c.Name = w.Consumer) " +
				"INNER JOIN Project.Sees s ON s.Consumer = c.Name) " +
				"INNER JOIN Project.Commercial co ON co.Name = s.Commercial) " +
				"WHERE (('ch.Target Age' - c.Age < 20) OR c.Age - ('ch.Target Age' - c.Age < 20)) " +
				"AND ((c.Age- " + age + " < 20) OR (" + age + " - c.Age < 20)) " +
				"GROUP BY co.Name " + 
				"ORDER BY COUNT(w.Consumer) desc " +
				"LIMIT 5";
						
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			ResultSetMetaData resultMD = result.getMetaData();
			
			if(!result.next()){
				out.print("<p>Sorry, no ideal commercials were found</p>");
			}
			else{
				//Make an HTML table to show the results in:
				out.print("<p>Here are some commercials the consumer may be interested to watch: </p>");
				
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
				do {
					//make a row
					out.print("<tr>");
					for(int i = 0; i < resultMD.getColumnCount(); i++){
						out.print("<td>");
						out.print(result.getString(i + 1));
						out.print("</td>");
					}
					out.print("</tr>");
		
				}while (result.next());
				out.print("</table>");
			}
			
			out.print("<br>");
			
			//Create a SQL statement
			stmt = con.createStatement();
			

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			str = "SELECT DISTINCT p.Name AS 'Favorite Products', p.Market " +
				"FROM ((((((Project.Consumer c " + 
				"INNER JOIN Project.Watches w ON w.Consumer = c.Name) "+
				"INNER JOIN Project.Channel ch ON  ch.Name = w.Channel) " +
				"INNER JOIN Project.Airs a ON a.Channel = ch.Name)" +
				"INNER JOIN Project.Commercial co ON co.Name = a.Commercial) " +
				"INNER JOIN Project.Sells se ON se.Commercial = co.Name) " +
				"INNER JOIN Project.Product p ON p.Name = se.Product) " +
				"WHERE c.Gender = p.Gender " +
				"AND (('ch.Target Age' - c.Age < 20) OR (c.Age - 'ch.Target Age' < 20)) " +
				"AND c.Gender = '" + gender + "' " +
				"AND ((" + age + " - c.Age < 20) OR (c.Age - " + age + " < 20)) " +
				"GROUP BY co.Name " + 
				"ORDER BY COUNT(w.Consumer) desc " +
				"LIMIT 5";
						
			//Run the query against the database.
			result = stmt.executeQuery(str);
			resultMD = result.getMetaData();
			
			if(!result.next()){
				out.print("<p>Sorry, no ideal product were found</p>");
			}
			else{
				//Make an HTML table to show the results in:
				out.print("<p>Here are some Products the consumer may be interested in: </p>");
				
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
				do {
					//make a row
					out.print("<tr>");
					for(int i = 0; i < resultMD.getColumnCount(); i++){
						out.print("<td>");
						out.print(result.getString(i + 1));
						out.print("</td>");
					}
					out.print("</tr>");
		
				}while (result.next());
			}

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