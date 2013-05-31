
function process_payment() {
	//alert("You will be redirected soon")	
	$.ajax({
		type: "POST",
		url: "/payment",
		dataType: "json"
	});
}
