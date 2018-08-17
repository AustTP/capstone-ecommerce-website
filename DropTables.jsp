<!-- 
Bellevue University
Group Pilot AllAboardToys.com project
Group 3
Gage Mikels, Jacob Nielsen, Austin Poole, Dawn Rutherford, Stephanie Shannon 
20 October 2016

This JSP drops all tables that will be used with the form. 
-->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/header" prefix="aat" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>Record</title>
		<link type="text/css" rel="stylesheet" href="style.css">
		<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
	</head>
	
	<%@ page import="java.io.*" %>
	<%@ page import="java.net.URL" %>
	<%@ page import="java.sql.*" %>
	<%@page import="oracle.jdbc.*"%>

	<%! Connection conn = null; %>
	<%! Statement stmt = null; %>
	<%! ResultSet resultSet = null; %>

	<%
	try {
		DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "student1", "pass");
		stmt = conn.createStatement();
	} catch (Exception e) {
		out.println(e);
	}
	%>
	
	<body>
		<aat:header />
		
		<%
		if(request.getMethod().equals("GET")){
		%>

		<div style="margin: 35px auto 15px auto; max-width: 800px;">
			<h2 style="font-family: Raleway;">Drop Tables</h2>
			<p>Are you sure you want to delete all data?</p>
			<form method='post' action='DropTables.jsp'>
				<input type='submit' value='Delete'>
			</form>

		<%
		}
			
		if(request.getMethod().equals("POST")){
			try {
    			stmt.executeUpdate("DROP TABLE ORDERS");
				out.println("The orders table has been dropped.");
    		}catch(SQLException e) {
				out.println("A orders table did not exist.");
  			}
    		
			try {
    			stmt.executeUpdate("DROP TABLE PRODUCT");
				out.println("<br />The product table has been dropped.");
    		} catch(SQLException e) {
    			out.println("<br />A product table did not exist.");
			}
			
    		try {
    			stmt.executeUpdate("DROP TABLE CUSTOMER");
				out.println("<br />The customer table has been dropped.");
    		} catch(SQLException e) {
    			out.println("<br />A customer table did not exist.");
			}
  		}
		%>
		</div>
	</body>
</html>

<%
try {
	conn.close();
} catch(SQLException e) {
	out.println(e);
}
%>