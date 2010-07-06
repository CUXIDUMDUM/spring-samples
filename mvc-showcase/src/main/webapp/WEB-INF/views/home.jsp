<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>mvc-showcase</title>
</head>
<script type="text/javascript" src="<c:url value="/resources/jquery/jquery-1.4.2.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/json2.js" />"></script>
<body>
<h1>mvc-showcase</h1>
<p>Remember to use a Web Developer tool such a Firebug to inspect the client/server interaction!</p>
<div id="simple">
	<h2>Simple</h2>
	<p>
		See the <code>org.springframework.samples.mvc.simple</code> package for the @Controller code
	</p>
	<ul>
		<li>
			<a href="<c:url value="/simple" />">GET /simple</a>
		</li>
		<li>
			<a id="simpleTextOnly" href="<c:url value="/simple/textonly" />">GET /simple/textonly</a> <span id="simpleTextOnlyResponse" class="responseMessage"></span>
			<script type="text/javascript">
				$("#simpleTextOnly").click(function(){
					$.ajax({ url: this.href, dataType: "text", success: function(text) {
							$("#simpleTextOnlyResponse").text("").fadeIn().text(text); 
						}
					});					
					return false;
				});
			</script>
		</li>
		<li>
			<a href="<c:url value="/simple/textonly" />">GET /simple/textonly</a> (Error due to wrong Accept header)	
		</li>
	</ul>
</div>
<div id="mapping">
	<h2>Mapping Requests</h2>
	<p>
		See the <code>org.springframework.samples.mvc.mapping</code> package for the @Controller code
	</p>
	<ul>
		<li>
			<a href="<c:url value="/mapping/path" />">By path</a>
		</li>
		<li>
			<a href="<c:url value="/mapping/method" />">By path and method</a>
		</li>
		<li>
			<a href="<c:url value="/mapping/parameter?foo=bar" />">By path, method, and presence of parameter</a>
		</li>
		<li>
			<a href="<c:url value="/mapping/parameter" />">By path, method, and not presence of parameter</a>
		</li>
		<li>
			<a id="mappingByHeader" href="<c:url value="/mapping/header" />">By presence of header</a> <span id="mappingByHeaderTextResponse" class="responseMessage"></span>
			<script type="text/javascript">
				$("#mappingByHeader").click(function(){
					$.ajax({ url: this.href, dataType: "text", success: function(text) {
							$("#mappingByHeaderTextResponse").text("").fadeIn().text(text); 
						}
					});					
					return false;
				});
			</script>
		</li>
		<li>
			<a id="mappingByHeaderNegation" href="<c:url value="/mapping/header" />">By not presence of header</a> <span id="mappingByHeaderNegationTextResponse" class="responseMessage"></span>			
			<script type="text/javascript">
				$("#mappingByHeaderNegation").click(function(){
					$.ajax({ url: this.href, dataType: "text",
						beforeSend: function(req) {
							req.setRequestHeader("Accept", "text/foo");
						}, 
						success: function(text) {
							$("#mappingByHeaderNegationTextResponse").text("").fadeIn().text(text); 
						}
					});					
					return false;
				});
			</script>
		</li>		
		<li>
			<a href="<c:url value="/mapping/wildcard" />">By regexp</a>
		</li>		
	</ul>
