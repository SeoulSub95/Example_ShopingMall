<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h3>통합 매출현황 조회</h3>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<table border="1">
	<tr>
		<td>판매 ID</td>
		<td>상품명</td>
		<td>구매 일자</td>
		<td>총 구매 내역</td>
		<td>구매 개수</td>
	</tr>
	<%
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            Connection conn = DriverManager.getConnection
                                ("jdbc:oracle:thin:@//localhost:1521/xe", "order_admin", "order_password");
            
            Statement stmt = conn.createStatement();
            String query = "SELECT "+
            "SALE.SALE_ID, PRODUCT.NAME, SALE.PURCHASE_DATE, SALE.SALE_PRICE, SALE.AMOUNT "+
            "FROM "+
            "	SALE, PRODUCT "+
            "WHERE "+
            "	SALE.PRODUCT_ID = PRODUCT.PRODUCT_ID";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
            	%>
	<tr>
		<td><%=rs.getInt(1) %></td>
		<td><%=rs.getString(2) %></td>
		<td><%=rs.getString(3) %></td>
		<td><%=rs.getInt(4) %></td>
		<td><%=rs.getInt(5) %></td>
	</tr>
	<%
            }

            stmt.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
%>
	</body>
</table>
</html>