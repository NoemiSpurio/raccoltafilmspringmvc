<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="it" class="h-100">
<head>
	<meta charset="ISO-8859-1">
	<title>Aggiorna film</title>
	<jsp:include page="../header.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jqueryUI/jquery-ui.min.css" />
		<style>
			.ui-autocomplete-loading {
				background: white url("../assets/img/jqueryUI/anim_16x16.gif") right center no-repeat;
			}
			.error_field {
		        color: red; 
		    }
		</style>
</head>
<body class="d-flex flex-column h-100">
<jsp:include page="../navbar.jsp"></jsp:include>
	<main class="flex-shrink-0">
			  <div class="container">
			  
			  		<div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none':'' }" role="alert">
					  ${errorMessage}
					  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" ></button>
					</div>
					<div class="alert alert-danger alert-dismissible fade show d-none" role="alert">
					  Operazione fallita!
					  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" ></button>
					</div>
					<div class="alert alert-info alert-dismissible fade show d-none" role="alert">
					  Aggiungere d-none nelle class per non far apparire
					   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" ></button>
					</div>
			  
			  <div class='card'>
				    <div class='card-header'>
				        <h5>Modifica i campi da aggiornare</h5> 
				    </div>
				    <div class='card-body'>
		
							<h6 class="card-title">I campi con <span class="text-danger">*</span> sono obbligatori</h6>
		
		
							<form:form modelAttribute="update_film_attr" method="post" action="${pageContext.request.contextPath}/film/executeEdit" class="row g-3" novalidate="novalidate">
							
								<div class="col-md-6">
										<label for="titolo" class="form-label">Titolo <span class="text-danger">*</span></label>
										<spring:bind path="titolo">
											<input type="text" name="titolo" id="titolo" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il titolo" value="${update_film_attr.titolo }">
										</spring:bind>
										<form:errors  path="titolo" cssClass="error_field" />
									</div>
										
									<div class="col-md-6">
										<label for="genere" class="form-label">Genere <span class="text-danger">*</span></label>
										<spring:bind path="genere">
											<input type="text" name="genere" id="genere" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il genere" value="${update_film_attr.genere }">
										</spring:bind>
										<form:errors  path="genere" cssClass="error_field" />
									</div>
									
									<div class="col-md-6">	
										<fmt:formatDate pattern='yyyy-MM-dd' var="parsedDate" type='date' value='${update_film_attr.dataPubblicazione}' />
										<div class="form-group col-md-6">
											<label for="dataPubblicazione" class="form-label">Data di Pubblicazione <span class="text-danger">*</span></label>
			                        		<spring:bind path="dataPubblicazione">
				                        		<input class="form-control ${status.error ? 'is-invalid' : ''}" id="dataPubblicazione" type="date" placeholder="dd/MM/yy"
				                            		title="formato : gg/mm/aaaa"  name="dataPubblicazione" value="${parsedDate}" >
				                            </spring:bind>
			                            	<form:errors  path="dataPubblicazione" cssClass="error_field" />
										</div>
									</div>
										
									<div class="col-md-6">
										<label for="minutiDurata" class="form-label">Durata (minuti) <span class="text-danger">*</span></label>
										<spring:bind path="minutiDurata">
											<input type="number" class="form-control ${status.error ? 'is-invalid' : ''}" name="minutiDurata" id="minutiDurata" placeholder="Inserire la durata" value="${update_film_attr.minutiDurata }">
										</spring:bind>
										<form:errors  path="minutiDurata" cssClass="error_field" />
									</div>
								
								
								<div class="col-md-6">
										<label for="registaSearchInput" class="form-label">Regista: <span class="text-danger">*</span></label>
										<spring:bind path="regista">
											<input class="form-control ${status.error ? 'is-invalid' : ''}" type="text" id="registaSearchInput"
												name="registaInput" value="${update_film_attr.regista.nome}${empty update_film_attr.regista.nome?'':' '}${update_film_attr.regista.cognome}">
										</spring:bind>
										<input type="hidden" name="regista.id" id="registaId" value="${update_film_attr.regista.id}">
										<form:errors  path="regista" cssClass="error_field" />
								</div>
								
								<input type="hidden" name="id" value="${update_film_attr.id}">
								
								
							<div class="col-12">
								<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Conferma</button>
								
								<a href="${pageContext.request.contextPath }/film/" class='btn btn-outline-secondary' style='width:80px'>
					            <i class='fa fa-chevron-left'></i>Back
					        	</a>
							</div>
							
						</form:form>
						
						<%-- FUNZIONE JQUERY UI PER AUTOCOMPLETE --%>
								<script>
									$("#registaSearchInput").autocomplete({
										 source: function(request, response) {
										        $.ajax({
										            url: "${pageContext.request.contextPath}/regista/searchRegistiAjax",
										            datatype: "json",
										            data: {
										                term: request.term,   
										            },
										            success: function(data) {
										                response($.map(data, function(item) {
										                    return {
											                    label: item.label,
											                    value: item.value
										                    }
										                }))
										            }
										        })
										    },
										//quando seleziono la voce nel campo deve valorizzarsi la descrizione
									    focus: function(event, ui) {
									        $("#registaSearchInput").val(ui.item.label)
									        return false
									    },
									    minLength: 2,
									    //quando seleziono la voce nel campo hidden deve valorizzarsi l'id
									    select: function( event, ui ) {
									    	$('#registaId').val(ui.item.value);
									    	//console.log($('#registaId').val())
									        return false;
									    },
									    change: function(event, ui){
									    	if(ui.item === null){
									    		$('#registaId').val(null);
									    	}
									    }
									});
								</script>
  		   
				    </div>
				</div>		 
			  </div>
			  
			</main>
			
			<jsp:include page="../footer.jsp" />
</body>
</html>