</div>
<div id="data">
	<h2>Obtaining Request Data</h2>
	<p>
		See the <code>org.springframework.samples.mvc.data</code> package for the @Controller code
	</p>
	<ul>
		<li>
			<a href="<c:url value="/data/param?foo=bar" />">Query parameter</a>
		</li>
		<li>
			<a href="<c:url value="/data/group?param1=foo&param2=bar&param3=baz" />">Group of query parameters</a>
		</li>
		<li>
			<a href="<c:url value="/data/path/foo" />">Path variable</a>
		</li>
		<li>
			<a href="<c:url value="/data/header" />">Header</a>
		</li>
		<li>
			<form id="requestBody" action="<c:url value="/data/body" />" method="post">
				<input type="submit" value="Request Body" /> <span id="requestBodyTextResponse" class="responseMessage"></span>		
			</form>
			<script type="text/javascript">
				$("form#requestBody").submit(function(){
					$.ajax({ type: "POST", url: this.action, data: "foo", contentType: "text/plain", dataType: "text",
						success: function(text) {
							$("#requestBodyTextResponse").text("").fadeIn().text(text); 
						}
					});					
					return false;
				});
			</script>
		</li>				
		<li>
			<form id="requestEntity" action="<c:url value="/data/entity" />" method="post">
				<input type="submit" value="Request Body and Headers" /> <span id="requestEntityTextResponse" class="responseMessage"></span>
			</form>
			<script type="text/javascript">
				$("form#requestEntity").submit(function(){
					$.ajax({ type: "POST", url: this.action, data: "foo", contentType: "text/plain", dataType: "text",
						success: function(text) {
							$("#requestEntityTextResponse").text("").fadeIn().text(text); 
						}
					});					
					return false;
				});
			</script>
		</li>
	</ul>	
	<div id="standardArgs">
		<h3>Standard Resolvable Web Arguments</h3>
		<ul>
			<li>
				<a href="<c:url value="/data/standard/request" />">Request arguments</a>					
			</li>
			<li>
				<form id="requestReader" action="<c:url value="/data/standard/request/reader" />" method="post">
					<input type="submit" value="Request Reader" /> <span id="requestReaderTextResponse" class="responseMessage"></span>		
				</form>
				<script type="text/javascript">
					$("form#requestReader").submit(function(){
						$.ajax({ type: "POST", url: this.action, data: "foo", contentType: "text/plain", dataType: "text",
							success: function(text) {
								$("#requestReaderTextResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>
			</li>			
			<li>
				<form id="requestIs" action="<c:url value="/data/standard/request/is" />" method="post">
					<input type="submit" value="Request InputStream" /> <span id="requestIsTextResponse" class="responseMessage"></span>		
				</form>
				<script type="text/javascript">
					$("form#requestIs").submit(function(){
						$.ajax({ type: "POST", url: this.action, data: "foo", contentType: "text/plain", dataType: "text",
							success: function(text) {
								$("#requestIsTextResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>
			</li>
			<li>
				<a href="<c:url value="/data/standard/response" />">Response arguments</a>					
			</li>			
			<li>
				<a href="<c:url value="/data/standard/response/writer" />">Response Writer</a>					
			</li>
			<li>
				<a href="<c:url value="/data/standard/response/os" />">Response OutputStream</a>					
			</li>
			<li>
				<a href="<c:url value="/data/standard/session" />">Session</a>					
			</li>			
		</ul>
	</div>
	<div id="customArgs">
		<h3>Custom Resolvable Web Arguments</h3>	
		<ul>
			<li>
				<a href="<c:url value="/data/custom" />">Custom</a>			
			</li>
		</ul>
	</div>
</div>
<div id="response">
	<h2>Writing Responses</h2>
	<p>
		See the <code>org.springframework.samples.mvc.response</code> package for the @Controller code
	</p>		
	<ul>
		<li>
			<a href="<c:url value="/response/annotation" />">@ResponseBody</a>			
		</li>
		<li>
			<a href="<c:url value="/response/entity/status" />">ResponseEntity (custom status)</a>			
		</li>
		<li>
			<a href="<c:url value="/response/entity/headers" />">ResponseEntity (custom headers)</a>			
		</li>
	</ul>	
</div>
<div id="messageconverters">
	<h2>Http Message Converters</h2>
	<p>
		See the <code>org.springframework.samples.mvc.messageconverters</code> package for the @Controller code
	</p>	
	<div id="stringMessageConverter">
		<h3>StringHttpMessageConverter</h3>
		<ul>
			<li>
				<form id="readString" action="<c:url value="/messageconverters/string" />" method="post">
					<input type="submit" value="Read a String" /> <span id="readStringResponse" class="responseMessage"></span>		
				</form>
				<script type="text/javascript">
					$("form#readString").submit(function(){
						$.ajax({ type: "POST", url: this.action, data: "foo", contentType: "text/plain", dataType: "text",
							success: function(text) {
								$("#readStringResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>
			</li>
			<li>
				<a id="writeString" href="<c:url value="/messageconverters/string" />">Write a String</a> <span id="writeStringResponse" class="responseMessage"></span>
				<script type="text/javascript">
					$("#writeString").click(function(){
						$.ajax({ url: this.href, dataType: "text", success: function(text) {
								$("#writeStringResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>								
			</li>
		</ul>
		<h3>FormHttpMessageConverter</h3>
		<ul>
			<li>
				<form id="readForm" action="<c:url value="/messageconverters/form" />" method="post">
					<input type="submit" value="Read a Form" /> <span id="readFormResponse" class="responseMessage"></span>		
				</form>
				<script type="text/javascript">
					$("#readForm").submit(function(){
						$.ajax({ type: "POST", url: this.action, data: "foo=bar&fruit=apple", contentType: "application/x-www-form-urlencoded", dataType: "text",
							success: function(text) {
								$("#readFormResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>
			</li>
			<li>
				<a id="writeForm" href="<c:url value="/messageconverters/form" />">Write a Form</a> <span id="writeFormResponse" class="responseMessage"></span>
				<script type="text/javascript">
					$("#writeForm").click(function(){
						$.ajax({ url: this.href, dataType: "text",
							beforeSend: function(req) { 
								req.setRequestHeader("Accept", "application/x-www-form-urlencoded");
							},							
							success: function(text) {
								$("#writeFormResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>								
			</li>
		</ul>
		<h3>Jaxb2RootElementHttpMessageConverter</h3>
		<ul>
			<li>
				<form id="readXml" action="<c:url value="/messageconverters/xml" />" method="post">
					<input type="submit" value="Read XML" /> <span id="readXmlResponse" class="responseMessage"></span>		
				</form>
				<script type="text/javascript">
					$("#readXml").submit(function(){
						$.ajax({ type: "POST", url: this.action, data: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><javaBean><foo>bar</foo><fruit>apple</fruit></javaBean>", contentType: "application/xml", dataType: "text",
							success: function(text) {
								$("#readXmlResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>
			</li>
			<li>
				<a id="writeXml" href="<c:url value="/messageconverters/xml" />">Write XML</a>
			</li>
		</ul>
		<h3>MappingJacksonHttpMessageConverter</h3>
		<ul>
			<li>
				<form id="readJson" action="<c:url value="/messageconverters/json" />" method="post">
					<input type="submit" value="Read JSON" /> <span id="readJsonResponse" class="responseMessage"></span>		
				</form>
				<script type="text/javascript">
					$("#readJson").submit(function(){
						$.ajax({ type: "POST", url: this.action, data: "{ \"foo\": \"bar\", \"fruit\": \"apple\" }", contentType: "application/json", dataType: "text",
							success: function(text) {
								$("#readJsonResponse").text("").fadeIn().text(text); 
							}
						});					
						return false;
					});
				</script>
			</li>
			<li>
				<a id="writeJson" href="<c:url value="/messageconverters/json" />">Write JSON</a> <span id="writeJsonResponse" class="responseMessage"></span>
				<script type="text/javascript">
					$("#writeJson").click(function(){
						$.ajax({ url: this.href, dataType: "json",
							success: function(json) {
								$("#writeJsonResponse").text("").fadeIn().text(JSON.stringify(json));
							}
						});					
						return false;
					});
				</script>								
			</li>
		</ul>
		<h3>AtomFeedHttpMessageConverter</h3>
		<ul>
			<li>
				<a id="writeFeed" href="<c:url value="/messageconverters/atom" />">Write Atom Feed</a> <span id="writeFeedResponse" class="responseMessage"></span>
				<script type="text/javascript">
					$("#writeFeed").click(function(){
						$.ajax({ url: this.href,
							beforeSend: function(req) { 
								req.setRequestHeader("Accept", "application/atom+xml")
							},
							success: function(feed) {
								$("#writeFeedResponse").text("").fadeIn().text($(feed).text());
							}
						});
						return false;
					});
				</script>								
			</li>
		</ul>
	</div>
</div>
<div id="views">
	<h2>Views</h2>
	<p>
		See the <code>org.springframework.samples.mvc.views</code> package for the @Controller code
	</p>
	<ul>
		<li>
			<a href="<c:url value="/views/html" />">HTML generated by JSP template</a>
		</li>
	</ul>	
	<ul>
		<li>
			<a href="<c:url value="/views/viewName" />">DefaultRequestToViewNameTranslator convention</a>
		</li>
	</ul>	
</div>
<div id="convert">
	<h2>Type Conversion</h2>
	<p>
		See the <code>org.springframework.samples.mvc.convert</code> package for the @Controller code
	</p>
	<ul>
		<li>
			<a href="<c:url value="/convert/primitive?value=3" />">Primitive</a>
		</li>
		<li>
			<a href="<c:url value="/convert/date/2010-07-04" />">Date</a>
		</li>
		<li>
			<a href="<c:url value="/convert/collection?values=1&values=2&values=3&values=4&values=5" />">Collection 1</a> (multi-value parameter)
		</li>
		<li>
			<a href="<c:url value="/convert/collection?values=1,2,3,4,5" />">Collection 2</a> (single comma-delimited parameter value)
		</li>
		<li>
			<a href="<c:url value="/convert/formattedCollection?values=2010-07-04,2011-07-04" />">@Formatted Collection</a>
		</li>		
		<li>
			<a href="<c:url value="/convert/value?value=123456789" />">Custom Value Object</a>
		</li>
	</ul>
	<div id="convert-bean">
		<h3>JavaBean Property Binding</h3>
		<ul>
			<li>
				<a href="<c:url value="/convert/bean?primitive=3" />">Primitive</a>
			</li>	
			<li>
				<a href="<c:url value="/convert/bean?date=2010-07-04" />">Date</a>
			</li>	
			<li>
				<a href="<c:url value="/convert/bean?list[0]=1&list[1]=2&list[2]=3" />">List Elements</a>
			</li>
			<li>
				<a href="<c:url value="/convert/bean?formattedList[0]=2010-07-04&formattedList[1]=2011-07-04" />">@Formatted List Elements</a>
			</li>
			<li>
				<a href="<c:url value="/convert/bean?map[0]=apple&map[1]=pear" />">Map Elements</a>
			</li>
			<li>
				<a href="<c:url value="/convert/bean?nested.foo=bar&nested.list[0].foo=baz&nested.map[key].list[0].foo=bing" />">Nested</a>
			</li>
		</ul>
	</div>
</div>
<div id="validation">
	<h2>Validation</h2>
	<p>
		See the <code>org.springframework.samples.mvc.validation</code> package for the @Controller code	
	</p>
	<ul>
		<li>
			<a href="<c:url value="/validate?number=3&date=2029-07-04" />">Validate, no errors</a>
		</li>
		<li>
			<a href="<c:url value="/validate?number=3&date=2010-07-01" />">Validate, errors</a>
		</li>
	</ul>	
</div>
<div id="exceptions">
	<h2>Exception Handling</h2>
	<p>
		See the <code>org.springframework.samples.mvc.exceptions</code> package for the @Controller code	
	</p>
	<ul>
		<li>
			<a href="<c:url value="/exception" />">@Controller Exception handling</a>
		</li>
	</ul>
</div>
</body>
</html>