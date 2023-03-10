<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>

	$().ready(function(){
		
		$("#selectEmail").change(function(){
			document.frm_mod_member.email2.value = $(this).val();
		})
		
	});

	var frm_mod_member = document.frm_mod_member;
	
	function fn_modify_member_info(memberId,modType){
		
		var value;
		var frm_mod_member = document.frm_mod_member;
		
		if (modType == 'memberPw') {
			value = frm_mod_member.memberPw.value;
		} 
		else if (modType == 'memberName') {
			value = frm_mod_member.memberName.value;
		} 
		else if (modType == 'memberGender'){
			var memberGender = frm_mod_member.memberGender;
			for (var i=0; memberGender.length;i++){
			 	if (memberGender[i].checked){
					value = memberGender[i].value;
					break;
				} 
			}
		}
		else if (modType == 'memberBirth'){
			var memberBirthY = frm_mod_member.memberBirthY;
			var memberBirthM = frm_mod_member.memberBirthM;
			var memberBirthD = frm_mod_member.memberBirthD;
			var memberBirthGn = frm_mod_member.memberBirthGn;
			
			for (var i=0; memberBirthY.length;i++){
			 	if (memberBirthY[i].selected){
					value_y = memberBirthY[i].value;
					break;
				} 
			}
			
			for (var i=0; memberBirthM.length;i++){
			 	if (memberBirthM[i].selected){
					value_m = memberBirthM[i].value;
					break;
				} 
			}
			
			for (var i=0; memberBirthD.length;i++){
			 	if (memberBirthD[i].selected){
					value_d = memberBirthD[i].value;
					break;
				} 
			}
			
			for (var i=0; memberBirthGn.length;i++){
			 	if (memberBirthGn[i].checked){
					value_gn = memberBirthGn[i].value;
					break;
				} 
			}
			value = value_y + "," + value_m + "," + value_d + "," + value_gn;
		}
		
		else if (modType == 'hp'){
			var hp1 = frm_mod_member.hp1;
			var hp2 = frm_mod_member.hp2;
			var hp3 = frm_mod_member.hp3;
			var smsstsYn = frm_mod_member.smsstsYn;
			
			for (var i=0; hp1.length;i++){
			 	if (hp1[i].selected){
					value_hp1 = hp1[i].value;
					break;
				} 
			}
			value_hp2 = hp2.value;
			value_hp3 = hp3.value;
			if (smsstsYn.checked)	value_smsstsYn = "Y";
			else					value_smsstsYn = "N";
			
			
			value = value_hp1 + "," + value_hp2 + ", " + value_hp3 + "," + value_smsstsYn;
			
		}
		else if (modType == 'email') {
			var email1 = frm_mod_member.email1;
			var email2 = frm_mod_member.email2;
			var emailstsYn = frm_mod_member.emailstsYn;
			
			value_email1 = email1.value;
			value_email2 = email2.value;
			if (emailstsYn.checked)	value_emailstsYn = "Y";
			else					value_emailstsYn = "N";
			
			value = value_email1 + "," + value_email2 + "," + value_emailstsYn;
		}
		else if (modType == 'address'){
			var zipcode       =	frm_mod_member.zipcode;
			var roadAddress   = frm_mod_member.roadAddress;
			var jibunAddress  = frm_mod_member.jibunAddress;
			var namujiAddress = frm_mod_member.namujiAddress;
			
			value_zipcode       = zipcode.value;
			value_roadAddress   = roadAddress.value;
			value_jibunAddress  = jibunAddress.value;
			value_namujiAddress = namujiAddress.value;
			
			value = value_zipcode + "," + value_roadAddress + "," + value_jibunAddress + "," + value_namujiAddress;
		}
	 
		$.ajax({
			type : "post",
			url : "${contextPath}/admin/member/modifyMemberInfo",
			data : {
				"memberId" : memberId,
				"modType"  : modType,
				"value"    : value
			},
			success : function() {
				alert("?????? ????????? ??????????????????.");
			}
		}); 
	}
	
