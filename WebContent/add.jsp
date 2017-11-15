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
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="edit.jsp">Edit Tuple</a>
		<a class="link" href="facts.jsp">Facts</a>
	</div>

	<form method="post" action="add.jsp">
		<input type="text" placeholder="Name" name="name">
		<br>
		<input type="text" placeholder="City" name="city">
		<br>
		<input type="text" placeholder="Age" name="age">
		<br>
		<input type="radio" name="gender" value="Male"/>Male
		<br>
		<input type="radio" name="gender" value="Female"/>Female
		<br>

		<input type="submit" value="Submit">
	</form>

	<%
    
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Get parameters from the HTML form at the HelloWorld.jsp
		String newName = request.getParameter("name");
		String newCity = request.getParameter("city");
		int newAge = Integer.valueOf(request.getParameter("age"));
		String newGender = request.getParameter("gender");
		if(newName != null && newCity != null && newGender != null){

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Project.Consumer(name, city, gender, age)"
				+ "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newName);
		ps.setString(2, newCity);
		ps.setString(3, newGender);
		ps.setInt(4, newAge);
		
		//Run the query against the DB
		ps.executeUpdate();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String str = "SELECT * FROM Project.Consumer";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("City");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Gender");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Age");
			out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar or beer name:
				out.print(result.getString("Name"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(result.getString("City"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(result.getString("Gender"));
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print(result.getString("Age"));
				out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");

		//close the connection.
		db.closeConnection(con);
	} 
		}
	catch(NumberFormatException e){
		out.print("<p>Incorrect Age</p>");
	}
	catch (Exception e) {
		out.print(e);
	}
	%>
</body>
</html>