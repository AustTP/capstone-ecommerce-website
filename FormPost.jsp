<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page language="java" import="java.sql.*" %>
<%@ taglib uri="/header" prefix="aat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<jsp:useBean id="validator" class="beans.Validator"/>
		<jsp:useBean id="save" scope="page" class="beans.purchase" />
	
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">	
		<title>Purchase Information</title>
		<link rel="stylesheet" href="style.css">
		<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
	</head>
	
	<%@ page import="java.io.*"%>
	<%@ page import="java.servlet.*"%>
	<%@ page import="java.net.URL" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="java.servlet.*"%>
	<%@ page import="java.net.URL" %>
	<%@ page import="oracle.jdbc.OracleResultSetMetaData" %>
	
	<body>
		<aat:header />
		
		<div style="margin: 35px auto 15px auto; max-width: 800px;">

			<% 
			if(request.getMethod().equals("GET")) {
				if (!validator.hasTable()) {
				response.sendRedirect("CreateTables.jsp");	
			} else {	
			%>

				<h2 style="font-family: Raleway;">Enter information to place an order.</h2>
				<form name="FormPost" method="post" action='FormPost.jsp'>
					<table><tr><td class="ordertd"><label>Full Name:</label></td>
					<td class="ordertd"><input type='text' name='name' maxlength='36' id='name'></td></tr>
					<tr><td class="ordertd"><label>Address:</label></td>
					<td class="ordertd"><input type='text' name='address' maxlength='100' id='address'></td></tr>
					<tr><td class="ordertd"><label>City:</label></td>
					<td class="ordertd"><input type='text' name='city' maxlength='50' id='city'></td></tr>
					<tr><td class="ordertd"><label>State:</label></td>
					<td class="ordertd"><input type='text' name='state' maxlength='50' id='state'></td></tr>
					<tr><td class="ordertd"><label>Zip Code:</label></td>
					<td class="ordertd"><input type='text' name='zipCode' maxlength='36' id='zipCode'></td></tr>
					<tr><td class="ordertd"><label>Phone:</label></td>
					<td class="ordertd"><input type='text' name='phone' maxlength='20' id='phone'></td></tr>
					<tr><td class="ordertd"><label>E-mail Address:</label></td>
					<td class="ordertd"><input type='text' name='emailAddress' maxlength='50' id='emailAddress'></td></tr>
					<tr><td class="ordertd"><label>Product:</label></td>
					<td class="ordertd"><select name='product' id='product'>
						<%
						Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "student1", "pass");
						PreparedStatement psSelectRecord=null;
						String sqlSelectRecord=null;
						ResultSet productResults = null;

						sqlSelectRecord ="SELECT product FROM product";
						psSelectRecord=conn.prepareStatement(sqlSelectRecord);
						productResults=psSelectRecord.executeQuery();

						while(productResults != null && productResults.next()){
						    String product = productResults.getString("product");
						%>
							<option value="<%=product%>"><%=product%></option>
						<%
						}
						%>
					</select>
					
					<tr><td class="ordertd"><label>Quantity:</label></td>
					<td class="ordertd"><input type='number' min="0" name='qnty' maxlength='2' id='qnty'></td></tr>
					<tr><td class="ordertd"><label>Credit Card Number:</label></td>
					<td class="ordertd"><input type='text' name='ccNum' maxlength='20' id='ccNum'></td></tr>
					<tr><td class="ordertd"><label>Expiration Date:</label></td>
					<td class="ordertd"><input type='text' name='expDate' maxlength='20' id='expDate'></td></tr>
					<tr><td class="ordertd"><label>Security Code:</label></td>
					<td class="ordertd"><input type='text' name='secCode' maxlength='20' id='secCode'></td></tr>
					<tr><td colspan="2" class="ordertd"><input type='submit' value='Submit'></p></td></tr></table>
				</form>
			<% }
		}
			
		if(request.getMethod().equals("POST")){
			String name = request.getParameter("name");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			String zipCode = request.getParameter("zipCode");
			String phone = request.getParameter("phone");
			String emailAddress = request.getParameter("emailAddress");
			String product = request.getParameter("product");
			String ccNum = request.getParameter("ccNum");
			String expDate = request.getParameter("expDate");
			String secCode = request.getParameter("secCode");
			int qnty = Integer.parseInt(request.getParameter("qnty"));
			%>
			
			<%= save.insert(name, product, address, city, state, zipCode, phone, emailAddress, ccNum, expDate, secCode, qnty) %>

				<p>Request Processed</p>
				<p><a href ="FormPost.jsp">Return to the form.</a></p>
			<%}%> 	
		</div>
	</body>
</html>

<!-- 
Reference
Piercy, C. (2015, February 15). JavaBeans and JSP tags. Retrieved October 12, 2016, from https://www.youtube.com/watch?v=u2QWxX7Iy3E 
-->