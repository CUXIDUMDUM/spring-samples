<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<h2>Calendar for <spring:eval expression="appointmentCalendar.day" /></h2>

<table>
	<tr>
		<th>&nbsp;</th>
		<c:forEach var="doctor" items="${appointmentCalendar.doctors}">
			<th>Dr. ${doctor.name}</th>
		</c:forEach>
	</tr>

	<c:forEach var="block" items="${appointmentCalendar.blocks}" varStatus="b">
		<tr>
			<td>
				<spring:eval expression="block.time" />
			</td>
			<c:forEach var="doctor" items="${appointmentCalendar.doctors}" varStatus="d">
				<spring:eval expression="appointmentCalendar.appointments[b.count - 1][d.count - 1]" var="appointment" />
				<c:choose>
					<c:when test="${appointment != null}">
						<td class="filled">
							${appointment.patient} <br/>
							${appointment.client} ${appointment.clientPhone} <br/>
							${appointment.reason}
						</td>				
					</c:when>
					<c:otherwise>
						<td class="open" onclick="showDialog();">&nbsp;</td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
	</c:forEach>
</table>

<ul>
<li><a href="<c:url value="/appointments/${appointmentCalendar.previousDayResourceId}"/>">Previous</a></li> 
<li><a href="<c:url value="/appointments/${appointmentCalendar.nextDayResourceId}"/>">Next</a></li>
</ul>

<div id="addDialog" title="Add Appointment">
	<form method="POST">
		<fieldset>
			<p>
				<label for="patient">Patient</label><br/>
				<input id="patient" type="text" />
				<input id="add" type="submit" value="Add" />				
			</p>
		</fieldset>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#patient").autocomplete({
			source: function(request, response) {
				$.getJSON("patients", { name: request.term }, response);
			}
		});
		
		$("#addDialog").dialog({
			autoOpen: false,
			modal: true
		});			
	});
	
	function showDialog() {
		$("#addDialog").dialog("open");
	}
</script>