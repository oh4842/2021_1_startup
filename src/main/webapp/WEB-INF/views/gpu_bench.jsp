<%@page import="com.inhatc.domain.DBconnect"%>
<%@page import="com.inhatc.domain.SeleniumCrawling"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<!-- 한글 패치 -->

<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="kr">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js">
	
</script>



<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = null;

String jdbcDriver = "jdbc:mysql://localhost:3306/startup?serverTimezone=UTC";
String dbUser = "root";
String dbPwd = "1234";

PreparedStatement pstmt = null;
PreparedStatement price_pstmt = null;
PreparedStatement priceinput_pstmt = null;

ResultSet rs = null;
ResultSet price_rs = null;
ResultSet priceinput_rs = null;

String[] GPU_name = new String[100];
int[] GPU_bench = new int[100];
int[] GPU_Price = new int[100];
String GPU = "";

SeleniumCrawling seleniumCrawling = new SeleniumCrawling();

int i = 0;
int j = 0;

try{	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
	price_pstmt = conn.prepareStatement("select gpu_name from startup.gpu_bench");
	price_rs = price_pstmt.executeQuery();
	
	while (price_rs.next()) {
		GPU_name[j] = price_rs.getString("gpu_name");
		j++;
	}
}catch(SQLException se){
	se.printStackTrace();
}finally{
	if (price_rs != null)
		price_rs.close();
	if (price_pstmt != null)
		price_pstmt.close();
	if (conn != null)
		conn.close();
}
/* 크롤링 시작 */


/* try{
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
	priceinput_pstmt = conn.prepareStatement("update startup.gpu_bench set price = ? where gpu_num = ?");
	//priceinput_rs = priceinput_pstmt.executeQuery();
	int a = 0;
	
	for(j = 0; j < 100; j++){
		String temp = seleniumCrawling.price_crwaling(GPU_name[j]);
		System.out.println(j+"번째에서 걸림--------------------------"+GPU_name[j]);
		a++;
		if(temp == null || temp == "" || temp == "단종" && !temp.contains("원")){
			continue;
		}else{
			temp = temp.trim();
			System.out.print("temp---------------------------"+temp);
			temp = temp.replace("원", "").replace(",", ""); // 원 하고 , 없애고
			
			int price = Integer.parseInt(temp); // int 형 변환
			
			priceinput_pstmt.setInt(1, price); // price = ? 에 가격 넣고
			priceinput_pstmt.setInt(2, a); // gpu_num = ? 에 j 넣고
			priceinput_pstmt.executeUpdate(); // 업뎃
		}
	}
}catch(SQLException se){
	se.printStackTrace();
}finally{
	if (rs != null)
		rs.close();
	if (priceinput_pstmt != null)
		priceinput_pstmt.close();
	if (conn != null)
		conn.close();
} */

/* 크롤링 끝 */


try {
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
	pstmt = conn.prepareStatement("select * from startup.gpu_bench order by benchi_value desc;");
	rs = pstmt.executeQuery();

	while (rs.next()) {
		GPU_name[i] = rs.getString("GPU_name");
		GPU_bench[i] = rs.getInt("benchi_value");
		GPU_Price[i] = rs.getInt("Price");
		GPU += "['" + GPU_name[i] + "'," + GPU_bench[i] + "," + GPU_Price[i] + "],";
		i++;
	}
} catch (SQLException se) {
	se.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
%>




<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'bar' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		var data = google.visualization.arrayToDataTable([
				[ 'GPU 제품명', '벤치마크값', '가격' ],<%=GPU%>
	]);
		var view = new google.visualization.DataView(data);
		

		
		var options = {
			title : '벤치마크 수치 상위 100위까지의 그래픽카드',
			fontSize : 12,
			bars: 'horizontal',
			
			legend:{position: 'none'},
			/**/
			seriesType : 'bars',
			/**/
			series: {
	            0: {axis:'gpubench'}, // Bind series 0 to an axis named 'distance'.
	            1: {axis:'price'}, // Bind series 1 to an axis named 'brightness'.
	          },
			/**/
			axes: {
				x:{
					gpubench: {side:'top',label: 'benchvalue'},
					price: {label: 'price'}
				}
			},	
			/**/
			bar : {	groupWidth : "90%"}
			/**/
			
			
		};

		var chart = new google.charts.Bar(document
				.getElementById('chart_div'));
		chart.draw(view, options);
	}
</script>





</head>

<body>
	<!-- head를 포함한 위의 요소들 전부 header.jsp에 있음 -->
	<%@ include file="include/header.jsp"%>
<div class="contentG">
<center>

	<!-- Main content -->
	

		<div class="row">

			<!-- left column -->
			<div class="col-md-12">
				<!-- general form elements -->

				<div class="box">
					<div class="box-header with-border">

						<h1 class="box-title"><b>그래픽카드 벤치마크(성능 수치)</b></h1><br>
						<!-- 차트 그리는 문항 : <div id="chart_div" ></div> -->
						<div id="chart_div" style="width: 900px; height: 4000px;"></div>
					</div>
					<div class="box-body"></div>
					<!-- /.box-body -->

					<!-- /.box-footer-->
				</div>
			</div>
			<!--/.col (left) -->

		</div>
		<!-- /.row -->
	
	<!-- /.content -->
	</center>
	
	</div>
	<!-- /.content-wrapper -->

	<script>
		var result = '${msg}';

		if (result == 'SUCCESS') {
			alert("처리가 완료되었습니다.");
		}
	</script>


	<!-- 아래 요소들 전부 footer.jsp에 있음 -->
	<%@ include file="include/footer.jsp"%>
</body>

</html>
