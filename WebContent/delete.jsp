<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete From Table</title>
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
	
	<form method="post" action="delete.jsp">
	<select name="choose_table" size=1>
		<option value="Airs">Airs</option>
		<option value="Channel">Channel</option>
		<option value="Commercial">Commercial</option>
		<option value="Consumer">Consumer</option>
		<option value="Interested">Interested</option>
		<option value="Product">Product</option>
		<option value="Sees">Sees</option>
		<option value="Sells">Sells</option>
		<option value="Watches">Watches</option>
	</select>&nbsp;<br><input type="submit" value="Choose Table">
	</form>
	<p>	<b>WARNING: Deleting an entity (Channel, Commercial, Consumer, or Product) will delete any occurrences this entity appears in any relationship.</b></p>
	<p> <b>Example: Deleting a product will also delete any record of a consumer being interested in that product</b></p>

	<br>

	<%
    
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			String table = request.getParameter("choose_table");
			String tableToDelete = request.getParameter("table_delete");
			
			if(tableToDelete != null){
				Statement stmt = con.createStatement();
				
				String str = "SELECT * FROM Project." + tableToDelete + " LIMIT 1";
								
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				ResultSetMetaData resultMD = result.getMetaData();
				
				String deleteQuery = "DELETE FROM Project." + tableToDelete + " WHERE ";
				for(int i = 0; i < resultMD.getColumnCount(); i++){
					deleteQuery = deleteQuery + resultMD.getColumnName(i+1) + "=\"" + request.getParameter(resultMD.getColumnName(i+1)) + "\"";
					if(i != resultMD.getColumnCount() - 1)
						deleteQuery = deleteQuery + " AND ";
				}
								
				PreparedStatement ps = con.prepareStatement(deleteQuery);
				ps.executeUpdate();
				out.print("<p>Successfully deleted!</p>");
				
				//UPDATE DELETED THING!!!
				if(tableToDelete.equals("Consumer")){
					String delete1 = "DELETE FROM Project.Interested WHERE Consumer = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete1);
					ps.executeUpdate();
					String delete2 = "DELETE FROM Project.Watches WHERE Consumer = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete2);
					ps.executeUpdate();
					String delete3 = "DELETE FROM Project.Sees WHERE Consumer = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete3);
					ps.executeUpdate();
				}
				else if(tableToDelete.equals("Product")){
					String delete1 = "DELETE FROM Project.Interested WHERE Product = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete1);
					ps.executeUpdate();
					String delete2 = "DELETE FROM Project.Sells WHERE Product = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete2);
					ps.executeUpdate();
				}
				else if(tableToDelete.equals("Commercial")){
					String delete1 = "DELETE FROM Project.Sells WHERE Commercial = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete1);
					ps.executeUpdate();
					String delete2 = "DELETE FROM Project.Airs WHERE Commercial = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete2);
					ps.executeUpdate();
				}
				else if(tableToDelete.equals("Channel")){
					String delete1 = "DELETE FROM Project.Sells WHERE Channel = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete1);
					ps.executeUpdate();
					String delete2 = "DELETE FROM Project.Airs WHERE Channel = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete2);
					ps.executeUpdate();
					String delete3 = "DELETE FROM Project.Sees WHERE Channel = \"" + request.getParameter("Name") + "\"";
					ps = con.prepareStatement(delete3);
					ps.executeUpdate();
				}
				
				table = tableToDelete;
				ps.close();
			}
			
			
			if(table != null){
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = "SELECT * FROM Project." + table;
				
				out.print("<p>Current Table: <b>" + table + "</b>");
				
				//Run the query against the database.
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
					out.print("<td><form method=\"post\" action=\"delete.jsp\">");
					out.print("<input type=\"text\" value=\"" + table + "\" name=\"table_delete\" style=\"display:none\">");
					for(int i = 0; i < resultMD.getColumnCount(); i++){
						out.print("<input type=\"text\" value=\"" + result.getString(resultMD.getColumnName(i+1)) + "\" name=\"" + resultMD.getColumnName(i+1) + "\" style=\"display:none\">");
					}
					out.print("<input type=\"submit\" value=\"Delete\" style=\"display:block\">");
					out.print("</form>");
					out.print("</td>");
					out.print("</tr>");
		
				}
				out.print("</table>");
		
				//close the connection.
				db.closeConnection(con);
			}
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>