</script>
</head>
<body>
	<h3>?????? ?????? ??????</h3>
	<form name="frm_mod_member">	
		<table class="table table-bordered table-hover">
				<tr>
					<td align="center">
						<label for="memberId">?????????</label>
					</td>
					<td>
						<input name="memberId" id="memberId" type="text" class="form-control"  value="${memberInfo.memberId}"  disabled/>
					</td>
					 <td>
					  <input type="button" value="??????" class="btn btn-outline-primary btn-sm"  disabled onClick="fn_modify_member_info('${memberInfo.memberId }','memberId')" />
					</td>
				</tr>
				<tr>
					<td align="center">????????????</td>
					<td>
					  <input name="memberPw" type="password" class="form-control" value="${memberInfo.memberPw }" />
					</td>
					<td>
					  <input type="button" value="??????" class="btn btn-outline-primary btn-sm"  onClick="fn_modify_member_info('${memberInfo.memberId }','memberPw')" />
					</td>
				</tr>
				<tr>
					<td align="center">??????</td>
					<td>
					  <input name="memberName" type="text" class="form-control" value="${memberInfo.memberName }"  />
					 </td>
					 <td>
					  <input type="button" value="??????" class="btn btn-outline-primary btn-sm" onClick="fn_modify_member_info('${memberInfo.memberId }','memberName')" />
					</td>
				</tr>
				<tr>
					<td align="center">??????</td>
					<td>
				   	  <input type="radio" name="memberGender" class="custom-control-input" value="101" <c:if test="${memberInfo.memberGender eq '101' }">checked </c:if> />
				   	  <label class="custom-control-label" for="g1">??????</label>&emsp;&emsp;&emsp;
				      <input type="radio" name="memberGender" class="custom-control-input" value="102" <c:if test="${memberInfo.memberGender eq '102' }">checked </c:if> />
					  <label class="custom-control-label" for="g2">??????</label>
					</td>
					<td>
					  <input type="button" value="??????" class="btn btn-outline-primary btn-sm"  onClick="fn_modify_member_info('${memberInfo.memberId }','memberGender')" />
					</td>
				</tr>
				<tr>
					<td align="center">????????????</td>
					<td>
					   <select class="form-control" name="memberBirthY" style="display:inline; width:70px; padding:0">
					     <c:forEach var="i" begin="1" end="100">
					       <c:choose>
					         <c:when test="${memberInfo.memberBirthY==1920+i }">
							   <option value="${1920+i}" selected>${1920+i} </option>
							</c:when>
							<c:otherwise>
							  <option value="${1920+i}" >${1920+i} </option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>??? 
					<select class="form-control"  name="memberBirthM" style="display:inline; width:70px; padding:0">
						<c:forEach var="i" begin="1" end="12">
					       <c:choose>
					         <c:when test="${memberInfo.memberBirthM == i}">
							   <option value="${i}" selected>${i}</option>
							</c:when>
							<c:otherwise>
							  <option value="${i}">${i}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>??? 
					
					<select class="form-control" name="memberBirthD" style="display:inline; width:70px; padding:0">
							<c:forEach var="i" begin="1" end="31">
					       <c:choose>
					         <c:when test="${memberInfo.memberBirthD == i}">
							   <option value="${i}" selected>${i}</option>
							</c:when>
							<c:otherwise>
							  <option value="${i}">${i}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>??? &emsp;&emsp;
					   	<c:choose>
						    <c:when test="${memberInfo.memberBirthGn=='2'}"> 
						  		<input type="radio" name="memberBirthGn" value="2" checked /> ?????? &emsp; 
								<input type="radio" name="memberBirthGn" value="1" /> ??????
							</c:when>
							<c:otherwise>
								<input type="radio" name="memberBirthGn" value="2" /> ?????? &emsp;
								<input type="radio" name="memberBirthGn" value="1" checked  /> ??????
							</c:otherwise>
						</c:choose>
					</td>
					<td>
					  <input type="button" value="??????" class="btn btn-outline-primary btn-sm"  onClick="fn_modify_member_info('${memberInfo.memberId }','memberBirth')" />
					</td>
				</tr>
				<tr>
					<td align="center">????????? ??????</td>
					<td>
					   <select class="form-control" name="hp1" style="display:inline; width:70px; padding:0">
							<option>??????</option>
							<option <c:if test="${memberInfo.hp1 eq '010'}"> selected </c:if> value="010">010</option>
							<option <c:if test="${memberInfo.hp1 eq '011'}"> selected </c:if> value="011">011</option>
							<option <c:if test="${memberInfo.hp1 eq '016'}"> selected </c:if> value="016">016</option>
							<option <c:if test="${memberInfo.hp1 eq '017'}"> selected </c:if> value="017">017</option>
							<option <c:if test="${memberInfo.hp1 eq '018'}"> selected </c:if> value="018">018</option>
							<option <c:if test="${memberInfo.hp1 eq '019'}"> selected </c:if> value="019">019</option>
					</select> 
					 - <input type="text" name="hp2" class="form-control" value="${memberInfo.hp2 }" style="display:inline; width:70px; padding:0"> 
					 - <input type="text"name="hp3" class="form-control" value="${memberInfo.hp3 }" style="display:inline; width:70px; padding:0"><br>
					 <br>
					 <c:choose> 
					   <c:when test="${memberInfo.smsstsYn eq 'Y' }">
					     <input type="checkbox" class="custom-control-input" name="smsstsYn" id="smsstsYn" value="Y" checked /> 
					     <label for="smsstsYn" >SMS?????? ???????????? SMS ????????? ???????????????.</label>
						</c:when>
						<c:otherwise>
						  <input type="checkbox" class="custom-control-input" name="smsstsYn" id="smsstsYn" value="N"  /> 
						  <label for="smsstsYn" >SMS?????? ???????????? SMS ????????? ???????????????.</label>
						</c:otherwise>
					 </c:choose>	
				    </td>
					<td>
					  <input type="button" value="??????" class="btn btn-outline-primary btn-sm"  onClick="fn_modify_member_info('${memberInfo.memberId }','hp')" />
					</td>	
				</tr>
				<tr>
					<td align="center">?????????(e-mail)</td>
					<td>
					   <input type="text" class="form-control" name="email1" value="${memberInfo.email1 }" style="display:inline; width:100px; padding:0"/> @ 
					   <input type="text" class="form-control"  name="email2" value="${memberInfo.email2 }" style="display:inline; width:100px; padding:0"/> 
					   <select id="selectEmail" class="form-control" style="display:inline; width:100px; padding:0">
						 <option value="" <c:if test="${memberInfo.email2 eq 'none'}"> selected</c:if>>????????????</option>
						 <option value="gmail.com" <c:if test="${memberInfo.email2 eq 'gmail.com'}"> selected</c:if>>gmail.com</option>
						 <option value="naver.com" <c:if test="${memberInfo.email2 eq 'naver.com'}"> selected</c:if>>naver.com</option>
						 <option value="daum.net" <c:if test="${memberInfo.email2 eq 'daum.net'}"> selected</c:if>>daum.net</option>
						 <option value="nate.com" <c:if test="${memberInfo.email2 eq 'nate.com'}"> selected</c:if>>nate.com</option>
						</select><br><br>  
						<c:choose> 
						   <c:when test="${memberInfo.emailstsYn eq 'Y' }">
						     <input type="checkbox" class="custom-control-input" name="emailstsYn" id="emailstsYn" value="Y" checked /> 
						     <label for="emailstsYn">SMS?????? ???????????? e-mail??? ???????????????.</label>
							</c:when>
							<c:otherwise>
							  <input type="checkbox" class="custom-control-input" name="emailstsYn" id="emailstsYn" value="N"  />
							  <label for="emailstsYn">SMS?????? ???????????? e-mail??? ???????????????.</label>
							</c:otherwise>
						 </c:choose>
					</td>
					<td>
						<input type="button" value="??????" class="btn btn-outline-primary btn-sm"  onClick="fn_modify_member_info('${memberInfo.memberId }','email')" />
					</td>
				</tr>
				<tr>
					<td align="center">??????</td>
					<td>
					   <input type="text" id="zipcode" name="zipcode" class="form-control"  value="${memberInfo.zipcode }" size="70px" style="display:inline; width:150px; padding:0"> 
					    <input type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:execDaumPostcode()" value="??????">
					  <br><br>
					  <p> 
						  ?????? ??????:<br><input type="text" id="roadAddress"  name="roadAddress" class="form-control" value="${memberInfo.roadAddress }"><br>
						  ????????? ??????: <input type="text" id="jibunAddress" name="jibunAddress" class="form-control" value="${memberInfo.jibunAddress }"><br>
						  ????????? ??????: <input type="text"  name="namujiAddress" class="form-control" value="${memberInfo.namujiAddress }" />
						   <span id="guide" style="color:#999"></span>
					   </p>
					</td>
					<td>
						<input type="button" value="??????" class="btn btn-outline-primary btn-sm"  onClick="fn_modify_member_info('${memberInfo.memberId }','address')" />
					</td>
				</tr>
		</table>
	</form>	
</body>
</html>
