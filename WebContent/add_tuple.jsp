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
		<a class="link" href="home.jsp">Home</a>
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="delete.jsp">Delete Tuple</a>
		<a class="link" href="facts.jsp">Commercial Generator</a>
		<a class="link" href="facts_channel.jsp">Viewer Favorites</a>
		<a class="link" href="facts_commercial.jsp">Where to Advertise</a>
		<a class="link" href="facts_consumer.jsp">I want to shop</a>
		<a class="link" href="most_popular.jsp">The Most Popular</a>
	</div>
	
	<%
    class NotCompleteException extends Exception{
		NotCompleteException(String msg){
			super(msg);
		}
	}
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String table = request.getParameter("table");
		
		Enumeration<String> paramNames = request.getParameterNames();
		ArrayList<String> param = new ArrayList<String>();
		while(paramNames.hasMoreElements()){
			String paramName = (String)paramNames.nextElement();
			if(!paramName.equals("table"))
				param.add(paramName);
		}
		
		String insertTo = "." + table + "(";
		for(int i = 0; i < param.size() - 1; i++){
			insertTo = insertTo + param.get(i) + ", ";
		}
		insertTo = insertTo + param.get(param.size() - 1) + ")";
		
		String valueTo = "(";
		for(int i = 0; i < param.size(); i++){
			String value = request.getParameter(param.get(i));
			if(value == null || value.equals("")){
				throw new NotCompleteException("Entry not filled in: " + param.get(i));
			}
			value = "\""+ value + "\"";
			
			valueTo = valueTo + value;
			if(i != param.size() - 1)
				valueTo += ", ";
			else
				valueTo += ")";
		}
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Project" + insertTo + " VALUES " + valueTo;

		PreparedStatement ps = con.prepareStatement(insert);
		ps.executeUpdate();
		
		//close the connection.
		db.closeConnection(con);
		out.print("<p>Successfully inserted!</p>");
	}
	catch(NumberFormatException e){
		out.print("<p>ERROR: Incorrect Number Format (Integer was not inputted)</p>");
	}
	catch(NotCompleteException e){
		out.print("<p>ERROR: Not all fields were filled in</p>");
	}
	catch (Exception e) {
		out.print("<p>ERROR: " + e + " </p>");
	}
	%>
</body>
</html>